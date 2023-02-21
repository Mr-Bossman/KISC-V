module regfile
	#(parameter DATA_WIDTH = 32)
	(
	input clk,
	input [4:0]ra0,
	input [4:0]ra1,
	input [4:0]wa,
	input [DATA_WIDTH-1:0]wd,
	output [DATA_WIDTH-1:0]rd0,
	output [DATA_WIDTH-1:0]rd1
	);
reg [DATA_WIDTH-1:0] regfile[31:0];

assign rd0 = ra0 == 5'b0 ? 0 : regfile[ra0];
assign rd1 = ra1 == 5'b0 ? 0 : regfile[ra1];
always @ (posedge clk) begin
	regfile[wa] <= wd;
end
endmodule
