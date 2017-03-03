
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port ( btn : in  STD_LOGIC_VECTOR (3 downto 0);
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
           led : out  STD_LOGIC_VECTOR (7 downto 0);
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
           vgaRed : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaGreen : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaBlue : out  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC;
			  seg : out  STD_LOGIC_VECTOR (6 downto 0);
           dp : out  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end top;

architecture taylor of top is



---------------------------------------------
------------- Load the components
component charGen
   port(
     clk : in std_logic;
     char_we : in std_logic;
     char_value : in std_logic_vector(7 downto 0);
     char_addr : in std_logic_Vector(11 downto 0);
     pixel_x : in std_logic_vector(9 downto 0);
     pixel_y : in std_logic_vector(9 downto 0);
     pixel_out : out std_logic
    );
  end component;
    
component vga_timing
	Port ( clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		HS : out  STD_LOGIC;
		VS : out  STD_LOGIC;
		pixel_x : out  STD_LOGIC_VECTOR (9 downto 0);
		pixel_y : out  STD_LOGIC_VECTOR (9 downto 0);
		last_column : out  STD_LOGIC;
		last_row : out  STD_LOGIC;
		blank : out  STD_LOGIC);
end component;

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
------------- End loading the components
----------------------------------------------
  
  
  
	signal char_we: std_logic;
	signal char_write_value: std_logic_vector(7 downto 0);
	signal char_addr: std_logic_vector(11 downto 0);
	signal pixel_x: std_logic_vector(9 downto 0);
	signal pixel_y: std_logic_vector(9 downto 0);
	signal pixel_out: std_logic;
	
	signal rst: std_logic;
	signal blank: std_logic;
	
	signal HS, HS1, HS2, VS, VS1, VS2: std_logic;
	
	signal seg_data : std_logic_vector(15 downto 0);
	
	signal char_x_pos,char_x_pos_next	: STD_LOGIC_VECTOR(6 downto 0):= (others=>'0');
	signal char_y_pos,char_y_pos_next : STD_LOGIC_VECTOR(4 downto 0):= (others=>'0');
	
	signal btn_out, btn_next: std_logic_vector(3 downto 0):=(others=>'0');
	signal debounce_timer: unsigned(19 downto 0):= (others=>'0');
	signal btn_hold, btn_hold_next: std_logic:='0';
	constant DEBOUNCE_NUMBER: natural := 300_000;
	
	signal char_we_next:std_logic:='0';
begin


---------------------------------------------------
-----		This debounces the buttons
	process(clk)			-- On a clock edge:
	begin
		if(clk'event and clk = '1') then
			if(btn = btn_out) then
				debounce_timer <= (others=>'0');
			else
				debounce_timer <= debounce_timer + 1;	-- We add 1 to the timer
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
	
	-- Test the switches
	led	<= sw;
	
	-- btn 3 is the reset. 
	rst	<= btn(3);
	
	-- These are properly hiding behind 2 registers I think
	Hsync <= HS2;	
	Vsync	<= VS2;	
	
	-- Char_write_value gets written by the switches
	char_write_value	<= sw;
	char_addr <= char_y_pos & char_x_pos;
	
	-- The 7 segment display shows what we will send
	seg_data	<= "00000000" & sw;
	
	vgaBlue	<= "11" when pixel_out = '1' and blank = '0' else "00";
	vgaGreen	<= "111" when pixel_out = '1' and blank = '0' else "000";
	vgaRed	<= "001" when pixel_out = '1' and blank = '0' else "110";
	
	process(clk)
	begin
		if(clk'event and clk = '1') then
			btn_out		<= btn_next;
			-- Have to register Horiz and Vert sync
			HS1	<= HS;
			VS1	<= VS;
			HS2	<= HS1;
			VS2	<= VS1;
			btn_hold<= btn_hold_next;
			char_y_pos<= char_y_pos_next;
			char_x_pos<= char_x_pos_next;
			char_we<= char_we_next;
			
			if(btn_out(0) = '1') then
				if(btn_hold = '0') then
					-- write a character
					-- increment the character position
					char_we_next <= '1';
					
					if(unsigned(char_x_pos) >= 79) then
						char_x_pos_next <= (others=>'0');
						if(unsigned(char_y_pos) >= 28) then
							char_y_pos_next<= (others=>'0');
						else
							char_y_pos_next<= std_logic_vector(unsigned(char_y_pos) + 1);
						end if;
					else
						char_x_pos_next <= std_logic_vector(unsigned(char_x_pos) + 1);
					end if;
				else
					char_we_next <= '0';
				end if;
				btn_hold_next <= '1';
				
			else
				btn_hold_next <= '0';
				char_we_next <= '0';
			end if;
			
		end if;
	end process;
	
	
	
----------------------------------------------
-------------- Instanciate our components
	yomama: charGen
    port map (
      clk => clk,
      char_we => char_we,
      char_value => char_write_value,
      char_addr => char_addr,
      pixel_x => pixel_x,
      pixel_y => pixel_y,
      pixel_out => pixel_out);
	
	vga_timer: vga_timing port map
		(clk=>clk, rst=>rst, HS=>HS, VS=>VS, 
		 pixel_x=>pixel_x, pixel_y=>pixel_y, 
		 last_column=>open, last_row=>open, blank=>blank);
		 
	YEAH_CONTROL : seven_segment_control
    generic map (
      COUNTER_BITS => 15)
    port map (
      clk => clk,
      data_in => seg_data,
      dp_in => "0000",
      blank => "1100",
      seg => seg,
      dp => dp,
      an => an);
-------------- End component instanciation
----------------------------------------------
end taylor;

