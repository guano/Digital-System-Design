-- VGA Character Memory
--
-- This memory can store 128x32 characters where each character is
-- 8 bits. The memory is dual ported providing a port
-- to read the characters and a port to write the characters.
--
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity char_mem is
   port(
      clk: in std_logic;
      char_read_addr : in std_logic_vector(11 downto 0);
      char_write_addr: in std_logic_vector(11 downto 0);
      char_we : in std_logic;
      char_write_value : in std_logic_vector(7 downto 0);
      char_read_value : out std_logic_vector(7 downto 0)
   );
end char_mem;

architecture arch of char_mem is

   constant CHAR_RAM_ADDR_WIDTH: integer := 12; -- 2^7 X 2^5
   constant CHAR_RAM_WIDTH: integer := 8;  -- 8 bits per character
   type char_ram_type is array (0 to 2**CHAR_RAM_ADDR_WIDTH-1)
     of std_logic_vector(CHAR_RAM_WIDTH-1 downto 0);
   signal read_a : std_logic_vector(11 downto 0);

   -- character memory signal
   signal char_ram : char_ram_type;
begin

  -- character memory concurrent statement
  process(clk)
  begin
    if (clk'event and clk='1') then
      if (char_we = '1') then
        char_ram(to_integer(unsigned(char_write_addr))) <= char_write_value;
      end if;
      read_a <= char_read_addr;
    end if;
  end process;
  char_read_value <= char_ram(to_integer(unsigned(read_a)));
     
end arch;

