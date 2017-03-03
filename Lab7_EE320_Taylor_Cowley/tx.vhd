library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tx is
   generic ( 
		CLK_RATE : natural := 50_000_000;
		BAUD_RATE : natural := 19_200);
	
	port ( 
		clk : in  STD_LOGIC;
      rst : in  STD_LOGIC;
      data_in : in  STD_LOGIC_VECTOR (7 downto 0);
      send_character : in  STD_LOGIC;
      tx_out : out  STD_LOGIC;
      tx_busy : out  STD_LOGIC);
			  
	

end tx;

architecture taylor of tx is
	type transmitter_state_type is (idle, start_state, b0, b1, b2, b3, b4, b5, b6, b7, stop_state, re_turn);
	signal state_reg, state_next: transmitter_state_type := idle;
	function log2c(n:integer) return integer;
	
	constant BIT_COUNTER_MAX_VAL : natural := CLK_RATE / BAUD_RATE - 1;
	constant BIT_COUNTER_BITS : natural := log2c(BIT_COUNTER_MAX_VAL);
	
	signal bit_timer : unsigned(BIT_COUNTER_BITS-1 downto 0);
	signal tx_bit : STD_LOGIC:='0';		-- When we can send another bit
	signal shift_value: STD_LOGIC_VECTOR(7 downto 0):="00000000";
	signal clrTimer: 	STD_LOGIC:= '1';
	signal tx_out_reg:STD_LOGIC:= '0';
	signal tx_busy_reg:STD_LOGIC:= '0';
	signal shift: 		STD_LOGIC:= '0';
	signal start: 		STD_LOGIC:= '0';
	signal stop: 		STD_LOGIC:= '0';
	signal load :		STD_LOGIC:='0';			-- When we want to load the value
	
	function log2c(n:integer) return integer is
		variable m, p: integer;
	begin
		m:=0;
		p:=1;
		while p<n loop
			m:=m+1;
			p:=p*2;
		end loop;
		return m;
	end log2c;

begin

