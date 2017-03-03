----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:20 01/29/2016 
-- Design Name: 
-- Module Name:    seven_seg_control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_control is
	generic(COUNTER_BITS: natural := 15);
    port ( clk : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (15 downto 0);
           dp_in : in  STD_LOGIC_VECTOR (3 downto 0);
           blank : in  STD_LOGIC_VECTOR (3 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           dp : out  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end seven_segment_control;

architecture best of seven_segment_control is
	signal anode_select: STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal decode_THIS: STD_LOGIC_VECTOR(3 downto 0);
	signal counter: unsigned(COUNTER_BITS-1 downto 0) := to_unsigned(0, COUNTER_BITS);
	--signal counter_next: unsigned(COUNTER_BITS-1 downto 0) := 0;
	--I want to only use one signal. Let's see if it works.
begin
-- Time for the dp multiplexer
	with anode_select select dp <=
		not dp_in(0) when "00",
		not dp_in(1) when "01",
		not dp_in(2) when "10",
		not dp_in(3) when others;
	
-- The data multiplexer
	with anode_select select decode_THIS <=
		data_in(3 downto 0)	when "00",
		data_in(7 downto 4)	when "01",
		data_in(11 downto 8)	when "10",
		data_in(15 downto 12)when others;
		
-- The decoder itself, copy-pasted from lab 3
	with decode_THIS select seg <=
		"1000000" when "0000",
		"1111001" when "0001",
		"0100100" when "0010",
		"0110000" when "0011",
		"0011001" when "0100",
		"0010010" when "0101",
		"0000010" when "0110",
		"1111000" when "0111",
		"0000000" when "1000",
		"0010000" when "1001",
		"0001000" when "1010",
		"0000011" when "1011",
		"1000110" when "1100",
		"0100001" when "1101",
		"0000110" when "1110",
		"0001110" when "1111",
		"0111111" when others; -- displays a - on error

-- Anode logic. Blanks every digit that is asserted for blank
-- but displays the digit specified by the counter
-- I don't know if this is more efficient than a process, but whatever.
	an(0) <= '0' when anode_select = "00" and blank(0) = '0' else '1';
	an(1) <= '0' when anode_select = "01" and blank(1) = '0' else '1';
	an(2) <= '0' when anode_select = "10" and blank(2) = '0' else '1';
	an(3) <= '0' when anode_select = "11" and blank(3) = '0' else '1';

	process(clk)
	begin
	--finish the clock ticking.
		if(CLK'EVENT and clk = '1') then
			counter <= counter + 1;
		end if;
	end process;
	
	anode_select <= std_logic_vector(counter(COUNTER_BITS-1 downto COUNTER_BITS-2));

end best;

