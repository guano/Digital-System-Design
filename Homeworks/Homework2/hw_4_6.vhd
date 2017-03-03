library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw_4_6 is
    Port ( a 		: in  STD_LOGIC_VECTOR (7 downto 0);
           ctrl 	: in  STD_LOGIC_VECTOR (2 downto 0);
           y 		: out STD_LOGIC_VECTOR (7 downto 0));
end hw_4_6;
architecture win of hw_4_6 is
begin
with ctrl select
	y <=	a when "000",
			a(6 downto 0) & a(7) 			when "001",
			a(5 downto 0) & a(7 downto 6)	when "010",
			a(4 downto 0) & a(7 downto 5)	when "011",
			a(3 downto 0) & a(7 downto 4)	when "100",
			a(2 downto 0) & a(7 downto 3)	when "101",
			a(1 downto 0) & a(7 downto 2)	when "110",
			a(0) & a(7 downto 1)				when others;
end win;




