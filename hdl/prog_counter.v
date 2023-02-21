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
	output [31:0]odat,output [31:0] res);

	reg [31:0] pc = 0;
	reg [31:0] instruction;
	reg [3:0] dsize = 4'b1111;

	wire [4:0]ra0;
	wire [4:0]ra1;
	wire [4:0]wa;
	reg [31:0]wd;
	wire [31:0]rd0;
	wire [31:0]rd1;

	reg [3:0] microop_pc = 0;
	reg [7:0] microop_prog[0:15];
	reg [7:0] microop;

	reg [31:0] data = 0;
	wire [31:0] odata;
	reg [31:0] addr;
	// wire [31:0] alu_out;

	reg wr = 0;
	wire APB_en;
	wire APB_sel;
	wire APB_ready;
	wire APB_wr;
	wire load_insr;
	wire mem_access;
	assign APB_sel = microop[0];
	assign APB_en = microop[1];
	assign APB_wr = microop[2];
	assign load_insr = microop[3];
	assign mem_access = microop[4];

initial begin
	$readmemh("microop.vh", microop_prog);
end

	//assign addr = (microop==0)?pc:(regs[mo_rs1]+((instruction[5])?mo_imm_s:mo_imm_i));
//	assign data = (microop==2)?regs[mo_rs2]:'hz;
	regfile regs(clk,ra0,ra1,wa,wd,rd0,rd1);
	assign ra0 = instruction[19:15];
	assign ra1 = instruction[24:20];
	assign wa = instruction[11:7];
	sram ram(clk,addr,data,odata,APB_sel,APB_en,APB_wr,dsize,APB_ready);

	assign odat = wd;
	assign res = rd0;
	//wire ex_alu = (sub_op == 5 || op == 7'b0010011)?data[30]:0; // use extra ops for SRAI/SRA and non-imm(sub/add)
	//alu alu(sub_op | (ex_alu << 4),regs[rs1],(instruction[5])?regs[rs2]:imm_i,alu_out);

	//reg [31:0] opc;
//	assign odat = data;
//assign prc = (microop==0)?pc:opc;
	wire [2:0] sub_op = instruction[14:12];

	// wire [4:0] mo_rs1 = instruction[19:15];
	// wire [4:0] mo_rs2 = instruction[24:20];
	// wire [31:0] mo_imm_s = {{21{instruction[31]}}, instruction[30:25], instruction[11:7]};
	wire [31:0] imm_i = {{21{instruction[31]}}, instruction[30:20]};
	// wire [4:0] mo_rd = instruction[11:7];

	wire [6:0] op = instruction[6:0];
	//wire [4:0] rs1 = odata[19:15];
	//wire [4:0] rs2 = odata[24:20];
	//ire [4:0] rd = odata[11:7];
	//wire [2:0] sub_op = odata[14:12];
	//wire [31:0] imm_i = {{21{odata[31]}}, odata[30:20]};
	// wire [31:0] imm_b = {{20{data[31]}}, data[7], data[30:25], data[11:8], 1'b0};
	// wire [31:0] imm_j = {{12{data[31]}}, data[19:12], data[20], data[30:21], 1'b0};
	// wire [31:0] imm_u = {data[31:12], 12'b0};

	always @(posedge clk or posedge rts) begin
		if(rts)
			pc <= 0;
		else if(clk) begin
			if(load_insr) begin
				instruction <= odata;
				case (odata[6:0])
					7'b0000011: begin // LOAD
						microop_pc <= 8;
						microop <= microop_prog[8];
					end
					default:microop <= 0;
				endcase
			end
			// halt till APB_ready is ready
			else if(!(APB_en && APB_sel && !APB_ready)) begin
				if(microop) begin
					microop_pc <= microop_pc + 1;
					microop <= microop_prog[microop_pc + 1];
				end else begin
					microop_pc <= 0;
					addr <= pc;
					pc <= pc + 1;
					dsize <= 4'b1111;
					microop <= microop_prog[0];
				end
			end
			if(mem_access) begin
				case (op)
					7'b0000011: begin // LOAD
						unique case (sub_op)
							2'b00: dsize <= 4'b0001;
							2'b01: dsize <= 4'b0011;
							2'b10: dsize <= 4'b1111;
							default: dsize <= 4'b1111;
						endcase
						addr <= imm_i + rd0;
						if(APB_en && APB_sel && APB_ready)
							wd <= odata;
					end
					default:microop <= 0;
				endcase
			end

		end
	end

endmodule
