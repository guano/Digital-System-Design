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

entity sramController is
generic  ( CLK_RATE : Natural);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  
           addr : in  STD_LOGIC_VECTOR (22 downto 0);
           data_m2s : in  STD_LOGIC_VECTOR (15 downto 0);
           mem : in  STD_LOGIC;
           rw : in  STD_LOGIC;
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
end sramController;

architecture Behavioral of sramController is
type memStates is (powerUp, idle, r1, r2, r3, r4, r5, w1, w2, w3, w4, w5, w6);
signal curState, nextState : memStates;
signal booter, idler : memStates;
signal count, nextCount : unsigned (22 downto 0);
constant powerUpDelay : natural := CLK_RATE * 150 / 1_000_000;

-- Address and Data Registers
signal addrReg, addrNext : std_logic_vector(22 downto 0);
signal dataInReg, dataInNext : std_logic_vector(15 downto 0);
signal dataOutReg, dataOutNext : std_logic_vector(15 downto 0);
begin

process(clk, rst)
-- Register Assignment
begin
	if (rst = '1') then
		curState <= powerUp;
		count <= (others => '0');
		dataInReg <= (others => '0');
		dataOutReg <= (others => '0');
		addrReg <= (others => '0');
	elsif (clk'event and clk = '1') then
		curState <= nextState;
		count <= nextCount;
		dataInReg <= dataInNext;
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
			 r1   when rw = '1' else
			 w1;

with curState select nextState <=
	booter when powerUp,
	idler  when idle,
	r2		 when r1,
	r3		 when r2,
	r4		 when r3,
	r5		 when r4,
	idle	 when r5,
	w2		 when w1,
	w3		 when w2,
	w4		 when w3,
	w5		 when w4,
	w6 	 when	w5,
	idle	 when w6;

-- Data and Address buffer Next-State Logic
addrNext <= addr when curState = idle and mem = '0' else
				addrReg;
dataInNext <= data_m2s when curState = idle and mem = '0' and rw = '0' else
				  dataInReg;
dataOutNext <= memDB when curState = r5 else
				   dataOutReg;  

data_s2m <= dataOutReg;
ready <= '1' when curState = idle else
			'0';
data_valid <= '1' when curState = r5 else
				  '0';
			  
MemAdr <= addrReg;

-- Control Signals
MemOE <= '0' when curState = r3 or curState = r4
					or curState = r5
					or curState = w1 or curState = w2
					or curState = w3 or curState = w4 
					or curState = w5 or curState = w6 else
			'1';
			
MemWR <= '0' when curState = w2
					or curState = w3 or curState = w4
					or curState = w5 or curState = w6 else
			'1';
			
RamCS <= '1' when curState = powerUp or curState = idle
					--or curState = r5 or curState = w1
					--or curState = w2 
					or curState = w6
				else '0';
RamLB <= '1' when curState = powerUp or curState = idle
				--	or curState = w5 
				 else '0';
RamUB <= '1' when curState = powerUp or curState = idle 
				--	or curState = w5 
				 else '0';
			
RamCLK <= '0';

RamADV <= '0';
RamCRE <= '0';
with curState select MemDB <= 
	dataInReg when w4,
	dataInReg when w5,
	(others => 'Z') when others;
end Behavioral;