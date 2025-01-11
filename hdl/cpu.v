`include "sys.v"
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

	wire [31:0] pc;
	reg [3:0] op_jmp;
	wire [31:0] instruction = (load_insr)?APB_prdata:saved_instruction;
	reg [31:0] saved_instruction;
	reg halt = 0;
	assign halted = halt;

/* ALU start */
	wire [31:0] alu_out;
	wire [31:0] aluRB;
	wire [3:0] alu_op;
	wire cmp_flag;
	alu alunit(alu_op,rs0,aluRB,alu_out,cmp_flag);
/* ALU end */

/* Regfile start*/
	/* we can use the same bus for APB_pdata_val and write_reg_mux */
	wire [31:0] write_reg_APB_pdata = (write_reg)?write_reg_mux:((load_pdata)?APB_pdata_val:32'bX);

	wire [4:0]ra0;
	wire [4:0]ra1;
	wire [4:0]wa;
	wire [31:0]rs0;
	wire [31:0]rs1;
	regfile rfile(APB_PCLK,
	wa,ra0,ra1,

	write_reg,read_reg,

	write_reg_APB_pdata,
	rs0,rs1
	);
/* Regfile end*/

initial begin
	APB_paddr = 0;
	halt = 0;
	saved_instruction = 0;
end

/* control_unit start */
	wire system_mem = pc > 'h1000;
	wire load_paddr;
	wire load_pdata;
	wire load_pc;
	wire load_insr;
	wire write_reg;
	wire read_reg;
	wire mem_access;
	wire microop_pc_zero;
	wire sys_load;
	wire lui_flag;
	wire jal_flag;
	wire sys_load_pc;
	wire alu_flag;
	wire load_branch;
	wire load_jalr;
	wire pwrite;
	wire alu_rs1;
	wire alu_imm_i;

	// alu immediate
	wire immediate = op == 7'b0010011;

	control_unit cunit(APB_PCLK,APB_PRESETn,APB_psel,APB_penable,APB_pwrite,
	APB_pready,APB_perr,interrupt,system_mem,op_jmp,cmp_flag,immediate,

	load_paddr,load_pdata,load_pc,load_insr, write_reg, read_reg,

	mem_access,microop_pc_zero,sys_load,lui_flag,jal_flag,
	sys_load_pc,alu_flag,load_branch,
	load_jalr,pwrite,alu_rs1,alu_imm_i
	);
/* control_unit end */

/* datapath start */
	wire [31:0] APB_paddr_val;
	wire [31:0] APB_pdata_val;
	wire [31:0] load_pc_mux;
	wire [31:0] write_reg_mux;

	datapath dpath(instruction,APB_prdata,pc,rs1,alu_out,

	mem_access,microop_pc_zero,sys_load,lui_flag,jal_flag,sys_load_pc,
	alu_flag,load_branch,load_jalr,load_pc,alu_rs1,alu_imm_i, pwrite,immediate,

	APB_paddr_val,APB_pdata_val,load_pc_mux,write_reg_mux,aluRB,alu_op);
/* datapath end */

/* Instruction operands start */
	wire [6:0] op = instruction[6:0];
	wire [1:0] sub_op_2bit = instruction[13:12];
	assign wa = instruction[11:7];
	assign ra0 = instruction[19:15];
	assign ra1 = instruction[24:20];
/* Instruction operands end */

/* Read/Write mask */

	reg [3:0] dsize;
	/* APB spec dissalows read Byte mask */
	assign APB_pstb = (APB_pwrite)?dsize:4'b1111;

	`always_comb_sys begin
		if(mem_access) begin
			`unique_sys case (sub_op_2bit)
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

/* debug start */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTH */
	wire not_use = APB_perr;
	assign odat = 'h0;
	assign opc = pc - 4;
/* verilator lint_on WIDTH */
/* verilator lint_on UNUSEDSIGNAL */
/* debug end */

/* Decode instruction groups start */
	`always_comb_sys begin
		`unique_sys casez (instruction[6:0])
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
/* Decode instruction groups end */

/* Program counter start */
	wire increment = load_pc && microop_pc_zero;
	wire load_pcounter = load_pc && !microop_pc_zero;
programcounter pcounter(APB_PCLK, APB_PRESETn, halt, increment, load_pcounter, load_pc_mux, pc);
/* Program counter end */

/* CPU start */
	`always_ff_sys @(posedge APB_PCLK) begin
		if(!APB_PRESETn) begin
			APB_paddr <= 0;
			halt <= 0;
			saved_instruction <= 0;
		end else if(!halt) begin

			if(load_paddr) begin
				APB_paddr <= APB_paddr_val;
				if (APB_paddr_val === 32'bX)
					$display("APB_paddr_val is undefined");
			end

			if(load_pdata) begin
				APB_pdata <= write_reg_APB_pdata;
				if (APB_pdata_val === 32'bX)
					$display("APB_pdata_val is undefined");
			end

			if (load_pcounter) begin
				//pc <= load_pc_mux;
				if (load_pc_mux[1:0] != 2'b00)
					$display("load_pc_mux is not aligned");
				if (load_pc_mux === 32'bX)
					$display("load_pc_mux is undefined");
			end

			if (load_insr) begin
				saved_instruction <= APB_prdata;
				if (APB_prdata === 32'bX)
					$display("instruction is undefined");
			end

			if (write_reg) begin
				if (write_reg_mux === 32'bX)
					$display("write_reg_mux is undefined");
			end

			if(load_insr && APB_prdata == 32'b0)
				halt <= 1;

		end
	end
/* CPU end */
endmodule
