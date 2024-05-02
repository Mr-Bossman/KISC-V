`include "sys.v"
module control_unit
	(input APB_PCLK,
	input APB_PRESETn,
	output APB_psel,
	output APB_penable,
	output APB_pwrite,
	input APB_pready,
	input APB_perr,
	input interrupt,
	input system_mem,
	input [3:0]op_jmp,
	input cmp_flag,
	input immediate,

	output load_paddr,
	output load_pdata,
	output load_pc,
	output load_insr,
	output reg write_reg,
	output reg read_reg,

	output mem_access,
	output microop_pc_zero,
	output sys_load,
	output lui_flag,
	output jal_flag,
	output sys_load_pc,
	output mem_access_rdy,
	output store_alu,
	output load_branch,
	output load_jalr,
	output pwrite,
	output alu_rs1,
	output alu_imm_i);

/* Microcode start */
	reg [15:0] microop_prog[0:127];
	reg [15:0] microop;
	wire [6:0] microop_pc = microop[14:8];
	reg [6:0] microop_addr;

initial begin
	microop = 0;
`ifdef HAS_APB_PENABLE
	$readmemh("microop.hex", microop_prog);
`else
	$readmemh("microop_no_en.hex", microop_prog);
`endif
end
/* Microcode end */


/* debug start */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTH */
	wire not_use = APB_perr | microop;
/* verilator lint_on WIDTH */
/* verilator lint_on UNUSEDSIGNAL */
/* debug end */

/* APB start */
`ifdef HAS_APB_PENABLE
	reg APB_psel_1clk;
	assign APB_penable = APB_psel && APB_psel_1clk;
`else
	assign APB_penable = APB_psel;
`endif

	assign APB_psel = microop[0];
	assign pwrite = microop[1];
	assign APB_pwrite = (pwrite && APB_psel);

	/* If we are done reading or writing this is high*/
	wire APB_done = APB_penable && APB_psel && APB_pready;
	/* If we are not done reading or writing this is high*/
	/* only need !(APB_penable && APB_psel) || APB_pready; */
	wire APB_Dready = !(APB_penable && APB_psel) || APB_pready;
/* APB end */



/* flags start */
	wire load_insr_microop = microop[2];
	assign mem_access = microop[3];
	wire alu_flags = microop[4];
	wire load_pc_microop = microop[5];
	assign sys_load = microop[6];
	assign store_alu = microop[7];
	assign microop_pc_zero = (microop_pc == 0);

	wire sys_load_rdy = sys_load && APB_done;
	wire load_insr_rdy = load_insr_microop && APB_Dready;

	assign mem_access_rdy = mem_access && APB_done && !APB_pwrite;

	assign load_paddr = sys_load || mem_access || microop_pc_zero;
	assign load_pdata = sys_load || mem_access;

	assign load_insr = load_insr_rdy || (sys_load_rdy && !APB_pwrite);

	assign sys_load_pc = sys_load_rdy && pwrite;
	wire load_pc_microop_true = load_pc_microop && (alu_flags && cmp_flag || !alu_flags);
	assign load_pc = (jal_flag && load_insr_microop && APB_Dready) || (microop_pc_zero || load_pc_microop_true || sys_load_pc);

	assign load_jalr = load_pc_microop && !alu_flags;
	assign load_branch =load_pc_microop && alu_flags && cmp_flag;

	// non-imm, branch
	assign alu_rs1 = (!immediate && store_alu) || alu_flags;

	// imm_i, load, jalr
	assign alu_imm_i = (immediate && store_alu) || (!pwrite && mem_access) || load_jalr;
	/* These happen in the same cycle as load_insr_microop */
/*
	wire lui_flag = (load_insr_microop)?microop_prog[op_jmp][9]:0;
	wire jal_flag = (load_insr_microop)?microop_prog[op_jmp][10]:0;
*/
	/* Microcode reads need to be synchronous */
	assign lui_flag = (load_insr_microop && op_jmp == (0 | 7));
	assign jal_flag = (load_insr_microop && op_jmp == (8 | 7));
/* flags end */


/* write_reg start */
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

/* APB_penable start */
`ifdef HAS_APB_PENABLE
	`always_ff_sys @(posedge APB_PCLK) begin
		APB_psel_1clk <= APB_psel;
	end
`endif
/* APB_penable end */


/* Microop PC start */
	`always_comb_sys begin
		`unique_sys if(load_insr_microop)
			microop_addr = {op_jmp[2:0], microop_pc[3:0]};
		/* Don't interrupt if we are in the interrupt handler */
		else if(microop_pc_zero && interrupt && system_mem)
`ifdef HAS_APB_PENABLE
			microop_addr = 3*16 + 2; // System
`else
			microop_addr = 3*16 + 1; // System
`endif
		else
			microop_addr = microop_pc;
	end
/* Microop PC end */

/* microcode start */
	`always_ff_sys @(posedge APB_PCLK) begin
		if(APB_PRESETn == 0) begin
			microop <= 0;
		end else begin
			// halt till APB_Dready is ready
			if(APB_Dready)
				microop <= microop_prog[microop_addr];
		end
	end
/* microcode end */

endmodule
