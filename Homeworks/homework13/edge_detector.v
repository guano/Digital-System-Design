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
