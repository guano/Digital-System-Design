----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:59:36 02/07/2016 
-- Design Name: 
-- Module Name:    vga_timing - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_timing is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           HS : in  STD_LOGIC;
           VS : in  STD_LOGIC;
           pixel_x : out  STD_LOGIC_VECTOR (9 downto 0);
           pixel_y : out  STD_LOGIC_VECTOR (9 downto 0);
           last_column : out  STD_LOGIC;
           last_row : out  STD_LOGIC;
			  blank : out STD_LOGIC);
end vga_timing;

architecture Behavioral of vga_timing is
-- Counter signals
signal curHorData, nextHorData : unsigned (9 downto 0);
signal curVerData, nextVerData : unsigned (0 downto 0);
signal en : std_logic;

-- Horizontal display constants
constant HOR_DISPLAY_SIZE : INTEGER := 640;
constant HOR_SYNC : Integer := 96;
constant HOR_FRONT_PORCH : Integer := 16;
constant HOR_BACK_PORCH : Integer := 48;

-- Vertical display constants
constant VER_DISPLAY_SIZE : INTEGER := 480;
constant VER_SYNC : Integer := 96;
constant VER_FRONT_PORCH : Integer := 10;
constant VER_BACK_PORCH : Integer := 29;

begin

--Enable signal assignment
process (clk, rst)
begin
   if rst = '1' then
	   en <= '0';
	elsif clk'event and clk = '1' then
	   en <= not en;
	end if;
end process;


--Horizontal assignment
process(clk, rst)
begin
   if rst = '1' then
	   curHorData <= (others => '0');
	elsif clk'event and clk = '1' and en = '1' then
	   curHorData <= nextHorData;
	end if;
end process;

nextHorData <= (others => '0') when curHorData =
                     (HOR_DISPLAY_SIZE + HOR_FRONT_PORCH + SYNC + HOR_BACK_PORCH) else
					curData + 1;

last_row <= '1' when curData = HOR_DISPLAY_SIZE else
            '0';
				
--Vertical Assignment

end Behavioral;

