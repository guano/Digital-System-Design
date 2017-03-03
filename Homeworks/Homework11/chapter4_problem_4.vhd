-- Taylor Cowley arithmetic chapter 4 problem 4
-- Book problem 7.2 Take a 8 bit signed input to 
-- 8 bit signed magnitude format.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chapter4_problem_4 is
	port(
		eight_bit_input : in  signed(7 downto 0);
		eight_bit_output: out std_logic_vector(7 downto 0));
end chapter4_problem_4;

architecture Behavioral of chapter4_problem_4 is
	signal sign: std_logic;
	signal inverse: unsigned(6 downto 0);
	signal plus: unsigned(6 downto 0);
begin
	sign <= eight_bit_input(7);
	inverse <= not unsigned(eight_bit_input(6 downto 0));
	plus <= inverse +1;
	eight_bit_output <= sign & std_logic_vector(plus);
end Behavioral;

