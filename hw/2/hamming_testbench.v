`timescale 1ns / 1ns

module hamming_testbench();
	reg [21:0] data;
	wire [1:0] error;
	reg fi = 1'b0;

	hamming tu(
		.data(data),
		.error_code(error)
	);

	/*
	Error detection table
	+----------+-------------+--------------+-----------------------------------------------+
	| syndrome |   overall   |  error type  |                     notes                     |
	|          | Parity (P5) |              |                                               |
	+----------+-------------+--------------+-----------------------------------------------+
	|    0     |      0      |   no error   |                                               |
	+----------+-------------+--------------+-----------------------------------------------+
	|   /=0    |      1      | single error | correctable.syndrome holds incorrect bit      |
    |          |             |              | position.                                     |
	+----------+-------------+--------------+-----------------------------------------------+
	|   /=0    |      0      | double error | not correctable.                              |
	+----------+-------------+--------------+-----------------------------------------------+
	|    0     |      1      | parity error | overall parity. P5 is in error and can be     |
	|          |             |              | corrected.                                    |
	+----------+-------------+--------------+-----------------------------------------------+
	*/	

	initial begin
		$dumpfile("hamming_testbench.vcd");
		$dumpvars(0, hamming_testbench);
		data = 22'b1111111111111111111111;
		#1;
		$display("Error code: %b", error);
		if (error != 2'b11) begin
			fi = 1'b1;
		end
		data = 22'b0100010000001100001110;
		#1;
		$display("Error code: %b", error);
		if (error != 2'b10) begin
			fi = 1'b1;
		end
		data = 22'b0100010000001100001100;
		#1;
		$display("Error code: %b", error);
		if (error != 2'b00) begin
			fi = 1'b1;
		end
		data = 22'b0110011001100110011001;
		#1;
		$display("Error code: %b", error);
		if (error != 2'b00) begin
			fi = 1'b1;
		end
		data = 22'b1100010000001100001100;
		#1;
		$display("Error code: %b", error);
		if (error != 2'b01) begin
			fi = 1'b1;
		end
		if (fi == 1'b0) begin
			$display("Pass");
		end else begin
			$display("Fail");
		end
		$finish();
	end
endmodule
