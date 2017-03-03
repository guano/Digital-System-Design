-- Taylor Cowley
-- 7. Modify the VHDL in Listing 7.34 to create a 
-- pipelined multiplier that provides a register between each stage
-- of the partial product adders.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chapter4_problem_7 is
	port( a, b: in std_logic_vector(7 downto 0);
			y: out std_logic_vector(15 downto 0));
end chapter4_problem_7;

architecture Behavioral of chapter4_problem_7 is
	signal au, bv0, bv1, bv2, bv3, bv4, bv5, bv6, bv7: unsigned(7 downto 0);
	signal p0,p1,p2,p3,p4,p5,p6,p7,prod: unsigned(15 downto 0);
	signal step1_1, step1_2, step1_3, step1_4, step2_1, step2_2, step3_1: unsigned(15 downto 0);
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
--	prod <= (
--					(p0+p1)
--					+
--					(p2+p3)
--				)
--				+
--				(
--					(p4+p5)
--					+
--					(p6+p7)
--				);
--	y <= std_logic_vector(prod(7 downto 0));
	
	step1_1 <= p0 + p1;
	step1_2 <= p2 + p3;
	step1_3 <= p4 + p5;
	step1_4 <= p6 + p7;
	process(clk) 
	begin
		if(clk'event and clk = '1') then
			step2_1 <= step1_1 + step1_2;
			step2_2 <= step1_3 + step1_4;
			
			step3_1 <= step2_1 + step2_2;
		end if;
	end process;
	
	y <= std_logic_vector(step3_1);
	
end Behavioral;

