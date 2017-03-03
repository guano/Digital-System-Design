-- Homework 9 part 3 (March 04)
-- Taylor Cowley
-- 
-- 1) (Supplied entity) 
-- 	a) Input and output ports?
-- 		There are 2 input (read) ports and 1 output (write) ports
--		b) Size of RAM? 
-- 		32x4
-- 	c) Synchronous/Asynchronous read?
-- 		Synchronous Read!
-- 	d) What is read from the port when both read and write are enabled?
--			The module is read_first mode, so the data that was previously at that
-- address before the write will be read when the write is asserted, NOT the data
-- that we are currently writing
-- 
-- 2) 	Create	a	single	VHDL	architecture	that	implements	a	2048x8	"FIFO"	circuit	using	
-- a	Xilinx	BRAM	block.		Unlike	your	previous	problem,	complete	this	FIFO	by	
-- "inferring" the	Block	RAM	instead	of	directly	instantiating	the	component	into	
-- your	design.	
-- 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library unisim;
use unisim.VCOMPONENTS.all;

entity INFERRED_FIFO is
    Port ( data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           wr : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0);
           full : out  STD_LOGIC;
           empty : out  STD_LOGIC;
			  clk: in STD_LOGIC;
			  reset: in STD_LOGIC);
end INFERRED_FIFO;

architecture part3 of BRAM_FIFO is


signal full, empty: std_logic;
signal r_addr, w_addr: std_logic_vector(2047 downto 0);

signal w_ptr_reg, w_ptr_next: unsigned(2047 downto 0);
signal r_ptr_reg, r_ptr_next: unsigned(2047 downto 0);
signal full_flag, empty_flag: std_logic;
signal out_reg: std_logic_vector(7 downto 0);

   constant ADDR_WIDTH: integer := 6;
   constant RAM_WIDTH: integer := 8;  -- 8 bits per character
   type ram_type is array (0 to 2**ADDR_WIDTH-1)
     of std_logic_vector(RAM_WIDTH-1 downto 0);
   signal read_a : std_logic_vector(5 downto 0);

   signal ram : ram_type;

begin
	
	  -- character memory concurrent statement
  process(clk)
  begin
    if (clk'event and clk='1') then
      if (char_we = '1') then
        ram(to_integer(unsigned(w_addr))) <= data_in;
      end if;
      read_a <= r_addr;
    end if;
  end process;
  out_reg <= ram(to_integer(unsigned(read_a)));
     
	
	
	
   -- register
   process(clk,reset)
   begin
      if (reset='1') then
         w_ptr_reg <= (others=>'0');
         r_ptr_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         w_ptr_reg <= w_ptr_next;
         r_ptr_reg <= r_ptr_next;
      end if;
   end process;
   -- write pointer next-state logic
   w_ptr_next <=
      w_ptr_reg + 1 when wr='1' and full_flag='0' else
      w_ptr_reg;
   full_flag <=
      '1' when r_ptr_reg(N) /=w_ptr_reg(N) and
             r_ptr_reg(N-1 downto 0)=w_ptr_reg(N-1 downto 0)
          else
      '0';
   -- write port output
   w_addr <= std_logic_vector(w_ptr_reg(N-1 downto 0));
   full <= full_flag;
   -- read pointer next-state logic
   r_ptr_next <=
      r_ptr_reg + 1 when rd='1' and empty_flag='0' else
      r_ptr_reg;
   empty_flag <= '1' when r_ptr_reg=w_ptr_reg else
                 '0';
   -- read port output
   r_addr <= std_logic_vector(r_ptr_reg(N-1 downto 0));
   empty <= empty_flag;

end part3;
