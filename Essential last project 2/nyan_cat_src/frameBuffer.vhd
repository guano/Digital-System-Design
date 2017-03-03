
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity frameBuffer is
    Port ( clk : in  STD_LOGIC;
           btn0 : in  STD_LOGIC;
			  audioOut : out STD_LOGIC;
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
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
			  led		: out STD_LOGIC_VECTOR(7 downto 0);
			  an : out STD_LOGIC_VECTOR(3 downto 0));
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
	generic( CLK_RATE: natural);
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
	-- notice: my addresses are 24 bits long, and assume that we can reference each byte individually in the memory
	-- This is not true, but we only hand the memory the top 23 bits of the address.
	constant AUDIO_INTRO_START		: natural := 8388608;		-- 0x800000		-- notice the difference between these two is 344323
	constant AUDIO_INTRO_END		: natural := 8732931;		-- 0x854103		-- or 344KB, which is the size of our intro.
	constant AUDIO_MAIN_START		: natural := 8732976;		-- 0x854130
	constant AUDIO_MAIN_END			: natural := 11119424;		-- 0xa9ab40
	constant CLK_RATE					: natural := 50_000_000;
	
	------------------------------------------------------------------------------------------------------
	---------------------- these signals are for the wav reader. I will try to delete the unnecessary ones
	constant CLOCK_RATE : natural := 50_000_000;
	constant SAMPLE_RATE : natural := 88200;--44_100;
	constant SAMPLE_DURATION : natural := CLOCK_RATE / SAMPLE_RATE;
	constant BIT_WIDTH : natural := 8;
	constant MAX_DURATION_COUNTER_VALUE : natural := 2**BIT_WIDTH - 1;
	type count_direction is (up, down);
	signal rst : std_logic:='0';
	signal sampleNumber, nSampleNumber : unsigned (23 downto 0):=(others=>'0');
	signal timeSampleHeld, nTimeSampleHeld : unsigned (10 downto 0):=(others=>'0');

	signal curSample, next_sample : unsigned (7 downto 0):=(others=>'0');

	signal PWMCounter, nPWMCounter : unsigned(BIT_WIDTH - 1 downto 0):=(others=>'0');
	signal PWMCounterDirection, nPWMCounterDirection : count_direction:=up;
	---------------------- these signals are for the wav reader. I will try to delete the unnecessary ones
	------------------------------------------------------------------------------------------------------
	
	
	signal HS, VS, HS1, HS2, HS3, HS4, VS1, VS2, VS3, VS4: std_logic:='0';
	signal pixel_x, pixel_y: std_logic_vector(9 downto 0);
	
	signal mem: std_logic:= '0';
	signal data_valid, blank, bl1, bl2, bl3, bl4,bl5,bl6,bl7,bl8: std_logic;
	signal mem_data: std_logic_vector(15 downto 0);
	signal addr, addr_next, image_addr: std_logic_vector(22 downto 0);
	
	-- THIS IS ONE BIT TOO LONG- we index by the byte. the memory doesnt, so we use downto 1.
	signal audio_load_address, audio_load_address_next: unsigned(23 downto 0):= to_unsigned(AUDIO_INTRO_START, 24);
	signal pixel_data			: std_logic_vector(15 downto 0):= (others=>'0');
	signal pixel_data_next	: std_logic_vector(15 downto 0):= (others=>'0');
	signal data_loaded, data_loaded_next		: std_logic;
	
	
	signal animate_timer, animate_timer_next: unsigned(22 downto 0):= (others=>'0');
	signal image_number, image_number_next: unsigned(4 downto 0):=(others=>'0');
	
	type long_buffer is array (0 to 63) of std_logic_vector(8 downto 0);	-- I am thinking about having an extra bit here as a "valid" bit. what do you think?
	signal audio_cache : long_buffer;
	signal audio_cache_next : long_buffer;

	signal audio_save_address, audio_save_address_next: unsigned(4 downto 0):=(others=>'0');	-- an 8-bit address can do 0-255
	signal audio_play_address, audio_play_address_next: unsigned(4 downto 0):=(others=>'0');	-- again, an 8-bit address does 0-255
	
	signal count_to_four, count_to_four_next: unsigned(3 downto 0):=(others=>'0');
