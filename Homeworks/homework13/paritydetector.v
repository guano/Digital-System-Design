// Taylor Cowley. HW 13 part 1 problem 1. make a parity detector
module paritydetector( input [2:0] a,    output even    );
	assign even = ~(^a);
endmodule
