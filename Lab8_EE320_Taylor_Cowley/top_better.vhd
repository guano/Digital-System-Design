library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_better is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           RsRx : in  STD_LOGIC;
           Led : out  STD_LOGIC_VECTOR (7 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           dp : out  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0);
			  sw : in STD_LOGIC_VECTOR (7 downto 0));
end top_better;

architecture taylor of top_better is
---------------------------------------------------
-----		Load our necessary component
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
-----		End loading components
-------------------------------------------------------


	constant CLOCK_RATE : natural := 50_000_000;
	constant BAUD_RATE : natural := 19_200;
	constant DEBOUNCE_NUMBER: natural := 300_000;
	constant DISPLAY_COUNTER_BITS : Integer := 15;
	
	signal seven_seg_data: STD_LOGIC_VECTOR(15 downto 0):= (others=>'0');
	signal data_out: STD_LOGIC_VECTOR(7 downto 0);
	signal rx_in_1, rx_in_2: STD_LOGIC := '0';
	signal data_strobe : STD_LOGIC;
	signal rx_busy: STD_LOGIC;
begin
	Led<= "11111111";
	seven_seg_data <= "1111111111111111";
	-- We have 2 doubly-registered things:
		-- RsRx, before it goes to our UART receiver
		-- dataOut, coming from the UART receiver going to the 7-seg
	process(reset, clk)
	begin
		if(reset = '1') then
			
		elsif(clk'event and clk = '1') then
--			rx_in_1 <= RsRx;		-- Our first register gets the value from the computer
--			rx_in_2 <= rx_in_1;	-- Our second register gets the value from register 1
			
			-- Our data out has an enable signal: data_strobe
			-- The way this works is we just shift left 8 and then add the new stuff at the beginning.
--			if(data_strobe = '1') then
--				seven_seg_data <= seven_seg_data(7 downto 0) & data_out;
--			end if;
		end if;
	end process;


---------------------------------------------------
-----		Instantiating components.
 
	 -- rx entity
--	 urx: entity work.rx
--		generic map(
--			CLK_RATE => CLOCK_RATE,
--			BAUD_RATE => BAUD_RATE
--			)
--		port map(
--			clk => clk,
--			rx_in => rx_in_2,
--			rst => reset,
--			data_out => data_out,
--			data_strobe => data_strobe,
--			rx_busy => rx_busy);
--	 
	 -- 7 seg control
	 YEAH_CONTROL : seven_segment_control
    generic map (
      COUNTER_BITS => DISPLAY_COUNTER_BITS)
    port map (
      clk => clk,
      data_in => seven_seg_data,
      dp_in => "0000",
      blank => "0000",
      seg => seg,
      dp => dp,
      an => an);
-----		End instanciating components
-------------------------------------------------------
end taylor;

