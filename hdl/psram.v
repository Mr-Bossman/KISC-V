module psram
	#(
		parameter ADDR_WIDTH = 32,
		parameter DATA_WIDTH = 32,
		/* Command + 24-bit addr + 32-bit data */
		parameter MAX_TRNS_SZ = 24 + 8 + DATA_WIDTH,
		parameter RAM_SIZE = 1024*1024*8) // 8MiB
	(
		input pclk,
		input [ADDR_WIDTH-1:0] paddr,
		input [DATA_WIDTH-1:0] pdata,
		output reg [DATA_WIDTH-1:0] prdata,

		input psel,
		input penable,
		input pwrite,
		input [3:0] pstb,
		output pready,
		output perr,

		output cs,
		output SI,
		input SO);

reg [1:0]dsize;
reg started;
reg [MAX_TRNS_SZ-1:0]bits = 0;
reg [DATA_WIDTH-1:0]recv;
reg [6:0]cnt = 0;
wire [6:0]trns_sz = 24 + 8 + ((dsize*8) + 8);

always @(*) begin
	if(pstb == 4'b0001) begin
		dsize = 0;
	end else if (pstb == 4'b0011) begin
		dsize = 1;
	end else if (pstb == 4'b1111) begin
		dsize = 3;
	end
	// else invalid transaction
end

// 1 is done, 0 is not done
reg transaction_done = 1;
assign cs = transaction_done;
// if transaction isnt done, and either psel or penable is low, then perr is high
assign perr = !transaction_done && !(psel && penable);
// if (transaction is done, and psel and penable are high and started is high) or perr is high, then pready is high
assign pready = (penable && psel && (transaction_done && started)) | perr;

assign SI = bits[MAX_TRNS_SZ-1];

always @(negedge pclk) begin
	if(psel && !penable)
		started <= 0;
	else
		started <= 1;
	if((psel && penable) || !transaction_done) begin
		if(cnt == 0) begin
			transaction_done <= 0;
			if(paddr == 'h80000000+RAM_SIZE+4) begin
				bits <= {pdata[7:0],56'b0};
				cnt <= trns_sz-7;
			end else begin
				bits <= {7'b0000001,!pwrite,paddr[23:0],pdata[7:0],pdata[15:8],pdata[23:16],pdata[31:24]};
				cnt <= 1;
			end
		end else if(cnt == trns_sz) begin
			transaction_done <= 1;
			cnt <= 0;
			bits <= 0;
			prdata <= {recv[7:0],recv[15:8],recv[23:16],recv[31:24]};
		end else begin

			bits <= bits << 1;
			cnt <= cnt + 1;
		end
	end
end
always @(posedge pclk) begin
	if(!transaction_done) begin
		recv <= (recv << 1) | SO;
	end
end
endmodule
