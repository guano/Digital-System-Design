library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sramController is
	generic(	CLK_RATE: natural:=50000);
	port (clk : in  STD_LOGIC;
			rst : in  STD_LOGIC;
			addr : in  STD_LOGIC_VECTOR (22 downto 0);
	-- Data from controller to be WRITTEN into memory
			data_m2s : in  STD_LOGIC_VECTOR (15 downto 0);
			mem : in  STD_LOGIC;
			rw : in  STD_LOGIC;
	-- Data READ from memory
			data_s2m : out  STD_LOGIC_VECTOR (15 downto 0);
			data_valid : out  STD_LOGIC;
			ready : out  STD_LOGIC;
	-- Address pins to the memory
			MemAdr : out  STD_LOGIC_VECTOR (22 downto 0);
			MemOE : out  STD_LOGIC;
			MemWR : out  STD_LOGIC;
			RamCS : out  STD_LOGIC;		-- CE
			RamLB : out  STD_LOGIC;
			RamUB : out  STD_LOGIC;
			RamCLK : out  STD_LOGIC;
			RamADV : out  STD_LOGIC;
			RamCRE : out  STD_LOGIC;
	-- Data pins to the memory
			MemDB : inout  STD_LOGIC_VECTOR (15 downto 0));
end sramController;

architecture YOLO of sramController is
	type memory_states is (power_up, idle, r_00, r_20, r_40, r_60, r_unnecessary, w_00, w_20, w_40, w_60, w_unnecessary);
	signal state, state_next : memory_states := power_up;
	signal tri_en	: STD_LOGIC;					-- tri_state enable. Whatever that means
	signal Raddr, Raddr_next	: STD_LOGIC_VECTOR(22 downto 0);		-- Register to store the address
	signal Rs2m, Rs2m_next		: STD_LOGIC_VECTOR(15 downto 0);		-- Data read from RAM (2 bytes)
	signal Rm2s, Rm2s_next		: STD_LOGIC_VECTOR(15 downto 0);		-- Data to write to RAM (2 bytes)
	
	-- We are taught to use good variable names. Good luck figuring out what it does!
	signal d			: STD_LOGIC_VECTOR(15 downto 0);
	
	signal power_up_count, power_up_count_next: unsigned(13 downto 0):= (others=>'0');	-- Big enough to count to 7500
begin

RamCLK 	<= '0';		-- We are asynchronous; don't need the clock
RamADV	<= '0';		-- Don't need this for asynchronous
RamCRE	<=	'0';		-- Not used

RamLB		<= '0';		-- We always work with 
RamUB		<=	'0';		-- both bytes. 

d			<= Rm2s when tri_en = '1' else (others=>'Z');
MemAdr	<= Raddr;
data_s2m	<= Rs2m;
MemDB		<= d;

-- Registers
process(clk, rst)
begin
	if(rst = '1') then
		state 			<= power_up;
		Raddr				<= (others=>'0');
		Rs2m				<= (others=>'0');
		Rm2s				<= (others=>'0');
		power_up_count	<= (others=>'0');
	elsif(clk'event and clk = '1') then
		state 			<= state_next;
		Raddr				<= Raddr_next;
--		if(mem = '0') then
--			Raddr				<= addr;
--		end if;
		Rs2m				<= Rs2m_next;
		Rm2s				<= Rm2s_next;
		power_up_count	<= power_up_count_next;
	end if;
end process;


-- State machine logic
process(state, power_up_count, mem, rw, MemDB, addr)
begin
	-- Defaults
	RamCS			<= '0';			-- CE is active (low-asserted)
	MemOE			<= '1';			-- Output is disabled
	MemWR			<= '1';			-- Writing is disabled
	tri_en		<= '0';			-- Tri-state driver disabled
	ready			<= '0';			-- We are not ready
	data_valid	<= '0';			-- The data is rarely ready
	case state is
		when power_up 	=>
			RamCS		<= '1';		-- Chip is disabled during power-up
			if(power_up_count >= 7500) then -- 150usec
				power_up_count_next <= (others=>'0');
				state_next		<= idle;
			else
				power_up_count_next <= power_up_count + 1;			-- TODO: figure out why this is bad
				state_next		<= power_up;
			end if;
		when idle 		=>
			ready <= '1';
			if(mem = '0') then	-- We are starting a memory event!
				Raddr_next		<= addr;		-- Load the address
--				Raddr		<= addr;		-- Load the address
				if(rw = '1') then		-- We are doing a read!
					state_next	<= r_20;		-- Start the reading
				else						-- We are initiating a write!
					state_next	<= w_00;
				end if;
			else						-- No memory event; Boring.
				state_next		<= idle;
			end if;
		when r_00		=>
			MemOE			<= '1';		-- Do not turn on the output enable yet
			state_next	<= r_20;
		when r_20		=>
			MemOE			<= '1';		-- Still don't turn on the output enable
			state_next	<= r_40;
		when r_40		=>
			MemOE			<= '0';		-- Turn on the output enable!
			state_next	<= r_60;
		when r_60		=>
			MemOE			<= '0';		-- Output enable stays on
			state_next	<= r_unnecessary;
		when r_unnecessary =>
			Rs2m_next		<= MemDB;			-- Load the data! :)	 We have to do it here because if we do it in r_60 it is too early
			MemOE			<= '0';		-- Disable the output
			data_valid	<= '1';		-- This is the only time the data is valid
			if(mem = '0' and rw = '1') then
				state_next	<= r_20;
				Raddr_next	<= addr;
			else
				state_next	<= idle;
			end if;
		when w_00		=>
			MemWR			<= '1';		-- Do not turn on the write enable yet
			state_next	<= w_20;
		when w_20		=>
			MemWR			<= '0';		-- Start the write pulse!
			Rm2s_next	<= data_m2s;			-- So here we load the write value. I don't know if there is a better place to load it...?
			state_next	<= w_40;
		when w_40		=>
			MemWR			<= '0';		-- Continue the write pulse
			tri_en		<= '1';		-- Load the data
			state_next	<= w_60;
		when w_60		=>
			MemWR			<= '0';		-- Last state for the write pulse
			tri_en		<= '1';		-- Data still good
			state_next	<= w_unnecessary;
		when w_unnecessary =>
			MemWR			<= '1';		-- Turn off the write pulse
			tri_en		<= '1';		-- But maintain the data. Unnecessary
			state_next	<= idle;
		end case;
end process;




end YOLO;

