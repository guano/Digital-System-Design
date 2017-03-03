library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory_top is
    Port ( clk : in  STD_LOGIC;
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           dp : out  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           led : out  STD_LOGIC_VECTOR (7 downto 0);
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
			  MemOE: out STD_LOGIC;
			  MemWR: out STD_LOGIC;
			  RamAdv: out STD_LOGIC;
			  RamCS: out STD_LOGIC;
			  RamClk: out STD_LOGIC;
			  RamCRE: out STD_LOGIC;
			  RamLB: out STD_LOGIC;
			  RamUB: out STD_LOGIC;
			  RamWait: in STD_LOGIC;
			  MemAdr: out STD_LOGIC_VECTOR(23 downto 1);
			  MemDB: inout STD_LOGIC_VECTOR(15 downto 0));
end memory_top;

architecture taylor of memory_top is
-------------------------------------

-------------------------------------
------------ Declaring our controller
  component sramController
    generic(
      CLK_RATE : Natural := 50_000_000    
    );
    port(
      clk : in std_logic;
      rst : in std_logic;    

      addr : in std_logic_vector(22 downto 0);
      data_m2s : in std_logic_Vector(15 downto 0);
      mem : in std_logic:= '1';
      rw : in std_logic:= '0';
      data_s2m : out std_logic_vector(15 downto 0);
      ready : out std_logic;
      data_valid : out std_logic;

      MemAdr : out std_logic_vector(22 downto 0);
      MemOE : out std_logic;
      MemWR: out std_logic;
      RamCS: out std_logic;
      RamLB: out std_logic;
      RamUB: out std_logic;
      RamCLK: out std_logic;
      RamADV: out std_logic;
      RamCRE: out std_logic;
      MemDB : inout std_logic_vector(15 downto 0)
      );
  end component;
------------- Finish declaring our controller
-----------------------------------------------
 
---------------------------------------------------
-----		Load seven segment display
	component seven_segment_control
   generic(
     COUNTER_BITS : Natural := 15);
   port(
     clk : in std_logic;
     data_in : in std_logic_vector(15 downto 0);
     dp_in : in std_logic_vector(3 downto 0);
     blank : in std_logic_vector(3 downto 0);
     seg : out std_logic_Vector(6 downto 0);
     dp : out std_logic;
     an : out std_logic_vector(3 downto 0));
	end component;
-----		End loading seven segment display
-------------------------------------------------------
  
  signal mem, rw, ready : std_logic;
--  signal rst : std_logic := '0';			-- created when all 4 buttons are down
  signal addr, sram_addr : std_logic_vector(22 downto 0);
  signal write_data, read_data, sram_data : std_logic_vector(15 downto 0);
  signal data_valid : std_logic;
  signal ready_has_gone_high : std_logic := '0';
  
  
  signal addr_next, input_next : std_logic_vector(7 downto 0);
  signal good_read, good_read_next : std_logic_vector(15 downto 0);
  
  signal btn_out, btn_next: std_logic_vector(3 downto 0);
	signal debounce_timer: unsigned(19 downto 0):= (others=>'0');
	signal rst: std_logic:= '0';
	
	constant DEBOUNCE_NUMBER: natural := 300_000;
begin

	led				<= addr(7 downto 0);

	
	
	process(clk)
	begin
		
		if(clk'event and clk = '1') then
			
			addr			<= "000000000000000" & addr_next;
			write_data	<= input_next & input_next;
			good_read	<= good_read_next;
			btn_out		<= btn_next;
			
			if(btn = "1111") then
				addr			<= (others => '0');
				write_data 	<= (others => '0');
				good_read	<= (others => '0');
				good_read_next	<= (others => '0');
				btn_out		<= btn_next;
				addr_next	<= (others => '0');
				input_next <= (others => '0');
				rst			<= '1';
			else
				rst			<= '0';
				if(btn(0) = '1') then 
					addr_next <= sw;
				end if;
				if(btn(1) = '1') then
					input_next <= sw;
				end if;
				
				if(btn(2) = '1') then
					mem <= '0';
					rw <= '0';
				elsif(btn(3) = '1') then
					mem <= '0';
					rw <= '1';
				else
					mem <= '1';
					rw <= '0';
				end if;
			end if;
			
			if(data_valid = '1') then
				good_read_next	<= read_data;
			end if;
		end if;
	end process;


---------------------------------------------------
-----		This debounces the buttons
	process(clk)			-- On a clock edge:
	begin
		if(clk'event and clk = '1') then
			if(btn = btn_out) then
				debounce_timer <= debounce_timer + 1;	-- We add 1 to the timer
			else
				debounce_timer <= (others=>'0');
			end if;
		end if;
	end process;
	
	process(debounce_timer)						-- When the timer ticks
	begin
		if(debounce_timer = DEBOUNCE_NUMBER) then	-- If we have reached the end
			btn_next <= btn;										-- And load the buttons!
		else
			btn_next <= btn_out;
		end if;
	end process;
	
-----		End debouncing the buttons
-------------------------------------------------------



---------------------------------------
------------- Instance sram controller  
  sramCtl : sramController
    port map(
      clk => clk,
      rst => rst,
      addr => addr,
      data_m2s => write_data,
      mem => mem,
      rw => rw,
      ready => ready,
      data_valid => data_valid,
      data_s2m => read_data,
      MemAdr => MemAdr,
      RamCS => RamCS,
      MemWR => MemWR,
      MemOE => MemOE,
      RamUB => RamUB,
      RamLB => RamLB,
      MemDB => MemDB,
      RamADV => RamAdv,
      RamCRE => RamCRE,
      RamCLK => RamClk
      );
-------------- Finish controller instance
-----------------------------------------

------------------------------------------
---------------- 7 seg control
	 YEAH_CONTROL : seven_segment_control
    generic map (
      COUNTER_BITS => 15)
    port map (
      clk => clk,
      data_in => good_read,
      dp_in => "0000",
      blank => "0000",
      seg => seg,
      dp => dp,
      an => an);
---------------- 7 seg control
------------------------------------------
end taylor;

