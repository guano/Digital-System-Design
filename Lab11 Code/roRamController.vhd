----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:34:27 03/09/2016 
-- Design Name: 
-- Module Name:    sramController - Behavioral 
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

entity roRamController is
generic  ( CLK_RATE : Natural);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  
           addr : in  STD_LOGIC_VECTOR (22 downto 0);
           mem : in  STD_LOGIC;
           data_s2m : out  STD_LOGIC_VECTOR (15 downto 0);
           ready : out  STD_LOGIC;
			  data_valid : out STD_LOGIC;
			  
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
end roRamController;

architecture Behavioral of roRamController is
type memStates is (powerUp, idle, r1, r2, r3, r4);
signal curState, nextState : memStates;
signal booter, idler, repeater : memStates;
signal count, nextCount : unsigned (22 downto 0);
constant powerUpDelay : natural := CLK_RATE * 150 / 1_000_000;

-- Address and Data Registers
signal addrReg, addrNext : std_logic_vector(22 downto 0);
signal dataOutReg, dataOutNext : std_logic_vector(15 downto 0);

signal next_data_valid : std_logic;
begin

process(clk, rst)
-- Register Assignment
begin
	if (rst = '1') then
		curState <= powerUp;
		count <= (others => '0');
		dataOutReg <= (others => '0');
		addrReg <= (others => '0');
	elsif (clk'event and clk = '1') then
		curState <= nextState;
		count <= nextCount;
		dataOutReg <= dataOutNext;
		addrReg <= addrNext;
	end if;
end process;

-- State Machine Next-State Logic;
nextCount <= count + 1 when curState = powerUp else
				 (others => '0');
booter <= idle when count >= powerUpDelay else
			 powerUp;
idler  <= idle when mem /= '0' else
			 r1;
repeater <= r1 when mem='1' else 
				idle;

with curState select nextState <=
	booter   when powerUp,
	idler    when idle,
	r2		   when r1,
	r3		   when r2,
	r4		   when r3,
	repeater	when r4;

-- Data and Address buffer Next-State Logic
addrNext <= addr when curState = idle and mem = '0' else
				addrReg;
dataOutNext <= memDB when next_data_valid = '1' else
				   dataOutReg;  

data_s2m <= dataOutReg;
ready <= '1' when curState = idle else
			'0';
next_data_valid <= '1' when curState = r4 else
						 '0';
process(clk)
begin
	if (clk'event and clk = '0') then
		data_valid <= next_data_valid;
	end if;
end process;
			  
MemAdr <= addrReg;

-- Control Signals
MemOE <= '0' when curState = r2 or curState = r3 
					or curState = r4 else
			'1';
			
MemWR <= '1';
			
RamCS <= '1' when curState = powerUp or curState = idle
 				 else '0';
RamLB <= '1' when curState = powerUp or curState = idle
				 else '0';
RamUB <= '1' when curState = powerUp or curState = idle 
				 else '0';
			
RamCLK <= '0';

RamADV <= '0';
RamCRE <= '0';
MemDB <= (others => 'Z');
end Behavioral;