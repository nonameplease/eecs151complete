module hamming (input [21:0] data,  output [1:0] error_code);
	wire [4:0] parity;
	wire [4:0] syndrome;
	wire [4:0] old_parity;
	reg [1:0] ecode;
	assign error_code = ecode;
	assign parity[0] = data[20] ^ data[18] ^ data[16] ^ data[14] ^ data[12] ^ data[10] ^ data[8] ^ data[6] ^ data[4] ^ data[2];
	assign parity[1] = data[18] ^ data[17] ^ data[14] ^ data[13] ^ data[10] ^ data[9] ^ data[6] ^ data[5] ^ data[2];
	assign parity[2] = data[20] ^ data[19] ^ data[14] ^ data[13] ^ data[12] ^ data[11] ^ data[6] ^ data[5] ^ data[4];
	assign parity[3] = data[14] ^ data[13] ^ data[12] ^ data[11] ^ data[10] ^ data[9] ^ data[8];
	assign parity[4] = data[20] ^ data[19] ^ data[18] ^ data[17] ^ data[16];
	
	assign old_parity[0] = data[0];
	assign old_parity[1] = data[1];
	assign old_parity[2] = data[3];
	assign old_parity[3] = data[7];
	assign old_parity[4] = data[15];

	assign syndrome = old_parity ^ parity;
	

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

	always @(*) begin
		if (syndrome == 5'b0) begin
			if (data[21] == 1'b0) begin
				ecode <= 2'b00; // no error
			end else begin
				ecode <= 2'b01; // parity error
			end
		end else begin
			if (data[21] == 1'b0) begin
				ecode <= 2'b10; // double error
			end else begin
				ecode <= 2'b11; // single error
			end
		end
	end
endmodule
