module cpu
	#(parameter ADDR_WIDTH = 32,
	  parameter DATA_WIDTH = 32)
	(input clk,
	output reg [ADDR_WIDTH-1:0] APB_paddr,
	output reg [DATA_WIDTH-1:0] APB_pdata,
	input [DATA_WIDTH-1:0]  APB_prdata,
	output APB_psel,
	output APB_penable,
	output APB_pwrite,
	output [3:0] APB_pstb,
	input APB_pready,
	input APB_perr,
	input interrupt,
	input rts, output halted,
	output [31:0]odat,output reg [31:0] oldpc);
	reg [31:0] pc;
	reg [31:0] instruction;
	reg [31:0] systmp;
	reg halt = 0;
	assign halted = halt;

/* Regfile start*/
	wire [4:0]ra0;
	wire [4:0]ra1;
	wire [4:0]wa;
	wire [31:0]rd0;
	wire [31:0]rd1;
	reg [31:0] regfile[31:0];

	assign rd0 = ra0 == 5'b0 ? 0 : regfile[ra0];
	assign rd1 = ra1 == 5'b0 ? 0 : regfile[ra1];
/* Regfile end*/

	reg [7:0] microop_pc = 0;
	reg [23:0] microop_prog[0:128];
	reg [23:0] microop;

	wire [31:0] alu_out;

/* AHB start */
	assign APB_psel = microop[0];
	assign APB_penable = microop[1];
	assign APB_pwrite = microop[2];
	reg [3:0] dsize = 4'b1111;
	/* APB spec dissalows read Byte mask */
	assign APB_pstb = (APB_pwrite)?dsize:4'b1111;

	reg [31:0] odata;
/* AHB end */
/* flags start */
	wire load_insr = microop[3];
	wire mem_access = microop[4];
	wire alu_flags = microop[5];
	wire load_pc = microop[6];
	wire sys_load = microop[7];
	wire store_alu = microop[8];
	/* These happen in the same cycle as load_insr */
	wire lui_flag = (load_insr)?microop_prog[op_jmp][9]:0;
	wire jal_flag = (load_insr)?microop_prog[op_jmp][10]:0;
	wire cmp_flag;
/* flags end */
initial begin
	$readmemh("microop.vh", microop_prog);
end

	assign ra0 = instruction[19:15];
	assign ra1 = instruction[24:20];
	assign wa = instruction[11:7];
	wire [6:0] op = instruction[6:0];
	wire [2:0] sub_op = instruction[14:12];
	wire [31:0] imm_s = {{21{instruction[31]}}, instruction[30:25], instruction[11:7]};
	wire [31:0] imm_i = {{21{instruction[31]}}, instruction[30:20]};
	wire [31:0] imm_b = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};

/* READ byte mask start */
	integer i;
	always_comb begin
		for( i = 0; i <= (32/8)-1;i = i + 1) begin
			if(dsize[i]) odata[8*i+:8] = APB_prdata[8*i+:8];
			else odata[8*i+:8] = 8'b0;
		end
	end
/* READ byte mask end */

/* debug start */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTH */
	wire not_use = interrupt;
	assign odat = microop;
/* verilator lint_on WIDTH */
/* verilator lint_on UNUSEDSIGNAL */
/* debug end */
	wire ex_alu = (sub_op == 5 || op == 7'b0110011)?instruction[30]:0; // use extra ops for SRAI/SRA and non-imm(sub/add)
	// use add imm for 1100111 AKA JALR
	alu alu({ex_alu,sub_op},rd0,(instruction[5] && op != 7'b1100111)?rd1:imm_i,alu_out,cmp_flag);

	wire [31:0] imm_j = {{12{odata[31]}}, odata[19:12], odata[20], odata[30:21], 1'b0};
	wire [31:0] imm_u = {odata[31:12], 12'b0};

/* Decode instruction groups start */
	reg[7:0] op_jmp;
	always_comb begin
		casez (odata[6:0])
			7'b0100011: begin // STORE
				op_jmp = 1*8;
			end
			7'b0000011: begin // LOAD
				op_jmp = 2*8;
			end
			7'b0?10111: begin //LUI/AUIPC
				op_jmp = 7*8;
			end
			7'b0?10011: begin // ALU
				op_jmp = 4*8;
			end
			7'b1101111: begin // JAL
				op_jmp = 8*8;
			end
			7'b1100111: begin // JALR
				op_jmp = 5*8;
			end
			7'b1100011: begin // BRANCH
				op_jmp = 6*8;
			end
			7'b1110011: begin // SYSTEM
				op_jmp = 3*8;
			end
			default: begin // SYSTEM
				op_jmp = 3*8;
			end
		endcase
	end
/* Decode instruction groups end */

	always @(posedge clk or posedge rts) begin
		if(rts) begin
			pc <= 0;
			APB_paddr <= 0;
			microop <= 0;
			halt <= 0;
		end else if(!halt) begin
			// TODO: do trap
			if(APB_perr) halt <= 1;
			if(load_insr) begin
				instruction <= odata;
				if(odata == 32'b0) halt <= 1;
				microop_pc <= microop_prog[op_jmp][23:16];
				microop <= microop_prog[op_jmp];
			end
			// halt till APB_pready is ready
			else if(!(APB_penable && APB_psel && !APB_pready)) begin
				microop_pc <= microop_prog[microop_pc][23:16];
				microop <= microop_prog[microop_pc];
				if(microop[23:16] == 0) begin
					instruction <= 0;
					APB_paddr <= pc;
					pc <= pc + 4;
					dsize <= 4'b1111;
					oldpc <= pc;
				end
			end
			if(lui_flag) begin
				regfile[odata[11:7]] <= imm_u + ((odata[5])?0:pc-4);
			end
			/* TODO: not working */
			if(jal_flag) begin
				regfile[odata[11:7]] <= pc;
				pc <= pc + imm_j - 4;
			end
			if(mem_access) begin
				unique case (sub_op[1:0])
					2'b00: dsize <= 4'b0001;
					2'b01: dsize <= 4'b0011;
					2'b10: dsize <= 4'b1111;
					default: dsize <= 4'b1111;
				endcase
				APB_paddr <= ((APB_pwrite)?imm_s:imm_i) + rd0;
				APB_pdata <= rd1;
				if(APB_penable && APB_psel && APB_pready && !APB_pwrite) begin
					if(sub_op[2] == 1'b0) begin
						unique case (sub_op[1:0])
							2'b00: regfile[wa] <= {{24{odata[7]}},odata[7:0]};
							2'b01: regfile[wa] <= {{16{odata[15]}},odata[15:0]};
							2'b10: regfile[wa] <= odata;
							default: regfile[wa] <= odata;
						endcase
					end else
						regfile[wa] <= odata;
				end
			end
			if(sys_load) begin
				APB_paddr <= 4;
				APB_pdata <= pc;
				if(APB_penable && APB_psel && APB_pready && APB_pwrite) begin
					pc <= systmp;
				end
				if(APB_penable && APB_psel && APB_pready && !APB_pwrite) begin
					systmp <= odata;
				end
			end
			if(store_alu) regfile[wa] <= alu_out;
			if(alu_flags && cmp_flag) pc <= imm_b + pc - 4;
			if(load_pc) begin
				regfile[wa] <= pc;
				pc <= alu_out;
			end
		end
	end
endmodule
