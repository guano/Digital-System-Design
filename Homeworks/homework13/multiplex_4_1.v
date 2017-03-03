// Taylor Cowley HW 13 part 1 problem 2 4-to-1 multiplexer
module multiplex_4_1(
    input [3:0] in,    input [1:0] select,    output out    );
	always@(in,select)
	begin
		case(select)
			b00:	out = in(0);
			b01:	out = in(1);
			b10:	out = in(2);
			default:	out = in(3);
		endcase	end endmodule
