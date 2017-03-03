library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_top is
    port ( clk : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
			  sw : in  STD_LOGIC_VECTOR (7 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           dp : out  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end seven_segment_top;

architecture yolo of seven_segment_top is
	signal ssc_data: STD_LOGIC_VECTOR(15 downto 0);
	signal ssc_dp: STD_LOGIC_VECTOR(3 downto 0);
	signal ssc_blank: STD_LOGIC_VECTOR(3 downto 0);
	signal counter_32_bit: unsigned(31 downto 0) := to_unsigned(0, 32);
	constant DISPLAY_COUNTER_BITS : Integer := 15;
	
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
     an : out std_logic_vector(3 downto 0)
     );
end component;
	
	
	
begin
  YEAH_CONTROL : seven_segment_control
    generic map (
      COUNTER_BITS => DISPLAY_COUNTER_BITS)
    port map (
      clk => clk,
      data_in => ssc_data,
      dp_in => ssc_dp,
      blank => ssc_blank,
      seg => seg,
      dp => dp,
      an => an);

	process(clk)
	begin
	--finish the clock ticking.
		if(CLK'EVENT and clk = '1') then
			counter_32_bit <= counter_32_bit + 1;
		
	
		if(btn(3) = '1') then
			-- Blank everything
			ssc_data <= "1011111011101111";
			ssc_dp <= "0000";
			ssc_blank <= "1111";
		elsif(btn(2) = '1') then
			-- BEEF with no digit points
			ssc_data <= "1011111011101111";
			ssc_dp <= "0000";
			ssc_blank <= "0000";
		elsif(btn(1) = '1') then
			-- HEX of 8 switches on right 2 digits, left ones blank, AN1 digit
			ssc_data <= "10101010" & sw;
			ssc_dp <= "0010";
			ssc_blank <= "1100";
		elsif(btn(0) = '1') then
			-- Display the bottom 16 bits of the 32-bit counter
			-- ALL digit points
			ssc_data <= std_logic_vector(counter_32_bit(15 downto 0));
			ssc_dp <= "1111";
			ssc_blank <= "0000";
		else --No buttons
			-- Display the top 16 bits of the 32-bit counter
			-- Digit point with left-most digit????
			ssc_data <= std_logic_vector(counter_32_bit(31 downto 16));
			ssc_dp <= "1000";
			ssc_blank <= "0000";
		end if;
		end if;
	end process;
end yolo;

