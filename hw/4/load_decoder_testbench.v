module load_decoder_testbench();
	reg [31:0] addr;
	reg [31:0] raw_data;
	reg lb, lbu, lh, lhu, lw;
	wire [31:0] wb_data;
	initial raw_data = 32'b10000000000000001000000010000000;
	initial lb = 1'b0;
	initial lbu = 1'b0;
	initial lh = 1'b0;
	initial lhu = 1'b0;
	initial lw = 1'b0;

	load_decoder dut(
		.addr(addr),
		.raw_data(raw_data),
		.lb(lb),
		.lbu(lbu),
		.lh(lh),
		.lhu(lhu),
		.lw(lw)
	);

	initial begin
		$dumpfile("load_decoder_testbench.vcd");
		$dumpvars(0, load_decoder_testbench);

		#100;
		lb = 1'b1;
		#100;
		lb = 1'b0;
		lbu = 1'b1;
		#100;
		lbu = 1'b0;
		lh = 1'b1;
		#100;
		lh = 1'b0;
		lhu = 1'b1;
		#100;
		lhu = 1'b0;
		lw = 1'b1;
		#100;
		lw = 1'b0;
		$finish();
	end
endmodule
