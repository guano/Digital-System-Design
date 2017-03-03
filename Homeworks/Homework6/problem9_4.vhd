library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem9_4 is
	port(
		clk, reset: in std_logic;
		q: out std_logic_vector(3 downto 0));
end problem9_4;

architecture self_correcting of problem9_4 is
	signal r_reg, r_next: std_logic_vector(3 downto 0);
	signal s_in: std_logic;
begin
	process(clk, reset)
	begin
		if(reset = '1') then
			r_reg <= (others=>'1');
		elsif(clk'event and clk = '1') then
			r_reg <= r_next;
		end if;
	end process;
	
	s_in <=	'0' when r_reg(3 downto 1)="111" else
				'1';
	r_next <= s_in & r_reg(3 downto 1);
	q <= r_reg;
end self_correcting;

