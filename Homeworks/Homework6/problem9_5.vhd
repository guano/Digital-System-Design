library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem9_5 is
	port(
		clk, reset: in std_logic;
		q: out std_logic_vector(3 downto 0));
end problem9_5;

architecture lfsr of problem9_5 is
	signal r_reg, r_next: std_logic_vector(3 downto 0);
	signal fb: std_logic;
	constant SEED: std_logic_vector(3 downto 0) := "0000";
begin
	process(clk, reset)
	begin
		if(reset = '1') then
			r_reg <= seed;
		elsif (clk'event and clk = '1') then
			r_reg <= r_next;
		end if;
		
		fb <= r_reg(1) xor r_reg(0);
		zero <= 	'1' when r_reg(3 downto 1)="000" else
					'0';
		fzero <= zero xor fb;
		r_next <= "0000" when fzero & r_reg(3 downto 1) = "1111" else
				<= fzero & r_reg(3 downto 1);
		q <= r_reg;
	end process;
end lfsr;
