library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity colors is
    port ( clk : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
           vgaRed : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaGreen : out  STD_LOGIC_VECTOR (2 downto 0);
           vgaBlue : out  STD_LOGIC_VECTOR (1 downto 0);
			  
			  seg : out STD_LOGIC_VECTOR(6 downto 0);
			  dp : out STD_LOGIC;
			  an : out STD_LOGIC_VECTOR(3 downto 0));
end colors;

architecture yolo of colors is
	signal pixel_x:		STD_LOGIC_VECTOR (9 downto 0);
	signal pixel_y:		STD_LOGIC_VECTOR (9 downto 0);

	signal red,gre, bars_green_disp, bars_red_disp, cust_red, cust_gre: STD_LOGIC_VECTOR(2 downto 0);
	signal blu, bars_blue_disp, cust_blu: STD_LOGIC_VECTOR(1 downto 0);
	signal background_rgb, squares_rgb_out, cust_rgb, bars_rgb_out, one_rgb, two_rgb, tre_rgb, fro_rgb: STD_LOGIC_VECTOR(7 downto 0);
	signal one_on, two_on, tre_on, fro_on: STD_LOGIC;

	signal Hsy, Vsy:		STD_LOGIC;
	signal vR : 			STD_LOGIC_VECTOR (2 downto 0);
   signal vG : 			STD_LOGIC_VECTOR (2 downto 0);
   signal vB : 			STD_LOGIC_VECTOR (1 downto 0);
	signal bl: 				STD_LOGIC;

	signal control : std_logic_vector(35 downto 0);
	signal trigger : std_logic_vector(31 downto 0);
	
	component vga_timing
	port ( clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		HS : out  STD_LOGIC:= '0';
		VS : out  STD_LOGIC:= '0';
		pixel_x : out  STD_LOGIC_VECTOR (9 downto 0);
		pixel_y : out  STD_LOGIC_VECTOR (9 downto 0);
		last_column : out  STD_LOGIC;
		last_row : out  STD_LOGIC;
		blank : out  STD_LOGIC);
end component;

---------------------------------------------------------------------
  -- Component instantionation for the ChipScope Controller (ICON)
  ---------------------------------------------------------------------
  component chipscope_icon
    port (
      CONTROL0 : inout std_logic_vector(35 downto 0)
    );
  end component;

  ---------------------------------------------------------------------
  -- Component instantionation for the ChipScope Internal Logic Analyzer
  ---------------------------------------------------------------------
  component chipscope_ila
    port (
      CONTROL	: inout std_logic_vector(35 downto 0);
      CLK	:  in  std_logic;
      TRIG0	:  in std_logic_vector(31 downto 0)
      );
  end component;

