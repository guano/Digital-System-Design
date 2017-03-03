-- Taylor Cowley
-- 3. For each of the following statements: i) indicate whether the right side of the signal assignment statement
-- is valid VHDL (i.e. will it compile without error), ii) if the right side of the signal assignment statement
-- is valid, indicate the type of the result (i.e., the type of rx where x=1-13), and iii) determine the result
-- of the statement (again, only if the right side of the statement is valid). Use the following VHDL signal
-- declarations to respond to each of the statements below.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chapter4_problem_3 is
end chapter4_problem_3;

architecture Behavioral of chapter4_problem_3 is
	signal u1 : unsigned(3 downto 0) := "0110";
	signal u2 : unsigned(3 downto 0) := "1101";
	signal u3 : unsigned(5 downto 0) := "110011";
	signal u4 : unsigned(5 downto 0) := "010100";
	signal s1 : signed(3 downto 0) := "0111";
	signal s2 : signed(3 downto 0) := "1100";
	signal s3 : signed(5 downto 0) := "111111";
	signal s4 : signed(5 downto 0) := "011000";	
	signal r1 : unsigned(3 downto 0);
	signal r2 : unsigned(5 downto 0);
	signal r5 : signed(5 downto 0);
	signal r6 : signed(3 downto 0);
	signal r7 : signed(5 downto 0);
	signal r9 : signed(5 downto 0);
	signal r10: signed(5 downto 0);
	signal r11: unsigned(9 downto 0);
	signal r13: signed(7 downto 0);
begin

	r1 <= u1 + u2;	-- A
		-- Correct
		-- unsigned(3 downto 0)
		-- "0000"
	r2 <= u2 + u3;	-- B
--	r3 <= u1 - u4;	-- C
		-- NOT correct
--	r4 <= u1 + s1; -- D
		-- NOT correct
	r5 <= signed(u3) + s4; -- E
		-- Correct
		-- signed(5 downto 0)
		-- "001011"
	r6 <= s1 - s2; -- F
		-- Correct
		-- signed(3 downto 0)
		-- "1011"
	r7 <= s3 + s4; -- G
		-- Correct
		-- signed(5 downto 0)
		-- "010111"
--	r8 <= s2 - u2; -- H
		-- NOT CORRECT
	r9 <= s3 + s1; -- I
		-- Correct
		-- signed(5 downto 0)
		-- "000110"
	r10 <= s4 - (signed(u2)); -- J
		-- Correct
		-- signed(5 downto 0)
		-- "001011"
	r11 <= u1 * u4; -- K
		-- Correct
		-- unsigned(9 downto 0)
		-- "0001111000"
--	r12 <= s3 * (-s2); -- L
		-- NOT CORRECT
	r13 <= s1 * s2; -- M
		-- Correct
		-- signed(7 downto 0)
		-- "11100100"
end Behavioral;

