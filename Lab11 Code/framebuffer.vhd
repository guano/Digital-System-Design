----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:14:53 03/24/2016 
-- Design Name: 
-- Module Name:    framebuffer - Behavioral 
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

entity framebuffer is
    Port ( clk : in  STD_LOGIC;
           btn0 : in  STD_LOGIC;
           sw : in  STD_LOGIC_VECTOR (4 downto 0);
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
           vgaRed : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaBlue : out  STD_LOGIC_VECTOR (1 downto 0);
           vgaGreen : out  STD_LOGIC_VECTOR (2 downto 0);
           MemAdr : out  STD_LOGIC_VECTOR (22 downto 0);
           MemOE : out  STD_LOGIC;
           MemWR : out  STD_LOGIC;
           RamCS : out  STD_LOGIC;
           RamLB : out  STD_LOGIC;
           RamUB : out  STD_LOGIC;
           RamCLK : out  STD_LOGIC;
           RamADV : out  STD_LOGIC;
           RamCRE : out  STD_LOGIC;
           MemDB : inout  STD_LOGIC_VECTOR (15 downto 0));
end framebuffer;

architecture Behavioral of framebuffer is
constant CLK_RATE : Natural := 50_000_000;
signal HS, VS, lCol, lRow, bitSelect, blank, rst : std_logic;
signal HS0, HS1, HS2, HS3 : std_logic;
signal VS0, VS1, VS2, VS3 : std_logic;
signal curAddr : std_logic_vector (22 downto 0);
signal xOut, yOut : std_logic_vector (9 downto 0);
signal dataOut, dataBuffer : std_logic_vector (15 downto 0);
signal curByte : std_logic_vector (7 downto 0);
signal bufferWE, memWE, ready : std_logic;

begin
rst <= btn0;

Timer: entity work.vga_timing
Port map ( clk => clk,
           rst => rst,
           HS => HS0,
           VS => VS0,
           pixel_x => xOut,
           pixel_y => yOut,
           last_column => lCol,
           last_row => lRow,
			  blank => blank);

curAddr <= sw & yOut(8 downto 0) & xOut(9 downto 1);
bitSelect <= xOut(0);

process(clk,rst)
begin
	if (rst = '1') then
		HS1 <= '0'; HS2 <= '0'; HS3 <= '0'; HSync <= '0';
		VS1 <= '0'; VS2 <= '0'; VS3 <= '0'; VSync <= '0';
	elsif (clk'event and clk = '1') then
		HS1 <= HS0; HS2 <= HS1; HS3 <= HS2; HS <= HS3;
		VS1 <= VS0; VS2 <= VS1; VS3 <= VS2; VS <= VS3;
	end if;
end process;

frameRom : entity work.roRamController
generic map(CLK_RATE => CLK_RATE)
Port map ( clk => clk,
           rst => rst,
			  
           addr => curAddr,
           mem => memWE,
           data_s2m => dataOut,
           ready => ready,
			  data_valid => bufferWE,
			  
           MemAdr => MemAdr,
           MemOE => MemOE,
           MemWR => MemWR,
           RamCS => RamCS,
           RamLB => RamLB,
           RamUB => RamUB,
           RamCLK => RamCLK,
           RamADV => RamADV,
           RamCRE => RamCRE,
           MemDB => MemDB);

process(clk)
begin
	if (clk'event and clk = '1') then
		if (bufferWE = '1') then
			dataBuffer <= dataOut;
		end if;
	end if;
end process;

curByte <= dataBuffer (15 downto 8) when bitSelect = '1' else
			  dataBuffer ( 7 downto 0);
			  
vgaRed   <= "000" when blank = '1' else curByte (7 downto 5);
vgaGreen <= "000" when blank = '1' else curByte (4 downto 2);
vgaBlue  <= "00"  when blank = '1' else curByte (1 downto 0);

end Behavioral;

