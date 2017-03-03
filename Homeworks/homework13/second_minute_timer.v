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
