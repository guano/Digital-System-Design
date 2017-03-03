-- Taylor Cowley
-- problem 14.2 - make the half adder with a generic width and for generate
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_2 is
	Generic(WIDTH: natural);
    Port ( a : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cout : out  STD_LOGIC);
end problem_14_2;

architecture for_generate of problem_14_2 is
	signal tmp : std_logic_vector(WIDTH downto 0);
begin
	tmp(0) <= cin;
	half_adder: for i in 0 to WIDTH-1 generate
		tmp(i+1) <= a(i) and tmp(i);
		s(i)		<= a(i) xor tmp(i);
	end generate;
	cout <= tmp(WIDTH-1);
end for_generate;

