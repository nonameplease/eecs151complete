module rv64_alu_testbench();
	reg [63:0] a;
	reg [63:0] b;
	reg [2:0] op;
	wire [63:0] c;
	initial a = 64'b0;
	initial b = 64'b0;
	initial op = 3'b0;

	rv64_alu dut(
		.a(a),
		.b(b),
		.op(op),
		.c(c)
	);

	initial begin
		$dumpfile("rv64_alu_testbench.vcd");
		$dumpvars(0, rv64_alu_testbench);

		#100;
		a = 64'h210000000;
		b = 64'h100000000;
		op = 3'd0;
		#100;
		op = 3'd1;
		#100;
		op = 3'd2;
		#100;
		op = 3'd3;
		#100;
		op = 3'd4;
		#100;
		op = 3'd5;
		#100;
		op = 3'd6;
		#100;
		op = 3'd7;
		#100;
		op = 3'd0;
		$finish();
	end

endmodule
