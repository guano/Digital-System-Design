-- Taylor Cowley
-- HW 9 part 2
-- Instance a BRAM with the component

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library unisim;
use unisim.VCOMPONENTS.all;

entity BRAM_FIFO is
    Port ( data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           wr : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0);
           full : out  STD_LOGIC;
           empty : out  STD_LOGIC;
			  clk: in STD_LOGIC;
			  reset: in STD_LOGIC);
end BRAM_FIFO;

architecture part2 of BRAM_FIFO is
	----- component RAMB16_S9_S9 -----
component RAMB16_S9_S9
port (
DOA : out std_logic_vector(7 downto 0);
DOB : out std_logic_vector(7 downto 0);
DOPA : out std_logic_vector(0 downto 0);
DOPB : out std_logic_vector(0 downto 0);
ADDRA : in std_logic_vector(10 downto 0);
ADDRB : in std_logic_vector(10 downto 0);
CLKA : in std_ulogic;
CLKB : in std_ulogic;
DIA : in std_logic_vector(7 downto 0);
DIB : in std_logic_vector(7 downto 0);
DIPA : in std_logic_vector(0 downto 0);
DIPB : in std_logic_vector(0 downto 0);
ENA : in std_ulogic;
ENB : in std_ulogic;
SSRA : in std_ulogic;
SSRB : in std_ulogic;
WEA : in std_ulogic;
WEB : in std_ulogic
);
end component;
	-------------- END COMPONENT ---------------

signal ENB : std_ulogic;
signal SSRA : std_ulogic;
signal SSRB : std_ulogic;


signal WEA : std_logic;

signal full, empty: std_logic;
signal r_addr, w_addr: std_logic_vector(2047 downto 0);

signal w_ptr_reg, w_ptr_next: unsigned(2047 downto 0);
signal r_ptr_reg, r_ptr_next: unsigned(2047 downto 0);
signal full_flag, empty_flag: std_logic;

begin
	
	MEMORY: RAMB16_S9_S9 port map(
		DOA => open;
		DOB => data_out;
		DOPA => open;
		DOPB => open;
		ADDRA => w_addr;
		ADDRB => r_addr;
		CLKA => clk;
		CLKB => clk;
		DIA => data_in;
		DIB => "00000000";
		DIPA => open;
		DIPB => open;
		ENA => '1';
		ENB => ENB;
		SSRA => SSRA;
		SSRB => SSRB;
		WEA => WEA;
		WEB => '0'	)	;
	
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

end part2;