-- Bit Timer
	process(clk, rst)
	begin
		if(clk'event and clk = '1') then
			if(clrTimer = '1') then
				bit_timer <= (others => '0');
				tx_bit <= '0';
			elsif(bit_timer = BIT_COUNTER_MAX_VAL) then
				bit_timer <= (others => '0');
				tx_bit <= '1';
			else
				bit_timer <= bit_timer + 1;
				tx_bit <= '0';
			end if;
		end if;
		if (rst = '1') then
			bit_timer <= (others =>'0');
			tx_bit <= '0';
		end if;	
	end process;

-- Shift Register
	process(clk, rst)
	begin
		if(clk'event and clk = '1') then
			if(shift = '1') then			-- Shifting has priority over loading
				shift_value <= '0' & shift_value(7 downto 1);
			elsif(load = '1') then		-- Loading
				shift_value <= data_in;
			else								-- Maybe this is a bad idea but I don't know why.
				shift_value <= shift_value;
			end if;
		end if;
		if(rst = '1') then
			shift_value <= (others => '0');
		end if;
	end process;

-- Transmit Out
-- We have a problem here
-- We need an output flip flop.
-- But I am not entirely sure how to do that...
	process(clk, rst)
	begin
		if(clk'event and clk = '1') then
			if(start = '1') then
				tx_out_reg <= '0';
			elsif(stop = '1') then
				tx_out_reg <= '1';
			else
				tx_out_reg <= shift_value(0);
			end if;
		end if;
		if(rst = '1') then
			tx_out_reg <= '1';
		end if;
	end process;

-- State and data registers, and output
	process(clk, rst)
	begin
		if(rst = '1') then
			state_reg 	<= idle;
			tx_out		<= '1';
			tx_busy		<= '0';
			--other things to reset?
		elsif(clk'event and clk = '1') then
			state_reg 	<= state_next;
			tx_out 		<= tx_out_reg;
			tx_busy		<= tx_busy_reg;
		end if;
	end process;

-- Transmitter FSM
	process(state_reg, send_character, tx_bit) -- other things too?
	begin
		
		case state_reg is
		-- Things to be assigned in every branch:
		-- state_next
		-- load
		-- stop
		-- start
		-- clrTimer
		-- shift
		-- tx_busy
			when idle 	=>							-- IDLE STATE
				shift 	<= '0';						-- we don't shift in idle
				load		<= '0';						-- we don't load in idle
				stop		<= '1';						-- we are stopped
				tx_busy_reg	<= '0';
				
				if(send_character = '1') then
					state_next 	<= start_state;	-- GOTO START
					start 	<= '1';						-- and  start
					clrTimer <= '0';						-- Timer stays at 0
					load		<=	'1';
				else
					state_next 	<= idle;				-- stay in idle
					start 	<= '0';						-- and not start
					clrTimer <= '1';						-- Timer stays at 0
					load		<=	'1';
					
				end if;
			when start_state	=>					-- START STATE
				tx_busy_reg	<= '1';						-- We are busy!
				clrTimer <= '0';						-- Timer goes in start :)
				shift		<= '0';						-- Still don't shift
				stop		<= '0';						-- nope, not stopped
				load		<= '0';
				if(tx_bit = '1') then
					state_next	<= b0;				-- GOTO B0!
					start		<= '0';						-- start! do start! :)
					--load		<= '0';						-- we load in start! or not because the test bench is stupid
				else
					state_next 	<= start_state;	-- stay in start
					start		<= '1';						-- start! do start! :)
					--load		<= '1';						-- we load in start! OR not because the test bench is stupid
				end if;
			when b0		=>							-- B0 STATE
				clrTimer	<= '0';						-- timer totally keeps on
				start		<= '0';						-- Don't start while broadcasting
				load		<=	'0';						-- Don't load while broadcasting
				stop		<= '0';						-- Don't stop! Please!
				tx_busy_reg	<=	'1';
				if(tx_bit = '1') then
					state_next 	<= b1;				-- GOTO B1
					shift			<= '1';				-- Shift. Just once.
				else
					state_next	<= b0;				-- stay here
					shift			<= '0';				-- and don't shift.
				end if;
			when b1		=>							-- B1 STATE - identical to B0
				clrTimer	<= '0';						-- timer totally keeps on
				start		<= '0';						-- Don't start while broadcasting
				load		<=	'0';						-- Don't load while broadcasting
				stop		<= '0';						-- Don't stop! Please!
				tx_busy_reg	<=	'1';
				if(tx_bit = '1') then
					state_next 	<= b2;				-- GOTO B2
					shift			<= '1';				-- Shift. Just once.
				else
					state_next	<= b1;				-- stay here
					shift			<= '0';				-- and don't shift.
				end if;
			when b2		=>							-- B2 STATE
				clrTimer	<= '0';						-- timer totally keeps on
				start		<= '0';						-- Don't start while broadcasting
				load		<=	'0';						-- Don't load while broadcasting
				stop		<= '0';						-- Don't stop! Please!
				tx_busy_reg	<=	'1';
				if(tx_bit = '1') then
					state_next 	<= b3;				-- GOTO B3
					shift			<= '1';				-- Shift. Just once.
				else
					state_next	<= b2;				-- stay here
					shift			<= '0';				-- and don't shift.
				end if;
			when b3		=>							-- B3 STATE
				clrTimer	<= '0';						-- timer totally keeps on
				start		<= '0';						-- Don't start while broadcasting
				load		<=	'0';						-- Don't load while broadcasting
				stop		<= '0';						-- Don't stop! Please!
				tx_busy_reg	<=	'1';
				if(tx_bit = '1') then
					state_next 	<= b4;				-- GOTO B4
					shift			<= '1';				-- Shift. Just once.
				else
					state_next	<= b3;				-- stay here
					shift			<= '0';				-- and don't shift.
				end if;
			when b4		=>							-- B4 STATE
				clrTimer	<= '0';						-- timer totally keeps on
				start		<= '0';						-- Don't start while broadcasting
				load		<=	'0';						-- Don't load while broadcasting
				stop		<= '0';						-- Don't stop! Please!
				tx_busy_reg	<=	'1';
				if(tx_bit = '1') then
					state_next 	<= b5;				-- GOTO B5
					shift			<= '1';				-- Shift. Just once.
				else
					state_next	<= b4;				-- stay here
					shift			<= '0';				-- and don't shift.
				end if;
			when b5		=>							-- B5 STATE
				clrTimer	<= '0';						-- timer totally keeps on
				start		<= '0';						-- Don't start while broadcasting
				load		<=	'0';						-- Don't load while broadcasting
				stop		<= '0';						-- Don't stop! Please!
				tx_busy_reg	<=	'1';
				if(tx_bit = '1') then
					state_next 	<= b6;				-- GOTO B6
					shift			<= '1';				-- Shift. Just once.
				else
					state_next	<= b5;				-- stay here
					shift			<= '0';				-- and don't shift.
				end if;
			when b6		=>							-- B6 STATE
				clrTimer	<= '0';						-- timer totally keeps on
				start		<= '0';						-- Don't start while broadcasting
				load		<=	'0';						-- Don't load while broadcasting
				stop		<= '0';						-- Don't stop! Please!
				tx_busy_reg	<=	'1';
				if(tx_bit = '1') then
					state_next 	<= b7;				-- GOTO B7
					shift			<= '1';				-- Shift. Just once.
				else
					state_next	<= b6;				-- stay here
					shift			<= '0';				-- and don't shift.
				end if;
			when b7		=>							-- B7 STATE
				clrTimer	<= '0';						-- timer totally keeps on
				start		<= '0';						-- Don't start while broadcasting
				load		<=	'0';						-- Don't load while broadcasting
				tx_busy_reg	<=	'1';
				shift		<= '0';						-- it's the last bit, we don't need to shift
				if(tx_bit = '1') then
					state_next 	<= stop_state;		-- GOTO B1
					stop		<= '1';						-- We are now not stopped
				else
					state_next	<= b7;				-- stay here
					stop		<= '0';						-- We are now stopped
				end if;
			when stop_state=>						-- STOP STATE
				clrTimer	<= '0';						-- Do still need the timer
				start		<= '0';						-- Not in start
				stop		<= '1';						-- We are now stopped
				load		<=	'0';						-- Don't load here
				tx_busy_reg	<=	'1';						-- Totally still busy here
				shift		<= '0';						-- And not shifting
				if(tx_bit = '1') then
					state_next	<= re_turn;			-- GOTO re_turn
				else
					state_next	<= stop_state;		-- stay here
				end if;
			when re_turn=>							-- RE_TURN STATE
				clrTimer	<= '1';						-- Do NOT still need the timer
				start		<= '0';						-- Not in start
				stop		<= '1';						-- We are now stopped
				load		<=	'0';						-- Don't load here
				tx_busy_reg	<=	'1';						-- Totally still busy here
				shift		<= '0';						-- And not shifting
				if(send_character = '0') then
					state_next	<= idle;				-- GOTO idle
				else
					state_next	<= stop_state;		-- stay here
				end if;
		end case;
	end process;
end taylor;






