-- Taylor Cowley
-- tcowley0

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_seg_decode is
    Port ( sw : in  STD_LOGIC_VECTOR (7 downto 0);
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           dp : out  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end seven_seg_decode;

architecture concurrent of seven_seg_decode is
	signal seven_segment_input : STD_LOGIC_VECTOR (3 downto 0);
	signal button_3_mplex : STD_LOGIC_VECTOR(3 downto 0);
	
begin
	with seven_segment_input select seg <=
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
		"0111111" when others;
	with btn(3) select seven_segment_input <=
		"1000" when '1',
		button_3_mplex when others;
	with btn(1 downto 0) select button_3_mplex <=
		sw(3 downto 0) 							when "00",
		sw(7 downto 4) 							when "01",
		sw(3 downto 0) xor sw(7 downto 4) 	when "10",
		sw(1 downto 0) & sw(3 downto 2) 		when "11",
		"1110" when others;
	an <= "0000" when (btn(3) = '1') else
			"1111" when (btn(2) = '1') else
			"1110" when (btn(1 downto 0) = "00") else
			"1101" when (btn(1 downto 0) = "01") else
			"1011" when (btn(1 downto 0) = "10") else
			"0111" when (btn(1 downto 0) = "11");
	dp <= '0'	when (btn(3) = '1') else
			'1';
end concurrent;

