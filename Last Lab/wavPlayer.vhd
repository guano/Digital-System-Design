----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:19:27 03/23/2016 
-- Design Name: 
-- Module Name:    wavPlayer - Behavioral 
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

entity wavPlayer is
    Port ( clk : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
			  audioOut : out STD_LOGIC;
           MemAdr : out  STD_LOGIC_VECTOR (22 downto 0);
           MemOE : out  STD_LOGIC;
           MemWR : out  STD_LOGIC;
           RamCS : out  STD_LOGIC;
           RamLB : out  STD_LOGIC;
           RamUB : out  STD_LOGIC;
           RamCLK : out  STD_LOGIC;
           RamADV : out  STD_LOGIC;
           RamCRE : out  STD_LOGIC;
			  RamWait : in STD_LOGIC;
           MemDB : inout  STD_LOGIC_VECTOR (15 downto 0);
			  an : out STD_LOGIC_VECTOR (3 downto 0)
			  );
end wavPlayer;

architecture Behavioral of wavPlayer is
constant CLOCK_RATE : natural := 50_000_000;
constant SAMPLE_RATE : natural := 44_100;
constant SAMPLE_DURATION : natural := CLOCK_RATE / SAMPLE_RATE;
constant BIT_WIDTH : natural := 8;
constant MAX_DURATION_COUNTER_VALUE : natural := 2**BIT_WIDTH - 1;
type count_direction is (up, down);


signal rst : std_logic;
signal sampleNumber, nSampleNumber : unsigned (23 downto 0);
signal timeSampleHeld, nTimeSampleHeld : unsigned (10 downto 0);
signal curWord, nextWord : std_logic_vector (15 downto 0);
signal bufferWord, nBufferWord : std_logic_vector(15 downto 0);

signal curSample : unsigned (7 downto 0);

signal PWMCounter, nPWMCounter : unsigned(BIT_WIDTH - 1 downto 0);
signal PWMCounterDirection, nPWMCounterDirection : count_direction;

signal curAddr : std_logic_vector (22 downto 0);
signal memStart : std_logic;
signal memOut : std_logic_vector (15 downto 0);
signal memIdle : std_logic;
signal bufferWrite : std_logic;

begin
an <= "1111";


rst <= btn(3) or btn(2) or btn(1) or btn(0);
------------------------- Sample Timing Controller ---------------------------------

process(clk, rst)
begin
	if (rst = '1') then
		sampleNumber <= (others => '0');
		timeSampleHeld <= (others => '0');
		curWord <= (others => '0');
		bufferWord <= (others => '0');
	elsif (clk'event and clk = '1') then
		sampleNumber <= nSampleNumber;
		timeSampleHeld <= nTimeSampleHeld;
		curWord <= nextWord;
		bufferWord <= nBufferWord;
	end if;
end process;

nTimeSampleHeld <= (others => '0') when (timeSampleHeld = SAMPLE_DURATION) else
						 timeSampleHeld + 1;
nSampleNumber <= sampleNumber + 1 when (timeSampleHeld = SAMPLE_DURATION-1) else
					  sampleNumber;
curAddr <= std_logic_vector(sampleNumber(sampleNumber'left downto sampleNumber'right + 1));

memStart <= '1' when timeSampleHeld = SAMPLE_DURATION - 10 else
				'0';
nextWord <= bufferWord when timeSampleHeld = 0 else
				curWord;
nBufferWord <= memOut when bufferWrite = '1' else
					bufferWord;
curSample <= unsigned(curWord(15 downto 8)) when sampleNumber(0) = '0' else
				 unsigned(curWord( 7 downto 0));

----------------------- Pulse Width Modulation of output ---------------------------

process(clk, rst)
begin
	if (rst = '1') then
		PWMCounter <= (others => '0');
		PWMCounterDirection <= up;
	elsif (clk'event and clk = '1') then
		PWMCounter <= nPWMCounter;
		PWMCounterDirection <= nPWMCounterDirection;	
	end if;
end process;

nPWMCounter <= PWMCounter + 1 when (PWMCounterDirection = up) else
					PWMCounter - 1;
nPWMCounterDirection <= down when PWMCounter = 255 else
								up when PWMCounter = 0 else
								PWMCounterDirection;
audioOut <= '1' when curSample >= PWMCounter else
				'0';

--------------------- Memory controller and sample buffer ---------------------------
ramControl : entity work.sramController
generic map( CLK_RATE => CLOCK_RATE)
Port map ( clk => clk,
           rst => rst,
			  
           addr => std_logic_vector(curAddr),
           data_m2s => "0000000000000000",
           mem => memStart,
           rw => '1',
           data_s2m => memOut,
           ready => memIdle,
			  data_valid => bufferWrite,
			  
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

end Behavioral;

