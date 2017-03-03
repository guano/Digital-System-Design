
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity problem11_5 is
    Port ( clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           y : in   unsigned (7 downto 0);
           d : in   unsigned (7 downto 0);
           q : out  unsigned (7 downto 0);
           r : out  unsigned (7 downto 0);
           ready : out  STD_LOGIC);
end problem11_5;

architecture multi_segment of problem11_5 is
	type state_type is (idle, zero, load, op);
	signal state_reg, state_next: state_type;
	signal r_reg, y_reg, q_reg, d_reg: unsigned(7 downto 0);
	signal r_next, y_next, q_next, d_next: unsigned(7 downto 0);
	signal divider_out: unsigned(7 downto 0);
	signal plus_plus: unsigned(7 downto 0);
	
begin
-- Control path: state register
	process(clk, reset)
	begin
		if reset = '1' then
			state_reg <= idle;
		elsif (clk'event and clk = '1') then
			state_reg <= state_next;
		end if;
	end process;
	
--Control Path: next-state/output logic
	process(state_reg, start, a_is_0, b_is_0, count_0)
	begin
		case state_reg is
			when idle =>
				if start = '1' then
					if(y = 0 or d = 0) then
						state_next <= zero;
					else
						state_next <= load;
					end if;
				else
					state_next <= idle;
				end if;
			when zero =>
				state_next <= idle;
			when load =>
				state_next <= op;
			when op =>
				if y < d then
					state_next <= idle;
				else
					state_next <= op;
				end if;
		end case;
	end process;

--control path: output logic
ready<= '1' when state_reg=idle else '0';

	process(clk, reset)
	begin
		if reset='1' then
			q_reg <= 0;
			r_reg <= 0;
			y_reg <= 0;
			d_reg <= 0;
		elsif (clk'event and clk='1') then
			q_reg <= q_next;
			r_reg <= r_next;
			y_reg <= y_next;
			d_reg <= d_next;
		end if;
	end process;
	
	--data path: multiplexer
	process(state_reg, q_reg, r_reg)
	begin
		case state_reg is
			when idle =>
				q_next <= q_reg;
				r_next <= r_reg;
				y_next <= y_reg;
				d_next <= d_reg;
			when zero =>
				q_next <= 0;
				r_next <= 0;
				y_next <= y;
				d_next <= d;
			when load =>
				q_next <= 0;
				r_next <= 0;
				y_next <= y;
				d_next <= d;
			when op =>
				d_next <= d_reg;
				y_next <= divider_out;
				r_next <= divider_out;
				q_next <= plus_plus;
		end case
	end process;
	
-- data path: functional units
divider_out <= y_reg - d_reg;
plus_plus <= q_reg + 1;

-- data path: output
q <= q_reg;
r <= r_reg;

end multi_segment;



architecture two_segment of problem 11_5 is
	type state_type is (idle, zero, load, op);
	signal state_reg, state_next: state_type;
	signal r_reg, y_reg, q_reg, d_reg: unsigned(7 downto 0);
	signal r_next, y_next, q_next, d_next: unsigned(7 downto 0);
	signal divider_out: unsigned(7 downto 0);
	signal plus_plus: unsigned(7 downto 0);
begin
--state and data registers
	process(clk, reset)
	begin
		if reset = '1' then
			state_reg <= idle;
			y_reg <= 0;
			r_reg <= 0;
			q_reg <= 0;
			d_reg <= 0;
		elsif (clk'event and clk='1') then
			state_reg <= state_next;
			y_reg <= y_next;
			r_reg <= r_next;
			q_reg <= q_next;
			d_reg <= d_next;
		end if
	end process;
	
--combinational circuit
	process(start, state_reg, y_reg, d_reg, q_reg, r_reg, y, d)
	begin
		y_reg <= y_next;
		d_reg <= d_next;
		q_reg <= q_next;
		r_reg <= r_next;
		ready <= '0';
		
		case state_reg is
			when idle =>
				if start = '1' then
					if(y = 0 or d = 0)then
						state_next <= zero;
					else
						state_next <= load;
					end if;
				else
					state_next <= idle;
				end if;
			when zero =>
				y_next <= y;
				d_next <= d;
				q_next <= 0;
				r_next <= 0;
			when load =>
				y_next <= y;
				d_next <= d;
				q_next <= 0;
				r_next <= 0;
			when op =>
				y_next <= y_reg - d_reg;
				r_next <= y_reg - d_reg;
				q_next <= q_reg + 1;
				if(y_reg < d_reg) then
					state_next <= idle;
				else
					state_next <= op;
				end if;
			end case;
		end process;
		r <= r_reg;
		q <= q_reg;
	end process;
end two_segment;
