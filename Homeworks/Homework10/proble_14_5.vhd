-- Taylor Cowley
-- Problem 14.5 - make 14.1 parameterizable with a for loop

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity proble_14_5 is
	Generic(WIDTH: natural);
    Port ( a : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           cout : out  STD_LOGIC);
end proble_14_5;
architecture for_loop of proble_14_5 is
begin
	process(a, cin)
		variable tmp: std_logic;
	begin
		tmp := cin;
		for i in 0 to WIDTH-1 loop
			s(i-1) 	<= a(i-1) xor tmp;
			tmp 		:= a(i-1) and tmp;
		end loop;
	cout <= tmp;
	end process;
end for_loop;

