library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top is
    port (
		clk : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      sw : in  STD_LOGIC_VECTOR(7 downto 0);
		btn: in STD_LOGIC_VECTOR(3 downto 0);
		RsTx : out STD_LOGIC;
      seg : out  STD_LOGIC_VECTOR (6 downto 0);
      dp : out  STD_LOGIC;
      an : out  STD_LOGIC_VECTOR (3 downto 0);
		Led: out STD_LOGIC_VECTOR(7 downto 0));
end top;

architecture winner of top is
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
	

	signal busy: STD_LOGIC;
	signal debounce_timer: unsigned(19 downto 0):= (others=>'0');
	signal btn_out: STD_LOGIC_VECTOR(3 downto 0):= "0000";
	signal seven_seg_data: STD_LOGIC_VECTOR(15 downto 0):= (others=>'0');
	
	signal switch_data: STD_LOGIC_VECTOR(7 downto 0);
begin
Led <= sw;
switch_data <= "01111111" when btn_out(1) = '1' else
					"00001000" when btn_out(2) = '1' else
					"00001010" when btn_out(3) = '1' else sw;



---------------------------------------------------
-----		Instantiating components.
  -- tx entity
  utx: entity work.tx
    generic map (
      CLK_RATE => CLOCK_RATE,
      BAUD_RATE => BAUD_RATE
      )
    port map (
      clk => clk,
      data_in => switch_data,						-- Data in is the switches
      send_character => btn_out(0),	-- Send character is loaded to our debounced button
      rst => reset,					-- Haven't figured out yet what reset is
      tx_out => RsTx,			-- Output goes to our output
      tx_busy => busy					-- And we save the busy signal.
    );
	 
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
		
	seven_seg_data <= "00000000" & sw;
-----		End instanciating components
-------------------------------------------------------




---------------------------------------------------
-----		This debounces the buttons
	process(clk, reset, btn)			-- On a clock edge:
	begin
		if(reset = '1') then							-- Maybe we reset
			debounce_timer <= (others=>'0');
		elsif(btn(0) = '1') then
			debounce_timer <= (others=>'0');
		elsif(clk'event and clk = '1') then
		
			debounce_timer <= debounce_timer + 1;	-- We add 1 to the timer
		end if;
	end process;
	
	process(debounce_timer)						-- When the timer ticks
	begin
		if(debounce_timer >= DEBOUNCE_NUMBER) then	-- If we have reached the end
			btn_out <= btn;										-- And load the buttons!
		else
			btn_out <= btn_out;
		end if;
	end process;
	
-----		End debouncing the buttons
-------------------------------------------------------


end winner;

