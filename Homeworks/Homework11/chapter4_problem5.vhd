-- Taylor Cowley
-- 5. Create the VHDL code that performs a multiplication between 
-- two 8-bit signed numbers and produce a 8-bit result that uses 
-- the least significant bits of the result. Make sure that 
-- your multiplier produces the correct sign.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chapter4_problem5 is
	port( a, b: in std_logic_vector(7 downto 0);
			y: out std_logic_vector(7 downto 0));
end chapter4_problem5;

architecture Behavioral of chapter4_problem5 is
	signal au, bv0, bv1, bv2, bv3, bv4, bv5, bv6, bv7: unsigned(7 downto 0);
	signal p0,p1,p2,p3,p4,p5,p6,p7,prod: unsigned(15 downto 0);
begin
	au <= unsigned(a);
	bv0 <= (others=>b(0));
	bv1 <= (others=>b(1));
	bv2 <= (others=>b(2));
	bv3 <= (others=>b(3));
	bv4 <= (others=>b(4));
	bv5 <= (others=>b(5));
	bv6 <= (others=>b(6));
	bv7 <= (others=>b(7));
	p0 <="00000000" & (bv0 and au);
	p1 <="0000000" & (bv1 and au) & "0";
	p2 <="000000" & (bv2 and au) & "00";
	p3 <="00000" & (bv3 and au) & "000";
	p4 <="0000" & (bv4 and au) & "0000";
	p5 <="000" & (bv5 and au) & "00000";
	p6 <="00" & (bv6 and au) & "000000";
	p7 <="0" & (bv7 and au) & "0000000";
	prod <= ((p0+p1)+(p2+p3))+((p4+p5)+(p6+p7));
	y <= std_logic_vector(prod(7 downto 0));
end Behavioral;