begin
	process(clk)
	begin
		if(clk'event and clk='1') then 
			Hsync 	<= Hsy;
			Vsync 	<= Vsy;
			vgaRed	<= red;
			vgaGreen <= gre;
			vgaBlue	<= blu;
		end if;
	end process;


	seg<= "1111000";
	dp <= '1';
	an <= "1111";
	trigger <= '0' & bl & Hsy & Vsy & pixel_y & pixel_x & red & gre & blu;
	
	vga_timer: vga_timing port map
		(clk=>clk, rst=>btn(3), HS=>Hsy, VS=>Vsy, 
		 pixel_x=>pixel_x, pixel_y=>pixel_y, 
		 last_column=>open, last_row=>open, blank=>bl);
		 
		 
		 

	red 	<= "000" when bl = '1' else
				squares_rgb_out(7 downto 5) when btn(0) = '1' else
				cust_rgb			(7 downto 5) when btn(1) = '1' else --custom image
				sw					(7 downto 5) when btn(2) = '1' else --switches color
				bars_rgb_out	(7 downto 5); --vertical bars
				
	gre 	<= "000" when bl = '1' else 
				squares_rgb_out(4 downto 2) when btn(0) = '1' else
				cust_rgb			(4 downto 2) when btn(1) = '1' else --custom image
				sw					(4 downto 2) when btn(2) = '1' else --switches color
				bars_rgb_out	(4 downto 2); --vertical bars
	
	blu 	<= "00" when bl = '1' else
				squares_rgb_out(1 downto 0) when btn(0) = '1' else
				cust_rgb			(1 downto 0) when btn(1) = '1' else --custom image
				sw					(1 downto 0) when btn(2) = '1' else --switches color
				bars_rgb_out	(1 downto 0); --vertical bars	
		
-- Button NOTHING
-- This is to make the vertical bars
	bars_red_disp   <= 	"000" when unsigned(pixel_x) < 320 else "111";
	bars_green_disp <= 	"000" when unsigned(pixel_x) < 159 else 
					"111" when unsigned(pixel_x) < 320 else
					"000" when unsigned(pixel_x) < 480 else
					"111";
	bars_blue_disp  <= 	"00"  when unsigned(pixel_x) < 80  else  -- blue is always zero for this particular display
					"11"  when unsigned(pixel_x) < 160  else
					"00"  when unsigned(pixel_x) < 240  else
					"11"  when unsigned(pixel_x) < 320  else
					"00"  when unsigned(pixel_x) < 400  else
					"11"  when unsigned(pixel_x) < 480  else
					"00"  when unsigned(pixel_x) < 560  else
					"11";
	bars_rgb_out <= bars_red_disp & bars_green_disp & bars_blue_disp;

-- Button 0
-- This is to make the squares	
	one_on <= '1' when unsigned(pixel_x) >= 180 and unsigned(pixel_x) < 280 and
		unsigned(pixel_y) >= 100 and unsigned(pixel_y) < 200 else
		'0';
	one_rgb <= "111" & "000" & "00"; -- red


	two_on <= '1' when unsigned(pixel_x) >= 400 and unsigned(pixel_x) <500 and
		unsigned(pixel_y) >= 100 and unsigned(pixel_y) <200 else
		'0';
	two_rgb <= "000" & "111" & "00"; -- green

	
	tre_on <= '1' when unsigned(pixel_x) >= 180 and unsigned(pixel_x) <280 and
		unsigned(pixel_y) >= 300 and unsigned(pixel_y) <400 else
		'0';
	tre_rgb <= "111" & "111" & "00"; -- yellow
	
	
	fro_on <= '1' when unsigned(pixel_x) >= 400 and unsigned(pixel_x) <500 and
		unsigned(pixel_y) >= 300 and unsigned(pixel_y) <400 else
		'0';
	fro_rgb <= "111" & "000" & "11"; -- magenta

-- Default value when no object is being displayed
	background_rgb <= "11111111";

	squares_rgb_out <=  one_rgb  when one_on = '1' else
				two_rgb  when two_on = '1' else
				tre_rgb  when tre_on = '1' else
				fro_rgb  when fro_on = '1' else
				background_rgb;
					
-- Button 1
-- Custom! Very special shapes- TAY :)
	cust_red	<= "111" when unsigned(pixel_x)>=40 and unsigned(pixel_x)<200 and unsigned(pixel_y)>=50 and unsigned(pixel_y)<100 else
					"111" when unsigned(pixel_x)>=100 and unsigned(pixel_x)<140 and unsigned(pixel_y)>=100 and unsigned(pixel_y)<400 else
					sw(7 downto 5) when btn(2) = '1' else
					"000";
	cust_gre <= "111" when unsigned(pixel_x)>=240 and unsigned(pixel_x)<400 and unsigned(pixel_y)>=100 and unsigned(pixel_y)<140 else
					"111" when unsigned(pixel_x)>=240 and unsigned(pixel_x)<293 and unsigned(pixel_y)>=140 and unsigned(pixel_y)<400 else
					"111" when unsigned(pixel_x)>=387 and unsigned(pixel_x)<400 and unsigned(pixel_y)>=140 and unsigned(pixel_y)<400 else
					"111" when unsigned(pixel_x)>=293 and unsigned(pixel_x)<387 and unsigned(pixel_y)>=180 and unsigned(pixel_y)<220 else
					sw(4 downto 2) when btn(2) = '1' else
					"000";
	cust_blu <= "11"  when unsigned(pixel_x)>=440 and unsigned(pixel_x)<495 and unsigned(pixel_y)>=100 and unsigned(pixel_y)<180 else
					"11"  when unsigned(pixel_x)>=527 and unsigned(pixel_x)<580 and unsigned(pixel_y)>=100 and unsigned(pixel_y)<180 else
					"11"  when unsigned(pixel_x)>=495 and unsigned(pixel_x)<527 and unsigned(pixel_y)>=140 and unsigned(pixel_y)<400 else
					sw (1 downto 0) when btn(1) = '1' else
					"00";
	cust_rgb <= cust_red & cust_gre & cust_blu;



-------------------------------------------------------------------
  --  ICON core instance
  -------------------------------------------------------------------
  ICON_inst:  chipscope_icon
    port map (
      CONTROL0 => control
    );
  
  -------------------------------------------------------------------
  --  ILA core instance
  -------------------------------------------------------------------
  ILA_inst : chipscope_ila
    port map (
      CONTROL	=> control,
      CLK	=> clk,	
      TRIG0	=> trigger
      );
		
		
end yolo;










