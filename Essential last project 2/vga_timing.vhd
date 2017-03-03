
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_timing is
	Port ( clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		HS : out  STD_LOGIC;
		VS : out  STD_LOGIC;
		pixel_x : out  STD_LOGIC_VECTOR (9 downto 0);
		pixel_y : out  STD_LOGIC_VECTOR (9 downto 0);
		last_column : out  STD_LOGIC;
		last_row : out  STD_LOGIC;
		blank : out  STD_LOGIC);
end vga_timing;

architecture Behavioral of vga_timing is
	signal pixel_en: STD_LOGIC := '0';
	signal column_counter: 	unsigned(9 downto 0) := "0000000000";
	signal row_counter: 		unsigned(9 downto 0) := "0000000000";
	signal blank_x, blank_y: STD_LOGIC := '0';
begin
	process(clk, rst)
	begin
		if(clk'event and clk = '1') then
			if(pixel_en = '0') then
				pixel_en <= '1';
			elsif (pixel_en = '1') then
				pixel_en <= '0';
			
			
			-- If statement for the horizontal counter logic
				if(column_counter = "1100011111") then -- 799 back door ends time to reset
					column_counter <= "0000000000";
					blank_y <= '0';
					
					-- And we have a nested if for our vertical counter logic!
					-- Vertical counter!
					if(row_counter = "1000001000") then -- 520 back door ends time to reset
						row_counter <= "0000000000";
						blank_x <= '0';
					else -- Not resetting the row counter
						if(row_counter = "0111011110") then -- 478 retrace begins at front porch
							last_row <= '1';
						elsif(row_counter = "0111011111") then -- 479 not the last row anymore
							last_row <= '0';
							blank_x <= '1';
--						if(row_counter = "0111011111") then -- 479 retrace begins at front porch
--							last_row <= '1';
--							last_row <= '0';
--						elsif(row_counter = "0111100000") then -- 480 not the last row anymore
--							blank_x <= '1';
						elsif(row_counter = "0111101001") then -- 489 pulse begins
							VS <= '0'; -- This means the pulse is on
						elsif(row_counter = "0111101011") then -- 491 back door begins
							VS <= '1'; -- Turn off the pulse for the back door
						end if;
						row_counter <= row_counter + 1;
					end if;
				
				else -- Not resetting the column counter
					if(column_counter = "1001111110") then -- 638, retrace begins at front porch
						last_column <= '1';
					elsif(column_counter = "1001111111") then -- 639 Not the last column anymore
						last_column <= '0';
						blank_y <= '1';
--					if(column_counter = "1001111111") then -- 639, retrace begins at front porch
--						last_column <= '1';
--						blank_y <= '1';
--					elsif(column_counter = "1010000000") then -- 640 Not the last column anymore
--						last_column <= '0';
					elsif(column_counter = "1010001111") then -- 655 pulse begins
						HS <= '0'; -- This means the pulse is on
					elsif(column_counter = "1011101111") then -- 751 back door begins
						HS <= '1'; -- Turn off the pulse
					end if;
					-- count up when we aren't resetting
					column_counter <= column_counter + 1;
				end if; -- column counter = 799
				
			end if; -- pixel_en = '1'
		end if;
		if(rst = '1') then
			column_counter <= "0000000000";
			row_counter 	<= "0000000000";
			HS					<= '1';
			VS					<= '1';
			last_column		<= '0';
			last_row			<= '0';
			blank_x			<= '0';
			blank_y			<= '0';
			pixel_en			<= '0';
		end if; -- clk'event and clk = '1' or reset
	end process;
	
	pixel_x <= std_logic_vector(column_counter);
	pixel_y <= std_logic_vector(row_counter);
	blank <= blank_x or blank_y;
end Behavioral;
