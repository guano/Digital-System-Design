-- Taylor Cowley
-- 1. Create the VHDL statements necessary for adding a 4-bit signed number to a 6-bit signed number and
-- generate an 8-bit result.
-- 2. Create the VHDL statements necessary to subtract a 8-bit unsigned number from a 4-bit signed number
-- and generate a 9-bit result. Make sure your types are correct and there is no underflow in the result.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chapter4_problems is
end chapter4_problems;

architecture Behavioral of chapter4_problems is
	signal signed_4_bits: signed(3 downto 0);
	signal signed_6_bits: signed(5 downto 0);
	signal signed_8_bits: signed(7 downto 0);
	signal signed_9_bits: signed(8 downto 0);
begin
	
-- 1. Create the VHDL statements necessary for adding a 4-bit signed number to a 6-bit signed number and
-- generate an 8-bit result.
	signed_8_bits	<= resize((signed_4_bits + signed_6_bits),8);
	
-- 2. Create the VHDL statements necessary to subtract a 8-bit unsigned number from a 4-bit signed number
-- and generate a 9-bit result. Make sure your types are correct and there is no underflow in the result.
	signed_9_bits	<= resize((signed_4_bits - signed_8_bits),9);
	
end Behavioral;










