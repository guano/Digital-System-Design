-- Taylor Cowley
-- Problem 14.4 - do 14.2 but use conditional generate for the boundry cases
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_4 is
	Generic(WIDTH: natural);
    Port ( a : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cout : out  STD_LOGIC);
end problem_14_4;

architecture conditional_generate of problem_14_4 is
	signal tmp : std_logic_vector(WIDTH downto 0);
begin
	tmp(0) <= cin;
	half_adder: for i in 0 to WIDTH-1 generate
		begin_gen: if(i=0) generate
			tmp(i) <= cin;
		end generate;
	
		mid_gen: if(i>0 and i < (WIDTH-1)) generate
			tmp(i+1) <= a(i) and tmp(i);
			s(i)		<= a(i) xor tmp(i);
		end generate;
		
		end_gen: if(i=(WIDTH-1)) generate
			cout <= tmp(WIDTH-1);
		end generate;
	end generate;
end conditional_generate;

