-- Problem 12.1 b. VHDL of the programmable pulse generator
-- But with only 1 state to program it.

architecture prog_arch of pulse_5clk is 
type fsmd_state_type is (idle, delay, shl); 
signal state_reg , state_next : f smd_state_type ; 
signal c_reg , c_next : unsigned (2 downto 0) ; 
signal w_rag, w_next: unsigned (2 downto 0) ; 
signal count, count_next : unsigned(3 downto 0):= (others=>'0');

begin 

-- state and data regsters 
process (clk , reset) 
begin 

	if (reset='l') then 
		state_reg <= idle; 
		c_reg <= (others=>'O'); 
		w_reg <= "101"; --default 5-cycle delay 
		count<= (others=>'0');
	elsif (clk'event and clk='1') then 
		state_reg <= state_next ; 
		c_reg <= c_next; 
		w_reg <= w_next; 
		count <= count_next;
	end if; 
end process; 

-- next-state    logic & data path functional units/routing 
process (state_reg ,go, stop, c_reg , w_reg, count) 
	
begin 

	pulse <= '0'; 
	c_next <= c_reg; 
	w_next <= w_reg; 
	case state_reg is 
		when idle => 
			if go='1' then 
				if stop= '1' then 
					state_next <= sh1;
				else 
					state_next <= delay;
				end if; 
			else 
				state_next <= idle; 
			end if ; 
			c_next <= (others=>'O');
		when delay => 
			if stop= '1' then 
				next_state <= idle;
			else 
				if (c_reg=w_reg -1) then 
					state_next <=idle ; 
				else 
					c_next <= c_reg + 1; 
					state_next <=delay; 
				end if ; 
			end if;
			pulse <= '1'; 
			
		------------------------------
		-- This is the key to the single-state programming
		-- We just count to 3! That runs our state 3 times.
		------------------------------
		when shl => 
			w_next <= go & w_reg(2 downto 1); 
			if(count = 2) then
				state_next <= idle; 
				count_next <= 0;
			else
				state_next <= sh1;
				count_next <= count + 1;
			end if;
		end case; 

	end process; 
end prog_arch; 
