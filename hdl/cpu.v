`include "sys.v"
`define HAS_APB_PENABLE
module cpu
	#(parameter ADDR_WIDTH = 32,
	  parameter DATA_WIDTH = 32)
	(input APB_PCLK,
	input APB_PRESETn,
	output reg [ADDR_WIDTH-1:0] APB_paddr,
	output reg [DATA_WIDTH-1:0] APB_pdata,
	input [DATA_WIDTH-1:0] APB_prdata,
	output APB_psel,
	output APB_penable,
	output APB_pwrite,
	output [3:0] APB_pstb,
	input APB_pready,
	input APB_perr,
	input interrupt,
	output halted,
	output [31:0] odat,
	output [31:0] opc);
	reg [31:0] pc;
	wire [31:0] oldpc = pc - 4;
	assign opc = oldpc;
	/* We dont use ra0 or ra1 */
	reg [31:0] instruction;
	reg halt = 0;
	assign halted = halt;

/* ALU start */
	wire [31:0] alu_out;
	reg [31:0] aluRB;
	reg [3:0] alu_op;
	wire cmp_flag;
/* ALU end */

/* Regfile start*/
	wire [4:0]ra0;
	wire [4:0]ra1;
	wire [4:0]wa;
	reg [31:0]rd0;
	reg [31:0]rd1;
	reg [31:0] regfile[31:0];
/* Regfile end*/

/* Microcode start */
	reg[3:0] op_jmp;
	reg [15:0] microop_prog[0:127];
	reg [15:0] microop;
	wire [6:0] microop_pc = microop[14:8];
	reg [6:0] microop_addr;
integer b;
initial begin
	pc = 0;
	APB_paddr = 0;
	microop = 0;
	halt = 0;
	instruction = 0;
	for (b = 0; b < 32; b = b + 1) begin
		regfile[b] = 0;
	end
`ifdef HAS_APB_PENABLE
	$readmemh("microop.hex", microop_prog);
`else
	$readmemh("microop_no_en.hex", microop_prog);
`endif
end
/* Microcode end */

/* APB start */
`ifdef HAS_APB_PENABLE
	reg APB_psel_1clk;
	assign APB_penable = APB_psel && APB_psel_1clk;
`else
	assign APB_penable = APB_psel;
`endif
	assign APB_psel = microop[0];
	wire pwrite = microop[1];
	assign APB_pwrite = (pwrite && APB_psel);
	reg [3:0] dsize;
	/* APB spec dissalows read Byte mask */
	assign APB_pstb = (APB_pwrite)?dsize:4'b1111;
	/* If we are done reading or writing this is high*/
	wire APB_done = APB_penable && APB_psel && APB_pready;
	/* If we are not done reading or writing this is high*/
	/* only need !(APB_penable && APB_psel) || APB_pready; */
	wire APB_Dready = !(APB_penable && APB_psel) || APB_pready;
	reg [31:0] odata;
/* APB end */

/* flags start */
	wire load_insr_microop = microop[2];
	wire mem_access = microop[3];
	wire alu_flags = microop[4];
	wire load_pc_microop = microop[5];
	wire sys_load = microop[6];
	wire store_alu = microop[7];
	wire microop_pc_zero = (microop_pc == 0);

	wire sys_load_rdy = sys_load && APB_done;
	wire load_insr_rdy = load_insr_microop && APB_Dready;

	wire mem_access_rdy = mem_access && APB_done && !APB_pwrite;

	wire load_paddr = sys_load || mem_access || microop_pc_zero;
	wire load_pdata = sys_load || mem_access;

	wire load_insr = load_insr_rdy || (sys_load_rdy && !APB_pwrite);

	wire sys_load_pc = sys_load_rdy && pwrite;
	wire load_pc_microop_true = load_pc_microop && (alu_flags && cmp_flag || !alu_flags);
	wire load_pc = (jal_flag && load_insr_microop && APB_Dready) || (microop_pc_zero || load_pc_microop_true || sys_load_pc);

	/* These happen in the same cycle as load_insr_microop */
