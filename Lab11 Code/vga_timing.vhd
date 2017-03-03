----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:59:36 02/07/2016 
-- Design Name: 
-- Module Name:    vga_controller - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_timing is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           HS : out  STD_LOGIC;
           VS : out  STD_LOGIC;
           pixel_x : out  STD_LOGIC_VECTOR (9 downto 0);
           pixel_y : out  STD_LOGIC_VECTOR (9 downto 0);
           last_column : out  STD_LOGIC;
           last_row : out  STD_LOGIC;
			  blank : out STD_LOGIC);
end vga_timing;

architecture Behavioral of vga_timing is

--------------------------- Start of Variable Declaratinons---------------------------

-- Counter signals
signal curHorData, nextHorData : unsigned (9 downto 0);
signal curVerData, nextVerData : unsigned (9 downto 0);
signal en : std_logic;
signal verEn : std_logic;

-- Horizontal display constants
constant HOR_DISPLAY_SIZE : INTEGER := 640;
constant HOR_SYNC : Integer := 96;
constant HOR_FRONT_PORCH : Integer := 16;
constant HOR_BACK_PORCH : Integer := 48;

-- Vertical display constants
constant VER_DISPLAY_SIZE : INTEGER := 480;
constant VER_SYNC : Integer := 2;
constant VER_FRONT_PORCH : Integer := 10;
constant VER_BACK_PORCH : Integer := 29;
---------------------------- End of Variable Declaratinons ---------------------------

----------------------------- Start of Signal Assignments ----------------------------
begin
-- Enable signal assignment, used to advance the pixel counters at 
-- half the rate of the main system clock
process (clk, rst)
begin
   if rst = '1' then
	   en <= '0';
	elsif clk'event and clk = '1' then
	   en <= not en;
	end if;
end process;


----------------------------- Start of Horizontal Counter-----------------------------
process(clk, rst)
begin
   if curHorData(0) = 'U' then
	   curHorData <= (others => '0');
   elsif rst = '1' then
	   curHorData <= (others => '0');
	elsif clk'event and clk = '1' and en = '1' then
	   curHorData <= nextHorData;
	end if;
end process;

nextHorData <= (others => '0') when curHorData >=
                     (HOR_DISPLAY_SIZE + HOR_FRONT_PORCH + HOR_SYNC + HOR_BACK_PORCH - 1) else
					curHorData + 1;
------------------------------ End of Horizontal Counter------------------------------

---------------------------- Horizontal Output Assignments ---------------------------
pixel_x <= std_logic_vector(curHorData);

last_column <= '1' when curHorData = HOR_DISPLAY_SIZE - 1 else
            '0';

HS <= '0' when (curHorData >= (HOR_DISPLAY_SIZE + HOR_FRONT_PORCH)) and
					(curHorData < (HOR_DISPLAY_SIZE + HOR_FRONT_PORCH + HOR_SYNC)) else
		'1';
		

------------------------------ Start of Vertical Counter------------------------------

verEn <= '1' when curHorData = (HOR_DISPLAY_SIZE + HOR_FRONT_PORCH + HOR_SYNC + HOR_BACK_PORCH - 1) else
			'0';
process(clk, rst)
begin
   if curVerData(0) = 'U' then
	   curVerData <= (others => '0');
   elsif rst = '1' then
	   curVerData <= (others => '0');
	elsif clk'event and clk = '1' and en = '1' and verEn = '1' then
	   curVerData <= nextVerData;
	end if;
end process;

nextVerData <= (others => '0') when curVerData >=
                     (VER_DISPLAY_SIZE + VER_FRONT_PORCH + VER_SYNC + VER_BACK_PORCH - 1) else
					curVerData + 1;
------------------------------- End of Vertical Counter ------------------------------


----------------------------- Vertical Output Assignment -----------------------------

pixel_y <= std_logic_vector(curVerData);
last_row <= '1' when curVerData = VER_DISPLAY_SIZE - 1 else
				'0';
VS <= '0' when (curVerData >= VER_DISPLAY_SIZE + VER_FRONT_PORCH) and
					(curVerData < VER_DISPLAY_SIZE + VER_FRONT_PORCH + VER_SYNC) else
		'1';

blank <= '0' when curHorData <= HOR_DISPLAY_SIZE - 1 and curVerData <= VER_DISPLAY_SIZE - 1
			else '1';

end Behavioral;
------------------------------ End of VGA Controller ---------------------------------