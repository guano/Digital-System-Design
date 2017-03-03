
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity vga_top is
    Port ( clk : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
           vgaRed : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaGreen : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaBlue : out  STD_LOGIC_VECTOR (1 downto 0));
end vga_top;

architecture top_level of vga_top is
	signal red, green: 	STD_LOGIC_VECTOR(2 downto 0);
	signal blue: 			STD_LOGIC_VECTOR(1 downto 0);
	signal Hsy, Vsy:		STD_LOGIC;
	signal vR : 			STD_LOGIC_VECTOR (2 downto 0);
   signal vG : 			STD_LOGIC_VECTOR (2 downto 0);
   signal vB : 			STD_LOGIC_VECTOR (1 downto 0);
	signal bl: 				STD_LOGIC;

	signal pixel_x:		STD_LOGIC_VECTOR (9 downto 0);
	signal pixel_y:		STD_LOGIC_VECTOR (9 downto 0);
	signal magRowR, magColR, magRowG, magColG: STD_LOGIC_VECTOR(2 downto 0);
	signal magRowB, magColB: STD_LOGIC_VECTOR(1 downto 0);
	
	component vga_timing
	Port ( clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		HS : out  STD_LOGIC;
		VS : out  STD_LOGIC;
		pixel_x : out  STD_LOGIC_VECTOR (9 downto 0);
		pixel_y : out  STD_LOGIC_VECTOR (9 downto 0);
		last_column : out  STD_LOGIC;
		last_row : out  STD_LOGIC;
		blank : out  STD_LOGIC);
end component;
	
begin
	vga_timer: vga_timing port map
		(clk=>clk, rst=>btn(3), HS=>Hsy, VS=>Vsy, 
		 pixel_x=>pixel_x, pixel_y=>pixel_y, 
		 last_column=>open, last_row=>open, blank=>bl);
	
	
	with btn select red <=
		"111" when "0100" | "0110" | "0101", -- but not all 3
		sw(7 downto 5) when "0000",
		magRowR and magColR when "0111",
		"000" when others;
	with btn select green <=
		"111" when "0010" | "0011", -- but not all 3
		sw(4 downto 2) when "0000",
		magRowG and magColG when "0111", 
		"000" when others;
	with btn select blue <=
		"11" when "0001", -- but not all 3
		sw(1 downto 0) when "0000",
		magRowB and magColB when "0111",
		"00" when others;
	
-- Blank when blank signal is asserted.
	vR	<= red 	when bl = '0' else "000";
	vG <= green when bl = '0' else "000";
	vB	<= blue	when bl = '0' else "00";
	
	process(clk)
	begin
		if(clk'event and clk='1') then 
			Hsync 	<= Hsy;
			Vsync 	<= Vsy;
			vgaRed	<= vR;
			vgaGreen <= vG;
			vgaBlue	<= vB;
		end if;
	end process;
	
	magRowR <= 	"000" when unsigned(pixel_x) < 80 	else
					"001" when unsigned(pixel_x) < 160	else
					"010" when unsigned(pixel_x) < 240	else
					"011" when unsigned(pixel_x) < 320	else
					"100" when unsigned(pixel_x) < 400	else
					"101" when unsigned(pixel_x) < 480	else
					"110" when unsigned(pixel_x) < 560	else
					"111";
	magColR <= 	"000" when unsigned(pixel_y) < 60 	else
					"001" when unsigned(pixel_y) < 120	else
					"010" when unsigned(pixel_y) < 180	else
					"011" when unsigned(pixel_y) < 240	else
					"100" when unsigned(pixel_y) < 300	else
					"101" when unsigned(pixel_y) < 360	else
					"110" when unsigned(pixel_y) < 420	else
					"111";
	magRowG <= 	"000" when unsigned(pixel_x) < 80 	else
					"001" when unsigned(pixel_x) < 160	else
					"010" when unsigned(pixel_x) < 240	else
					"011" when unsigned(pixel_x) < 320	else
					"100" when unsigned(pixel_x) < 400	else
					"101" when unsigned(pixel_x) < 480	else
					"110" when unsigned(pixel_x) < 560	else
					"111";
	magColG <= 	"111" when unsigned(pixel_y) < 60 	else
					"110" when unsigned(pixel_y) < 120	else
					"101" when unsigned(pixel_y) < 180	else
					"100" when unsigned(pixel_y) < 240	else
					"011" when unsigned(pixel_y) < 300	else
					"010" when unsigned(pixel_y) < 360	else
					"001" when unsigned(pixel_y) < 420	else
					"000";
	magRowB <= 	"00" when unsigned(pixel_x) < 160 	else
					"01" when unsigned(pixel_x) < 320	else
					"10" when unsigned(pixel_x) < 480	else
					"11";
	magColB <= 	"00" when unsigned(pixel_y) < 120 	else
					"01" when unsigned(pixel_y) < 240	else
					"10" when unsigned(pixel_y) < 360	else
					"00";
	
	
end top_level;




--horiz_max = 1001111111 639
--vert_max = 0111011111 479




