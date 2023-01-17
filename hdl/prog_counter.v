/* verilator lint_off UNUSED */
/* verilator lint_off WIDTH */

module prog_counter
	(input clk,
	input rts,
	output [31:0]prc,output [31:0]odat);
	reg [31:0] pc;
	reg [31:0] opc;
	reg [31:0] regs[32];
	reg [31:0] instruction;
	reg [31:0] temp = 1000;
	reg [1:0] microop = 0;
	reg [1:0] dsize = 3;
	wire [31:0] data;
	wire [31:0] addr;
	reg rwr = 1;
	wire cs = 0;
	wire oe = 0;
	assign prc = (microop==0)?pc:opc;
	assign addr = (microop==0)?pc:(regs[rs1]+((instruction[5])?imm_s:imm_i));
	assign data = (microop==2)?regs[rs2]:'hz;
	sram ram(rwr,oe,cs,addr,dsize,data);
	assign odat = data;

	wire [6:0] op = instruction[6:0];
	wire [2:0] sub_op = data[14:12];
	wire [4:0] rs1 = instruction[19:15];
	wire [4:0] rs2 = instruction[24:20];
	wire [4:0] rd = instruction[11:7];
	wire [31:0] imm_i = {{21{instruction[31]}}, instruction[30:20]};
	wire [31:0] imm_b = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
	wire [31:0] imm_j = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
	wire [31:0] imm_u = {instruction[31:12], 12'b0};
	wire [31:0] imm_s = {{21{instruction[31]}}, instruction[30:25], instruction[11:7]};

	always @(posedge clk or posedge rts or negedge clk) begin
		if(rts)
			pc <= 0;
		else if(clk) begin
			if(microop == 0) begin
				opc <= pc;
				pc <= pc + 1;
				instruction <= data;
				case (data[6:0])
					7'b0000011: begin
						microop <= 1;
						dsize <= (sub_op==2)?3:sub_op;
					end
					7'b0100011: begin
						rwr <= 0;
						microop <= 2;
						dsize <= (sub_op==2)?3:sub_op;
					end
					default:;
				endcase
			end else if (microop == 1) begin
				regs[rd] <= data;
				microop <= 0;
				dsize <= 3;
			end else if (microop == 2) begin
				microop <= 0;
				dsize <= 3;
			end
		end else begin
			rwr <= 1;
		end
	end

endmodule