begin
	led	<= "00000000";--sw;
	an <= "1111";
	mem	<= '0'; 		-- we only read from memory
	image_addr 	<= std_logic_vector(image_number) & pixel_y(8 downto 0) & pixel_x(9 downto 1);
	addr_next	<= image_addr when blank = '0' else std_logic_vector(audio_load_address(23 downto 1));
	
	pixel_data_next	<= mem_data when data_valid = '1' else pixel_data;
	data_loaded_next	<= '1' when data_valid = '1' else '0';
	
	rst <= btn0;
	
	--------------------------------------------------------
	--------------- unclocked audio logic
	
	-- A simple counter to ensure that the sample is held for the proper duration
	nTimeSampleHeld <= (others => '0') when (timeSampleHeld = SAMPLE_DURATION) else timeSampleHeld + 1;
	
	-- The number of the sample. Used in memory calculations. Need to properly do that
	-- Currently only adds. Needs to be revised to support repeating sound
	nSampleNumber <= sampleNumber + 1 when (timeSampleHeld = SAMPLE_DURATION-1) else sampleNumber;
	
	-- So we count up and down between 0 and 255
	nPWMCounter <= PWMCounter + 1 when (PWMCounterDirection = up) else PWMCounter - 1;
	nPWMCounterDirection <= down when PWMCounter = 255 else up when PWMCounter = 0 else PWMCounterDirection;
	
	-- And we pulse modulate the output
	audioOut <= '1' when curSample >= PWMCounter else '0';
	
	count_to_four_next <= count_to_four + 1;
	--------------- End unclocked audio logic
	--------------------------------------------------------

	
	
	--------------------------------------------------------
	--------------- VGA output
	Vsync	<= VS;		-- outputs vsync 4 clock cycles behind
	Hsync <= HS;		-- outputs hsync 4 clock cycles behind
	vgaRed	<= "000" when blank = '1' else 
		sw(7 downto 5) when pixel_x(0) = '1' and pixel_data(7 downto 0) = "00000101" else
		sw(7 downto 5) when pixel_x(0) = '0' and pixel_data(15 downto 8) = "00000101"		else
		pixel_data(7 downto 5) when pixel_x(0) = '1' else 
		pixel_data(15 downto 13);
	vgaGreen	<= "000" when blank = '1' else 
		sw(4 downto 2) when pixel_x(0) = '1' and pixel_data(7 downto 0) = "00000101" else
		sw(4 downto 2) when pixel_x(0) = '0' and pixel_data(15 downto 8) = "00000101" else
		pixel_data(4 downto 2) when pixel_x(0) = '1' else 
		pixel_data(12 downto 10);
	vgaBlue	<= "00"  when blank = '1' else 
		sw(1 downto 0) when pixel_x(0) = '1' and pixel_data(7 downto 0) = "01" else
		sw(1 downto 0) when pixel_x(0) = '0' and pixel_data(15 downto 8) = "00000101" else
		pixel_data(1 downto 0) when pixel_x(0) = '1' else 
		pixel_data(9 downto 8);
	--------------- End VGA output
	--------------------------------------------------------



	process(clk, rst)
	begin 
		if(rst = '1') then
			
		elsif(clk' event and clk = '1') then
			audio_cache	<= audio_cache_next;
			
			addr	<= addr_next;
			audio_save_address	<= audio_save_address_next;
			audio_play_address	<= audio_play_address_next;
			audio_load_address	<= audio_load_address_next;
			
			---------------------------------------------------------------
			------------ Now for some clocked audio logic
			PWMCounter <= nPWMCounter;
			PWMCounterDirection <= nPWMCounterDirection;	
						-- In the wav reader, this is in a seperate process for some reason
			sampleNumber <= nSampleNumber;
			timeSampleHeld <= nTimeSampleHeld;
			
			curSample 	<= next_sample;
			------------ end clocked audio logic
			---------------------------------------------------------------
			

			---------------------------------------------------------------
			------------ Load the next data
			pixel_data				<= pixel_data_next;	-- 
			data_loaded				<= data_loaded_next;	-- data_loaded pulses a 1 every time pixel_data loads from data_valid.
			------------ This will be both image and audio data
			---------------------------------------------------------------
			
			
			---------------------------------------------------------------
			------------ Now for some image logic
			HS1 <= HS;		HS2 <= HS1;		HS3 <= HS2;		HS4 <= HS3;	-- 4 clock delay
			VS1 <= VS;		VS2 <= VS1;		VS3 <= VS2;		VS4 <= VS3;
			bl1 <= blank;	bl2 <= bl1;		bl3 <= bl2;		bl4 <= bl3; bl5 <= bl4; bl6<=bl5; bl7<=bl6; bl8<=bl7;
			animate_timer <= animate_timer_next;
			image_number <= image_number_next;
			
			if(animate_timer = 1750000) then		-- If 70ms has gone by, go to the next image
				animate_timer_next <= (others=>'0');
				if(image_number = 11) then
					image_number_next <= (others=>'0');
				else
					image_number_next <= image_number + 1;
				end if;
			else
				animate_timer_next <= animate_timer + 1;
				image_number_next <= image_number;
			end if;
			------------ end image logic
			---------------------------------------------------------------			
			
		end if; -- End if for clk'event
	end process;
	
	
	----------------------------------------------------------------
	-- This loads audio data from memory
	-- and saves it in the buffer. But only when we are blanking.
	process(data_loaded, blank, bl8, audio_save_address, pixel_data, audio_load_address, audio_cache, timeSampleHeld, audio_play_address, cursample)

	begin
		next_sample <= curSample;
		audio_play_address_next <= audio_play_address;
		audio_save_address_next	<= audio_save_address;
		audio_load_address_next <= audio_load_address;
		audio_cache_next <= audio_cache;		-- This prevents latches, right?
	
		-- Plays the current sample
		if(timeSampleHeld = 0) then -- we need to load a new sound sample!
			-- Notice we do not check to see if this address of the cache is valid- we just assume we write to it faster than we read. dangerous?
			next_sample <= unsigned(audio_cache(to_integer(audio_play_address))(7 downto 0));
			audio_cache_next(to_integer(audio_play_address))(8) <= '0'; -- we can use this part of the cache again
			audio_play_address_next	<= audio_play_address + 1;				-- we only read one at a time here.

		elsif(data_loaded = '1') then		-- We have loaded a new value! let us store it.
			if(bl8 = '1') then		-- We are currently doing sound data
				-- We check to see if this memory spot in our buffer is able to be saved to (has already been used)
				if(audio_cache(to_integer(audio_save_address))(8) = '0') then	-- This memory space is currently open
					-- So we save the data, increment the address to the cache, and increment the address to the sram
					audio_cache_next(to_integer(audio_save_address))		<= '1' & pixel_data(15 downto 8);	-- We mark this memory as used and save the top byte
					audio_cache_next(to_integer(audio_save_address + 1))	<= '1' & pixel_data(7 downto 0);		-- We mark this memory as used and save the bottom byte
					
					audio_save_address_next	<= audio_save_address + 2;	-- Increment cache address
					
					-- Increment the audio sram address
					if(audio_load_address >= AUDIO_INTRO_END and audio_load_address < AUDIO_MAIN_START) then	-- We have finished playing the intro
						audio_load_address_next	<= to_unsigned(AUDIO_MAIN_START, audio_load_address_next'length);	-- Time to move on to the main part
					elsif(audio_load_address >= AUDIO_MAIN_END) then	-- We have finished playing the main part
						audio_load_address_next	<= to_unsigned(AUDIO_MAIN_START, audio_load_address_next'length);	-- Time to repeat the main part
					else
						audio_load_address_next	<= audio_load_address + 2;		-- We add by 2 every time because we read
					end if;
				end if;
			end if;
		end if;	
	end process;
	-- We don't have to wait for a certain amount of counts, we just need to wait until data_valid tells us that we have loaded the next value.
	-- which happens when data_loaded is 1.
	-- POTENTIAL BUG- if data-valid is on for longer than one clock cycle, then this will make multiple values load.
	-- 	So we are assuming data_valid is only on for one clock.
	------------ End audio load
	---------------------------------------------------------------
	
	
---------------------------------------------
------------- Component instanciation
	 sramCtl : sramController
 generic map( CLK_RATE => CLK_RATE)
 port map(
	clk => clk,
	rst => rst,
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
	rst => rst,
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

