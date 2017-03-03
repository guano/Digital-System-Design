-- Taylor Cowley
-- Problem 14.6 - no for generate nor for loop
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_6 is
    Port ( a : in  STD_LOGIC_VECTOR;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR;
           cout : out  STD_LOGIC);
end problem_14_6;

architecture clever_array of problem_14_6 is
	signal carry: STD_LOGIC_VECTOR(a'length downto 0);
begin
	carry <= a and carry(carry'high-1 downto 0) & cin;
	s		<= carry(carry'high -1 downto 0) xor a;
	cout 	<= '1' when cin='1' and (a=(a'range=>'1')) else '0';
end clever_array;

