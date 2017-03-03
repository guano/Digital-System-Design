// Taylor Cowley HW 13 part 1 problem 3 2-to-4 decoder
module decoder_2_1(
    input [1:0] in,    output [3:0] out    );
	always@(in)
	begin
		case(in)
			b00:	out = 4'b0001;
			b01:	out = 4'b0010;
			b10:	out = 4'b0100;
			default:	out = 4'b1000;
		endcase	end endmodule