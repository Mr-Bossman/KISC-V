/* verilator lint_off UNUSED */
/* verilator lint_off WIDTH */
/* TODO
JAL
JALR
BEQ
BNE
BLT
BGE
BLTU
BGEU
LBU
LHU
*/
module prog_counter
	(input clk,
	input rts,
	output [31:0]prc,output [31:0]odat);
	reg [31:0] pc;
	reg [31:0] regs[32];
	reg [31:0] instruction;
	reg [1:0] microop = 0;
	reg [3:0] dsize = 3;
	wire [31:0] data;
	wire [31:0] addr;
	wire [31:0] alu_out;
	reg rwr = 1;
	wire cs = 0;
	wire oe = 0;
	assign addr = (microop==0)?pc:(regs[mo_rs1]+((instruction[5])?mo_imm_s:mo_imm_i));
	assign data = (microop==2)?regs[mo_rs2]:'hz;
	sram ram(rwr,oe,cs,addr,dsize,data);
	wire ex_alu = (sub_op == 5 || op == 7'b0010011)?data[30]:0; // use extra ops for SRAI/SRA and non-imm(sub/add)
	alu alu(sub_op | (ex_alu << 4),regs[rs1],(instruction[5])?regs[rs2]:imm_i,alu_out);

	reg [31:0] opc;
	assign odat = data;
	assign prc = (microop==0)?pc:opc;

	wire [4:0] mo_rs1 = instruction[19:15];
	wire [4:0] mo_rs2 = instruction[24:20];
	wire [31:0] mo_imm_s = {{21{instruction[31]}}, instruction[30:25], instruction[11:7]};
	wire [31:0] mo_imm_i = {{21{instruction[31]}}, instruction[30:20]};
	wire [4:0] mo_rd = instruction[11:7];

	wire [6:0] op = data[6:0];
	wire [4:0] rs1 = data[19:15];
	wire [4:0] rs2 = data[24:20];
	wire [4:0] rd = data[11:7];
	wire [2:0] sub_op = data[14:12];
	wire [31:0] imm_i = {{21{data[31]}}, data[30:20]};
	wire [31:0] imm_b = {{20{data[31]}}, data[7], data[30:25], data[11:8], 1'b0};
	wire [31:0] imm_j = {{12{data[31]}}, data[19:12], data[20], data[30:21], 1'b0};
	wire [31:0] imm_u = {data[31:12], 12'b0};

	always @(posedge clk or posedge rts or negedge clk) begin
		if(rts)
			pc <= 0;
		else if(clk) begin
			if(microop == 0) begin
				opc <= pc;
				pc <= pc + 4;
				instruction <= data;
				case (op)
					7'b0000011: begin // LOAD
						microop <= 1;
						unique case (sub_op)
							2'b00: dsize <= 4'b0001;
							2'b01: dsize <= 4'b0011;
							2'b10: dsize <= 4'b1111;
							default: dsize <= 4'b1111;
						endcase
					end
					7'b0100011: begin // STORE
						rwr <= 0;
						microop <= 2;
						unique case (sub_op)
							2'b00: dsize <= 4'b0001;
							2'b01: dsize <= 4'b0011;
							2'b10: dsize <= 4'b1111;
							default: dsize <= 4'b1111;
						endcase
					end
					7'b0010011: begin // ALUI
						regs[rd] <= alu_out;
					end
					7'b0110011: begin // ALU
						regs[rd] <= alu_out;
					end
					7'b0110111: begin // LUI
						regs[rd] <= imm_u;
					end
					7'b0010111: begin // AUIPC
						regs[rd] <= imm_u + pc;
					end
					7'b1100111: begin // JALR
						pc <= {imm_i + regs[rs1][31:1], 1'b0}; // fixme
						regs[rd] <=  {imm_i + regs[rs1][31:1], 1'b0} + 4;
					end
					7'b1101111: begin // JAL
						pc <= imm_j + pc + 4; // fixme
						regs[rd] <=  pc + 4;
					end
					default:;
				endcase
			end else if (microop == 1) begin
				regs[mo_rd] <= data;
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
