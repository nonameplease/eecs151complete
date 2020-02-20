module load_decoder(
	input [31:0] addr,
	input [31:0] raw_data,
	input lb, lbu, lh, lhu, lw,
	output [31:0] wb_data
);
	reg [31:0] data;
	assign wb_data = data;
	always @(*) begin
		case ({lb, lbu, lh, lhu, lw})
			5'b10000: data = $signed(raw_data[7:0]);
			5'b01000: data = $unsigned(raw_data[7:0]);
			5'b00100: data = $signed(raw_data[15:0]);
			5'b00010: data = $unsigned(raw_data[15:0]);
			5'b00001: data = raw_data;
			default: data = 32'b0;
		endcase
	end

endmodule
		
