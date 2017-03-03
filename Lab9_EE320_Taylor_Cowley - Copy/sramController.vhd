library ieee; 
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;
 
entity sramController is 
generic(CLK_RATE : NATURAL:= 50_000_000); 
port(
	clk, rst, mem, rw : in std_logic; 
	addr : in std_logic_vector(22 downto 0); 
	data_m2s : in std_logic_vector(15 downto 0); 
	data_valid, ready, MemOE, MemWr, RamCS, RamLB, RamUB, RamCLK, RamADV, RamCRE : out std_logic; 
	MemAdr : out std_logic_vector(22 downto 0);
	data_s2m : out std_logic_vector(15 downto 0); 
	MemDB : inout std_logic_vector(15 downto 0)  
);
end sramController;


architecture controller of sramController is 
	type state_type is (power_up, idle, w1, w2, w3, w4, w5, r1, r2, r3, r4, r5);
	signal state_reg, state_next : state_type; 
	signal power_count, power_count_next: unsigned(15 downto 0):= (others => '0');
	signal Rm2s, Rs2m: std_logic_vector(15 downto 0);
	signal Raddr : std_logic_vector(22 downto 0);
	signal tri_en : std_logic; 
begin

process(clk, rst)
begin 
	if(rst = '1') then 
	state_reg <= power_up; 
	elsif(clk' event and clk ='1') then 
	state_reg <= state_next; 
	power_count <= power_count_next;
	Raddr <= addr; 
--Rs2m <= MemDB; 
	end if; 
end process; 

process(mem, state_reg, rw, power_count, Rm2s, power_count_next)
begin
	RamCS <= '0';
	MemOE <= '1';
	MemWr <= '1';
	tri_en <= '0';
	ready <= '0'; 
	data_valid <= '0';
	case state_reg is 
		when power_up =>
			RamCS <= '1';
			if(power_count >= 7500) then 
				state_next <= idle; 
			else 
				power_count_next <= power_count+1;
				state_next <= power_up; 
			end if; 
		when idle => 
			ready <= '1'; 
			if(mem = '0') then 
				if(rw = '1') then 
					state_next <= r1; 
				else 
					Rm2s <= data_m2s;
					state_next <= w1; 
				end if; 
			else 
				state_next <= idle; 
			end if; 
		when w1 => 
			state_next <= w2; 
		when w2 => 
			MemWr <= '0';
			tri_en <= '1'; 
			state_next <= w3; 
		when w3 => 
			MemWr <= '0';
			tri_en <= '1'; 
			state_next <= w4; 
		when w4 => 
			MemWr <= '0';
			tri_en <= '1'; 
			state_next <= w5; 
		when w5 => 
			tri_en <= '1'; 
			state_next <= idle; 
			
			
		when r1 => 
			state_next <= r2; 
		when r2 => 
			MemOE <= '0';
			state_next <= r3; 
		when r3 => 
			MemOE <= '0';
			state_next <= r4; 
		when r4 => 
			MemOE <= '0';
			
			state_next <= r5; 
		when r5 => 
			Rs2m <= MemDB; 
			data_s2m		<= MemDB;
			data_valid <= '1';
			state_next <= idle;
			
			
	end case; 
end process; 
MemDB <= Rm2s when tri_en = '1' else (others => 'Z');
RamCLK <= '0'; 
RamADV <= '0'; 
RamCRE <= '0';
RamLB <= '0'; 
RamUB <= '0'; 
					MemAdr <= Raddr; 
					
end controller; 
























