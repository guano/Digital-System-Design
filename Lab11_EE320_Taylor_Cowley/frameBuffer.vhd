
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity frameBuffer is
    Port ( clk : in  STD_LOGIC;
           btn0 : in  STD_LOGIC;
           sw : in  STD_LOGIC_VECTOR (4 downto 0);
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
           vgaRed : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaGreen : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaBlue : out  STD_LOGIC_VECTOR (1 downto 0);
           MemAdr : out  STD_LOGIC_VECTOR (23 downto 1);
           MemOE : out  STD_LOGIC;
           MemWR : out  STD_LOGIC;
           RamCS : out  STD_LOGIC;
           RamLB : out  STD_LOGIC;
           RamUB : out  STD_LOGIC;
           RamCLK : out  STD_LOGIC;
           RamADV : out  STD_LOGIC;
           RamCRE : out  STD_LOGIC;
           MemDB : inout  STD_LOGIC_VECTOR (15 downto 0);
			  led		: out STD_LOGIC_VECTOR(7 downto 0));
end frameBuffer;

architecture TAYLOR of frameBuffer is
-------------------------------------------------
------------ Component declaration
	component vga_timing
	port(
		clk, rst : in std_logic;
		HS, VS, last_column, last_row, blank : out std_logic ; 
		pixel_x, pixel_y : out std_logic_vector(9 downto 0));
	end component; 
	component sramController
	port(
		clk, rst, mem, rw : in std_logic; 
		addr : in std_logic_vector(22 downto 0); 
		data_m2s : in std_logic_vector(15 downto 0); 
		data_valid, ready, MemOE, MemWr, RamCS, RamLB, RamUB, RamCLK, RamADV, RamCRE : out std_logic; 
		MemAdr : out std_logic_vector(22 downto 0);
		data_s2m : out std_logic_vector(15 downto 0); 
		MemDB : inout std_logic_vector(15 downto 0)  );
	end component;
------------ end component declaration
---------------------------------------------------
	
	signal HS, VS, HS1, HS2, HS3, HS4, VS1, VS2, VS3, VS4: std_logic:='0';
	signal pixel_x, pixel_y: std_logic_vector(9 downto 0);
	type state_type is (s1, s2, s3, s4);
	signal state_reg, state_next : state_type; 
	
	signal mem: std_logic:= '0';
	signal data_valid, blank: std_logic;
	signal mem_data: std_logic_vector(15 downto 0);
	signal addr: std_logic_vector(22 downto 0);
	signal pixel_data, pixel_data_next: std_logic_vector(15 downto 0):= (others=>'0');
begin
-- This puts the Hsync and the Vsync through 4 registers
-- This should make our output 4 clocks behind our VGAtimer
	led	<= "11111111";--sw;
	mem	<= '0'; -- ALWAYS READ lol
	Vsync	<= VS4;
	Hsync <= HS4;
	addr <= sw(4 downto 0) & pixel_y(8 downto 0) & pixel_x(9 downto 1);
	pixel_data_next <= mem_data when data_valid = '1' else pixel_data;
	
	vgaRed	<= "000" when blank = '1' else 
		pixel_data(7 downto 5) when pixel_x(0) = '1' else pixel_data(15 downto 13);
	vgaGreen	<= "000" when blank = '1' else 
		pixel_data(4 downto 2) when pixel_x(0) = '1' else pixel_data(12 downto 10);
	vgaBlue	<= "00"  when blank = '1' else 
		pixel_data(1 downto 0) when pixel_x(0) = '1' else pixel_data(9 downto 8);
	
	process(state_reg)
	begin 
	case state_reg is 
		when s1 =>
			state_next <= s2;
		when s2 =>
			state_next <= s3;
		when s3 =>
			state_next <= s4;
		when s4 =>
			state_next <= s1;
	end case; 
	end process; 

	process(clk)
	begin 
		if(clk' event and clk = '1') then
			state_reg <= state_next; 
			pixel_data<= pixel_data_next;
			HS1 <= HS;
			HS2 <= HS1;
			HS3 <= HS2;
			HS4 <= HS3;
			VS1 <= VS;
			VS2 <= VS1;
			VS3 <= VS2;
			VS4 <= VS3;
		end if; 
	end process;
	
	
---------------------------------------------
------------- Component instanciation
	 sramCtl : sramController
 port map(
	clk => clk,
	rst => btn0,
	addr => addr,
	data_m2s => (others=>'0'),
	mem => mem,
	rw => '1',
	ready => open,
	data_valid => data_valid,
	data_s2m => mem_data,
	MemAdr => MemAdr,
	RamCS => RamCS,
	MemWR => MemWR,
	MemOE => MemOE,
	RamUB => RamUB,
	RamLB => RamLB,
	MemDB => MemDB,
	RamADV => RamADV,
	RamCRE => RamCRE,
	RamCLK => RamCLK
	);				
 control: vga_timing
 port map(
	clk => clk,
	rst => btn0,
	HS => HS,
	VS => VS,
	last_column => open,
	last_row => open,
	blank => blank,
	pixel_x => pixel_x,
	pixel_y => pixel_y
	);
------------ END component instanciation
---------------------------------------------
end TAYLOR;

