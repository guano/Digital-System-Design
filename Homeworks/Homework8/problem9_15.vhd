library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem9_15 is
	port(
		clk: in STD_LOGIC;
		a: in  STD_LOGIC_VECTOR(7 downto 0);
		y: out STD_LOGIC);
end problem9_15;

architecture tree_arch_4_stage of problem9_15 is

begin
	y <=	((a(7) xor a(6)) xor (a(5) xor a(4))) xor
			((a(3) xor a(2)) xor (a(1) xor a(0)));
	process(clk)
	begin
		if(clk'event and clk = '1') then
			a_in_reg 	<= a_in_next;
			stage_1_reg	<= stage_1_next;
			stage_2_reg	<= stage_2_next;
			stage_3_reg	<= stage_3_next;
		end if;
	end process;
	
	a_in_next 		<= a;
	stage_1_next 	<=	(a_in_reg(7) xor a_in_reg(6)) &
							(a_in_reg(5) xor a_in_reg(4)) &
							(a_in_reg(3) xor a_in_reg(2)) &
							(a_in_reg(1) xor a_in_reg(0));
	stage_2_next	<= (stage_1_reg(3) xor stage_1_reg(2)) &
							(stage_1_reg(1) xor stage_1_reg(0));
	stage_3_next	<=	stage_2_reg(1) xor stage_2_reg(0);
	y <= stage_3_reg;
	
end tree_arch_4_stage;
