// Taylor Cowley. ECEN 320 HW 13 April 12

// Taylor Cowley. HW 13 part 1 problem 1. make a parity detector
module paritydetector( input [2:0] a,    output even    );
	assign even = ~(^a);
endmodule


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
		
		
// Taylor Cowley HW 13 part 1 problem 4 dumb right-shifter
module rotate_right(
    input [7:0] a,    input [2:0] amt,    output [7:0] y    );
	wire[7:0] le0_out;	wire[7:0] le1_out;	wire[7:0] le2_out;
	assign le0_out = (amt[0] == 1) ? {a[0],a[7:1]} : a;
	assign le1_out = (amt[1] == 1) ? {le0_out[1:0], le0_out[7:2]} : le0_out;
	assign le2_out = (amt[2] == 1) ? {le1_out[3:0], le1_out[7:4]} : le1_out;
	assign y = le2_out;
endmodule


// Taylor Cowley HW 13 part 2 problem 1: second-minute timer
module second_minute_timer(
    input clk,input reset,output [5:0] sec,output [5:0] min);
	reg[5:0] s_reg, m_reg, s_next, m_next;
	reg s_en, m_en;
	always@(posedge clk, posedge reset)	begin
		if(reset == 1)		begin
			r_reg = 0; s_reg = 0; m_reg = 0;
		end
		else		begin
			r_reg = r_next; s_reg = s_next; m_reg = m_next;
		end
	end
	assign r_next 	= (r_reg == 999999) ? 0 : r_reg + 1;
	assign s_en		= (r_reg == 500000) ? 1 : 0;
	assign s_next	= ((s_reg == 59) & (s_en == 1)) ? 0 : 
		(s_en==1) ? s_reg + 1 : s_reg ;
	assign m_en		= ((s_reg == 30) & (s_en == 1)) ? 1 : 0;
	assign m_next	= ((m_reg == 59) & (m_en==1)) ? 0 : 
		(m_en==1) ? m_reg + 1 : m_reg;
	assign sec = s_reg;
	assign min = m_reg;
endmodule



// Taylor cowley HW 13 part 2 problem 2: edge detector
module edge_detector(
    input clk,input reset,input strobe,output p1  );
	reg[1:0] state_reg, state_next;
	always@(posedge clk, posedge reset) begin
		if(reset == 1) begin
			state_reg = 0;
		end else begin
			state_reg = state_next;
		end
	end
	always@(state_reg, strobe) begin
		case(state_reg)
			0: begin
				if(strobe == 1)begin
					state_next = 2;	// 2 is "edge"
				end else begin
					state_next = 0;
				end
			end 2: begin
				if(strobe==1)begin
					state_next = 1;	// 1 is "one"
				end else begin
					state_next = 0;
				end
			end 1: begin
				if(strobe==1)begin
					state_next = 1;
				end else begin
					state_next = 0;
				end
			end
		endcase
	end
	assign p1 = (state_reg==2) ? 1 : 0 ;
endmodule

		
		