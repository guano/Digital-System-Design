
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity charGen is
    Port ( clk : in  STD_LOGIC;
           char_we : in  STD_LOGIC;
           char_value : in  STD_LOGIC_VECTOR (7 downto 0);
           char_addr : in  STD_LOGIC_VECTOR (11 downto 0);
           pixel_x : in  STD_LOGIC_VECTOR (9 downto 0);
           pixel_y : in  STD_LOGIC_VECTOR (9 downto 0);
           pixel_out : out  STD_LOGIC);
end charGen;

architecture taylor of charGen is
	signal char_read_addr 	: STD_LOGIC_VECTOR(11 downto 0):= (others=>'0');
	--signal char_write_addr	: STD_LOGIC_VECTOR(11 downto 0):= (others=>'0');
	--signal char_write_value	: STD_LOGIC_VECTOR(7 downto 0):= (others=>'0');
	signal char_read_value	: STD_LOGIC_VECTOR(7 downto 0):= (others=>'0');
	
	signal font_rom_addr  	: STD_LOGIC_VECTOR(10 downto 0):= (others=>'0');
	signal font_rom_data  	: STD_LOGIC_VECTOR(7 downto 0):= (others=>'0');
	
	signal pixel_x_1			: STD_LOGIC_VECTOR(9 downto 0):= (others=>'0');
	signal pixel_x_2			: STD_LOGIC_VECTOR(9 downto 0):= (others=>'0');
	
	signal char_x_pos	: STD_LOGIC_VECTOR(6 downto 0):= (others=>'0');
	signal char_y_pos : STD_LOGIC_VECTOR(4 downto 0):= (others=>'0');
	signal char_x_pixel:STD_LOGIC_VECTOR(2 downto 0):= (others=>'0');
	signal char_y_pixel:STD_LOGIC_VECTOR(3 downto 0):= (others=>'0');
begin
	char_x_pos		<= pixel_x(9 downto 3);
	char_y_pos		<= pixel_y(8 downto 4);
	char_x_pixel	<= pixel_x(2 downto 0);
	char_y_pixel	<= pixel_y(3 downto 0);
	
	
	char_read_addr <= char_y_pos & char_x_pos;
	font_rom_addr 	<= char_read_value(6 downto 0) & char_y_pixel;
	
	pixel_out		<= font_rom_data((7 - to_integer(unsigned(pixel_x_2(2 downto 0)))));
	
	process(clk)
	begin
		if(clk'event and clk = '1') then
			pixel_x_1 <= pixel_x;
			pixel_x_2 <= pixel_x_1;
		end if;
	end process;


-----------------------------------------------
-- Instanciating our font rom and character rom

	font : entity WORK.Font_rom
	port map (
		clk  => clk,
		addr => font_rom_addr,
		data => font_rom_data);

	char : entity WORK.char_mem
	port map(
		clk					=> clk,
		char_read_addr		=> char_read_addr,
		char_write_addr	=> char_addr,
		char_we				=> char_we,
		char_write_value	=> char_value,
		char_read_value	=> char_read_value);
		
-- End component instanciation
-------------------------------------------------
end taylor;