/*
	wire lui_flag = (load_insr_microop)?microop_prog[op_jmp][9]:0;
	wire jal_flag = (load_insr_microop)?microop_prog[op_jmp][10]:0;
*/
	/* Microcode reads need to be synchronous */
	wire lui_flag = (load_insr_microop && op_jmp == (0 | 7));
	wire jal_flag = (load_insr_microop && op_jmp == (8 | 7));
/* flags end */

/* Instruction operands start */
	wire [31:0] imm_j = {{12{odata[31]}}, odata[19:12], odata[20], odata[30:21], 1'b0};
	wire [31:0] imm_u = {odata[31:12], 12'b0};
	assign ra0 = odata[19:15];
	assign ra1 = odata[24:20];
	assign wa = (load_insr_microop || load_pc_microop)? odata[11:7] : instruction[11:7];
	wire [6:0] op = instruction[6:0];
	wire [2:0] sub_op = instruction[14:12];
	wire [31:0] imm_s = {{21{instruction[31]}}, instruction[30:25], instruction[11:7]};
	wire [31:0] imm_i = {{21{instruction[31]}}, instruction[30:20]};
	wire [31:0] imm_b = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
/* Instruction operands end */

/* Read/Write mask */
	`always_comb_sys begin
		if(mem_access) begin
			`unique_sys case (sub_op[1:0])
				2'b00: dsize = 4'b0001;
				2'b01: dsize = 4'b0011;
				2'b10: dsize = 4'b1111;
				/* TODO: below is invalid */
				default: dsize = 4'b1111;
			endcase
		end else
			dsize = 4'b1111;
	end
/* Read/Write mask end */
/* READ byte mask start */
	integer i;
	`always_comb_sys begin
		for( i = 0; i <= (32/8)-1;i = i + 1) begin
			if(dsize[i]) odata[8*i+:8] = APB_prdata[8*i+:8];
			else odata[8*i+:8] = 8'b0;
		end
	end
/* READ byte mask end */

/* debug start */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTH */
	wire not_use = APB_perr;
	assign odat = microop;
/* verilator lint_on WIDTH */
/* verilator lint_on UNUSEDSIGNAL */
/* debug end */

/* ALU decode start */
	`always_comb_sys begin
		// use add imm for 1100111 AKA JALR
		`unique_sys if(instruction[5] && op != 7'b1100111 && !mem_access)
			aluRB = rd1;
		else if (pwrite && mem_access)
			aluRB = imm_s;
		else
			aluRB = imm_i;

		// use extra ops for SRAI/SRA and non-imm(sub/add)
		`unique_sys if (mem_access)
			alu_op = 4'b0000;
		else if (!mem_access && (sub_op == 5 || op == 7'b0110011))
			alu_op = {instruction[30],sub_op};
		else
			alu_op = {1'b0,sub_op};

	end
	alu alu(alu_op,rd0,aluRB,alu_out,cmp_flag);
/* ALU decode end */

/* Decode instruction groups start */
	`always_comb_sys begin
		`unique_sys casez (odata[6:0])
			7'b0100011: begin // STORE
				op_jmp = 1;
			end
			7'b0000011: begin // LOAD
				op_jmp = 2;
			end
			7'b0?10111: begin //LUI/AUIPC
				op_jmp = 0 | 7;
			end
			7'b0?10011: begin // ALU
				op_jmp = 4;
			end
			7'b1101111: begin // JAL
				op_jmp = 8 | 7;
			end
			7'b1100111: begin // JALR
				op_jmp = 5;
			end
			7'b1100011: begin // BRANCH
				op_jmp = 6;
			end
			7'b1110011: begin // SYSTEM
				op_jmp = 3;
			end
			default: begin // SYSTEM
				op_jmp = 3;
			end
		endcase
	end

/* Microop PC start */
	`always_comb_sys begin
		`unique_sys if(load_insr_microop)
			microop_addr = {op_jmp[2:0], microop_pc[3:0]};
		/* Don't interrupt if we are in the interrupt handler */
		else if(microop_pc_zero && interrupt && pc > 'h1000)
`ifdef HAS_APB_PENABLE
			microop_addr = 3*16 + 2; // System
`else
			microop_addr = 3*16 + 1; // System
`endif
		else
			microop_addr = microop_pc;
	end
/* Microop PC end */
/* Decode instruction groups end */

/* APB_paddr mux start */
	reg [31:0] APB_paddr_val;
	`always_comb_sys begin
		`unique_sys if(microop_pc_zero)
			APB_paddr_val = pc;
		else if(mem_access)
			APB_paddr_val = alu_out;
		else if(sys_load)
			APB_paddr_val = 4;
		else
			APB_paddr_val = 32'bX;
	end
/* APB_paddr mux end */

/* APB_pdata mux start */
	reg [31:0] APB_pdata_val;
	`always_comb_sys begin
		`unique_sys if(mem_access)
			APB_pdata_val = rd1;
		else if(sys_load)
			APB_pdata_val = pc;
		else
			APB_pdata_val = 32'bX;
	end
/* APB_pdata mux end */

/* load_pc mux start */
	reg [31:0] load_pc_mux;
	`always_comb_sys begin
		`unique_sys if(jal_flag)
			load_pc_mux = oldpc + imm_j;
		else if(microop_pc_zero)
			load_pc_mux = pc + 4;
		else if (sys_load_pc)
			load_pc_mux = instruction;
		else if (load_pc_microop && !alu_flags)
			load_pc_mux = alu_out;
		else if (load_pc_microop && alu_flags && cmp_flag)
			load_pc_mux = oldpc + imm_b;
		else
			load_pc_mux = 32'bX;
	end
/* load_pc mux end */

/* write_reg start */
	reg write_reg;
	reg read_reg;
	`always_comb_sys begin
		`unique_sys if(load_insr_rdy) begin
			`unique_sys if(lui_flag || jal_flag) begin
				read_reg = 0;
				write_reg = 1;
			end else begin
				read_reg = 1;
				write_reg = 0;
			end
		end else begin
			read_reg = 0;
			/* `unique_sys is broken in verilator */
			if(mem_access_rdy)
				write_reg = 1;
			else if(store_alu)
				write_reg = 1;
			else if(load_pc_microop && !alu_flags)
				write_reg = 1;
			else
				write_reg = 0;
		end
	end
/* write_reg end */

/* write_reg mux start */
	reg [31:0] write_reg_mux;
	`always_comb_sys begin
		`unique_sys if (store_alu)
			write_reg_mux = alu_out;
		else if (load_pc || jal_flag)
			write_reg_mux = pc;
		else if (mem_access_rdy) begin
			if(sub_op[2] == 1'b0) begin
				case (sub_op[1:0])
					2'b00: write_reg_mux = {{24{odata[7]}},odata[7:0]};
					2'b01: write_reg_mux = {{16{odata[15]}},odata[15:0]};
					2'b10: write_reg_mux = odata;
					default: write_reg_mux = odata;
				endcase
			end else
				write_reg_mux = odata;
		end
		else if (lui_flag)
			write_reg_mux = imm_u + ((odata[5])? 0 : oldpc);
		else
			write_reg_mux = 32'bX;
	end
/* write_reg mux end */

/* APB_penable start */
`ifdef HAS_APB_PENABLE
	`always_ff_sys @(posedge APB_PCLK) begin
		APB_psel_1clk <= APB_psel;
	end
`endif
/* APB_penable end */

/* CPU start */
	`always_ff_sys @(posedge APB_PCLK) begin
		if(!APB_PRESETn) begin
			pc <= 0;
			APB_paddr <= 0;
			microop <= 0;
			halt <= 0;
			instruction <= 0;
		end else if(!halt) begin

			// halt till APB_Dready is ready
			if(APB_Dready)
				microop <= microop_prog[microop_addr];

			if(load_paddr)
				APB_paddr <= APB_paddr_val;

			if(load_pdata)
				APB_pdata <= APB_pdata_val;

			if (load_pc)
				pc <= load_pc_mux;

			if (load_insr)
				instruction <= odata;

			if(write_reg)
				regfile[wa] <= write_reg_mux;

			if(load_insr_rdy && odata == 32'b0)
				halt <= 1;

			if (read_reg) begin
				rd0 <= ra0 == 5'b0 ? 0 : regfile[ra0];
				rd1 <= ra1 == 5'b0 ? 0 : regfile[ra1];
			end
		end
	end
/* CPU end */
endmodule
