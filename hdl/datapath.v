`include "sys.v"
module datapath
	(
	input [31:0] instruction,
	input [31:0] odata,
	input [31:0] pc,
	input [31:0] rs1,
	input [31:0] alu_out,

	input wa_mux,
	input mem_access,
	input microop_pc_zero,
	input sys_load,
	input lui_flag,
	input jal_flag,
	input sys_load_pc,
	input mem_access_rdy,
	input store_alu,
	input load_branch,
	input load_jalr,
	input load_pc,
	input alu_rs1,
	input alu_imm_i,
	input pwrite,
	input immediate,

	output reg [31:0] APB_paddr_val,
	output reg [31:0] APB_pdata_val,
	output reg [31:0] load_pc_mux,
	output reg [31:0] write_reg_mux,
	output reg [31:0] aluRB,
	output reg [3:0] alu_op,
	output [4:0] wa);

	wire [31:0] oldpc = pc - 4;

/* Instruction operands start */
	assign wa = (wa_mux)? odata[11:7] : instruction[11:7];
	wire [2:0] sub_op = instruction[14:12];
	wire [31:0] imm_i = {{21{instruction[31]}}, instruction[30:20]};
	wire [31:0] imm_s = {{21{instruction[31]}}, instruction[30:25], instruction[11:7]};
	wire [31:0] imm_b = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
	wire [31:0] imm_u = {odata[31:12], 12'b0};
	wire [31:0] imm_j = {{12{odata[31]}}, odata[19:12], odata[20], odata[30:21], 1'b0};
/* Instruction operands end */

/* APB_paddr mux start */
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
	`always_comb_sys begin
		`unique_sys if(mem_access)
			APB_pdata_val = rs1;
		else if(sys_load)
			APB_pdata_val = pc;
		else
			APB_pdata_val = 32'bX;
	end
/* APB_pdata mux end */

/* load_pc mux start */
	`always_comb_sys begin
		`unique_sys if(jal_flag)
			load_pc_mux = oldpc + imm_j;
		else if(microop_pc_zero)
			load_pc_mux = pc + 4;
		else if (sys_load_pc)
			load_pc_mux = instruction;
		else if (load_jalr)
			load_pc_mux = alu_out;
		else if (load_branch)
			load_pc_mux = oldpc + imm_b;
		else
			load_pc_mux = 32'bX;
	end
/* load_pc mux end */

/* write_reg mux start */
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


/* ALU decode start */
	`always_comb_sys begin
		// non-imm, branch
		`unique_sys if(alu_rs1) begin
			aluRB = rs1;
		// store
		end else if (pwrite)
			aluRB = imm_s;
		// imm_i, load, jalr
		else if (alu_imm_i)
			aluRB = imm_i;
		else begin
			aluRB = 32'bX;
		end

		`unique_sys if (mem_access)
			alu_op = 4'b0000;
		// imm_i and imm
		else if ((sub_op == 5 && immediate) || (!immediate && store_alu))
			alu_op = {instruction[30],sub_op};
		else
			alu_op = {1'b0,sub_op};

	end
/* ALU decode end */

endmodule