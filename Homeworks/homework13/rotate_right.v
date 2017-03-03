// Taylor Cowley HW 13 part 1 problem 4 dumb right-shifter
module rotate_right(
    input [7:0] a,    input [2:0] amt,    output [7:0] y    );
	wire[7:0] le0_out;	wire[7:0] le1_out;	wire[7:0] le2_out;
	assign le0_out = (amt[0] == 1) ? {a[0],a[7:1]} : a;
	assign le1_out = (amt[1] == 1) ? {le0_out[1:0], le0_out[7:2]} : le0_out;
	assign le2_out = (amt[2] == 1) ? {le1_out[3:0], le1_out[7:4]} : le1_out;
	assign y = le2_out;
endmodule
