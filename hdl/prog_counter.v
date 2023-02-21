/* verilator lint_off UNUSED */
/* verilator lint_off WIDTH */

/* TODO
JAL
JALR
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
	reg [3:0] microop_pc = 0;
	reg [7:0] microop_prog[0:15];
	reg [7:0] microop;

	reg [31:0] data;
	wire [31:0] odata;
	reg [31:0] addr;

	wire [31:0] alu_out;
	wire cmp_flag;

	wire APB_ready;
	wire APB_err;
	wire APB_sel = microop[0];
	wire APB_en = microop[1];
	wire APB_wr = (op == 7'b0100011);
	wire store_alu = microop[2];
	wire load_insr = microop[3];
	wire mem_access = microop[4];
	wire alu_flags = microop[5];

initial begin
	$readmemh("microop.vh", microop_prog);
end

	//assign addr = (microop==0)?pc:(regs[mo_rs1]+((instruction[5])?mo_imm_s:mo_imm_i));
//	assign data = (microop==2)?regs[mo_rs2]:'hz;
	assign ra0 = instruction[19:15];
	assign ra1 = instruction[24:20];
	assign wa = instruction[11:7];
	APB apb_bus(clk,addr,data,odata,APB_sel,APB_en,APB_wr,dsize,APB_ready,APB_err);




	assign odat = microop;
	assign res = pc;



	//reg [31:0] opc;
//	assign odat = data;
//assign prc = (microop==0)?pc:opc;
	wire [6:0] op = instruction[6:0];
	wire [2:0] sub_op = instruction[14:12];
	wire ex_alu = (sub_op == 5 || op == 7'b0010011)?instruction[30]:0; // use extra ops for SRAI/SRA and non-imm(sub/add)
	alu alu(sub_op | (ex_alu << 4),rd0,(instruction[5])?rd1:imm_i,alu_out,cmp_flag);
	// wire [4:0] mo_rs1 = instruction[19:15];
	// wire [4:0] mo_rs2 = instruction[24:20];
	wire [31:0] imm_s = {{21{instruction[31]}}, instruction[30:25], instruction[11:7]};
	wire [31:0] imm_i = {{21{instruction[31]}}, instruction[30:20]};
	wire [31:0] imm_b = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
	// wire [4:0] mo_rd = instruction[11:7];

	//wire [4:0] rs1 = odata[19:15];
	//wire [4:0] rs2 = odata[24:20];
	//ire [4:0] rd = odata[11:7];
	//wire [2:0] sub_op = odata[14:12];
	//wire [31:0] imm_i = {{21{odata[31]}}, odata[30:20]};
	// wire [31:0] imm_b = {{20{data[31]}}, data[7], data[30:25], data[11:8], 1'b0};
	// wire [31:0] imm_j = {{12{data[31]}}, data[19:12], data[20], data[30:21], 1'b0};


	wire [31:0] imm_u = {odata[31:12], 12'b0};
	always @(posedge clk or posedge rts) begin
		if(rts)
			pc <= 0;
		else if(clk) begin
			if(load_insr) begin
				instruction <= odata;
				casez (odata[6:0])
					7'b0?00011: begin // LOAD/STORE
						microop_pc <= 8;
						microop <= microop_prog[8];
					end
					7'b0?10111: begin //LUI/AUIPC
						// TODO: check if pc is +4 or not
						regfile[odata[11:7]] <= imm_u + ((odata[5])?0:pc);
						microop <= 0;
					end
					7'b0?10011: begin // ALU
						microop <= 4;
					end
					7'b110?111: begin // JAL/JALR
						microop <= 0;
					end
					7'b1100011: begin // BRANCH
						microop <= 32;
					end
					default:microop <= 0;


				endcase
			end
			// halt till APB_ready is ready
			else if(!(APB_en && APB_sel && !APB_ready)) begin
				if(microop) begin
					microop_pc <= microop_pc + 1;
					microop <= microop_prog[microop_pc];
				end else begin
					instruction <= 0;
					microop_pc <= 1;
					addr <= pc;
					pc <= pc + 4;
					dsize <= 4'b1111;
					microop <= microop_prog[0];
				end
			end
			if(mem_access) begin
				unique case (sub_op)
					2'b00: dsize <= 4'b0001;
					2'b01: dsize <= 4'b0011;
					2'b10: dsize <= 4'b1111;
					default: dsize <= 4'b1111;
				endcase
				addr <= (op == 7'b0100011)?imm_s:imm_i + rd0;
				data <= rd1;
				if(APB_en && APB_sel && APB_ready && (op == 7'b0000011))
					regfile[wa] <= odata;
			end
			if(store_alu) regfile[wa] <= alu_out;
			if(alu_flags && cmp_flag) pc <= imm_b + pc - 4;
		end
	end

endmodule
