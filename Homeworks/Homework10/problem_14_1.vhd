-- Taylor Cowley
-- Problem 14.1
-- Consider a 1-bit incrementor cell that adds 1 to the input operant. It has
-- two 1-bit input signals, a and cin, which represent the input operand and carry-in
-- respectively, and 2 1-bit output signals, s and cout, for the sum and carry-out
-- a. Derive the function table for this circuit
--
-- a		cin		s		cout
-- 0		0			0		0
--	0		1			1		0		
-- 1		0			1		0
-- 1		1			0		1
--
-- b. Derive the VHDL code for this circuit using only simple signal
-- assignment statements and logical operators

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_1 is
	port(	a, cin :in STD_LOGIC; 
			s,cout :out STD_LOGIC);
end problem_14_1;

architecture half_adder of problem_14_1 is
begin
	cout	<= a and cin;
	s		<= a xor cin;
end half_adder;

