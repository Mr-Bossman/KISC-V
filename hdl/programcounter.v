`include "sys.v"
module programcounter
	#(parameter ADDR_WIDTH = 32,
	  parameter INCREMENT_VALUE = 4,
	  parameter RESET_VALUE = 0)
	( input APB_PCLK,
	  input APB_PRESETn,
	  input halt,
	  input increment,
	  input load,
	  input [ADDR_WIDTH-1:0] load_data,
	  output [ADDR_WIDTH-1:0] pc
	);

	reg [ADDR_WIDTH-1:0] data;
	assign pc = data;

	initial begin
		data = RESET_VALUE;
	end

	`always_ff_sys @(posedge APB_PCLK) begin

		if (!APB_PRESETn)
			data <= RESET_VALUE;
		else if (!halt) begin
			if (load && increment)
				$display("Error: Both load and increment are high");

			if (load)
				data <= load_data;
			else if (increment)
				data <= data + INCREMENT_VALUE;
		end
	end

endmodule
