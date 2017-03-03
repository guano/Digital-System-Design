-- Taylor Cowley
-- Problem 14.7- 14.2- for generate but no generic.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_7 is
    Port ( a : in  STD_LOGIC_VECTOR;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR ;
           cout : out  STD_LOGIC);
end problem_14_7;

architecture for_generate_no_generic of problem_14_7 is
	signal tmp : std_logic_vector(a'range);
begin
	tmp(a'low) <= cin;
	half_adder: for i in a'low to a'high generate
		tmp(i+1) <= a(i) and tmp(i);
		s(i)		<= a(i) xor tmp(i);
	end generate;
end for_generate_no_generic;

