`include "sys.v"
module regfile (
	input APB_PCLK,
	input [4:0] wa,
	input [4:0] ra0,
	input [4:0] ra1,

	input write_reg,
	input read_reg,

	input [31:0] rd0,

	output [31:0] rs0,
	output [31:0] rs1
	);

/* Regfile start*/
	reg [31:0]rs0_reg;
	reg [31:0]rs1_reg;
	reg [31:0] regfile_mem[31:0];
	assign rs0 = rs0_reg;
	assign rs1 = rs1_reg;
/* Regfile end*/

integer b;
initial begin
	for (b = 0; b < 32; b = b + 1) begin
		regfile_mem[b] = 0;
	end
end


	`always_ff_sys @(posedge APB_PCLK) begin
		if(write_reg)
			regfile_mem[wa] <= rd0;

		if (read_reg) begin
			rs0_reg <= ra0 == 5'b0 ? 0 : regfile_mem[ra0];
			rs1_reg <= ra1 == 5'b0 ? 0 : regfile_mem[ra1];
		end
		if (read_reg && write_reg)
			$display("read_reg and write_reg are both high");
	end
endmodule
