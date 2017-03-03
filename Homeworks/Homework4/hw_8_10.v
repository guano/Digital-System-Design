--Textbook problem 8.10
--Taylor Cowley

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity hw_8_10(
    input clk,
    output out_1_Hz
    );
end hw_8_10;

architecture micro of hw_8_10 is
	signal million_counter: unsigned(19 downto 0);
	signal next: unsigned(19 downto 0);
begin
	process(clk)
		if(clk'event and clk = '1')
			million_counter <= next;
		end if
	end process;
	
	next <= (million_counter + 1) when million_counter < 999999 else
				0 when million_counter >=999999;
	out_1_Hz <= '1' when million_counter < 499999 else
				'0';
end micro;

