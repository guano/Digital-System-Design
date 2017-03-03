library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hw_3_11 is

end hw_3_11;

architecture win of hw_3_11 is
signal s1, s2, s3, s4, s5, s6, s7: std_logic_vector(3 downto 0);
signal u1, u2, u3, u4, u5, u6, u7: unsigned(3 downto 0);
signal sg: signed(3 downto 0);

signal one: std_logic_vector(3 downto 0) := "0110";
signal two: std_logic_vector(3 downto 0) := "1001";
signal tre: std_logic_vector(6 downto 0) := "0001001";

signal ans: std_logic;
begin

u1 <= to_unsigned(2#0001#, 4);
u2 <= u3 and u4;
u5 <= to_unsigned(to_integer(signed(s1)) + 1, 3);
u6 <= u3 + u4 + 3;
u7 <= (others=> '1');
s2 <= std_logic_vector(signed(s3) + signed(s4) - 1);
s5 <= (others => '1');
s6 <= std_logic_vector(u3 and u4);
sg <= signed(u3) - 1;
s7 <= std_logic_vector(not sg);

end win;