library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity problem10_5 is
	port(
		strobe: in std_logic;
		p1: out std_logic);
end problem10_5;

--10.5.c - Moore architecture of edge detector
architecture moore of problem10_5 is
	type state_reg_type is (zero, one, edge_one, edge_zero);
begin
	-- State register
	process(clk)
	begin
		if(clk'event and clk='1') then
			state_reg <= state_next;
		end if;
	end process;
	
	-- Next-state logic
	process(state_reg)
	begin
		case state_reg is
			when zero =>
				p1 <= '0';
				if(strobe = '0') then
					state_next <= zero;
				else
					state_next <= edge_one;
				end if;
			when one =>
				p1 <= '0';
				if(strobe = '1') then
					state_next <= one;
				else
					state_next <= edge_zero;
				end if;
			when edge_one =>
				p1 <= '1';
				if(strobe = '1') then
					state_next <= one;
				else
					state_next <= edge_zero;
				end if;
			when edge_zero =>
				p1 <= '1';
				if(strobe = '0') then
					state_next <= zero;
				else
					state_next <= edge_one;
				end if;
			end case;
	end process;
end moore;

-- Problem 2: mealy edge detector
architecture mealy of problem10_5 is
	type state_reg_type is (zero, one);
begin
	-- State register
	process(clk)
	begin
		if(clk'event and clk='1') then
			state_reg <= state_next;
		end if;
	end process;
	
	-- Next-state logic
	process(state_reg)
	begin
		case state_reg is
			when zero =>
				if(strobe = '0') then
					p1 <= '0';
					state_next <= zero;
				else
					p1 <= '1';
					state_next <= one;
				end if;
			when one =>
				if(strobe = '1') then
					p1 <= '0';
					state_next <= one;
				else
					p1 <= '1';
					state_next <= zero;
				end if;
			end case;
	end process;
end moore;

