
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rx is
	generic ( 
		CLK_RATE : natural := 50_000_000;
		BAUD_RATE : natural := 19_200);
   Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           rx_in : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0);
           data_strobe : out  STD_LOGIC;
           rx_busy : out  STD_LOGIC);
end rx;

architecture taylor of rx is
	type rx_state_type is (power_up, idle, start_state, bit_read, stop_state, stop_reject);
	signal state_reg, state_next: rx_state_type := power_up;
	
	function log2c(n:integer) return integer;
	
	constant BIT_COUNTER_HALF_VAL : natural := (CLK_RATE / BAUD_RATE - 1) / 2;
	constant BIT_COUNTER_VAL : natural := CLK_RATE / BAUD_RATE - 1;
	constant BIT_COUNTER_ONE_AND_HALF_VAL : natural := (BIT_COUNTER_HALF_VAL) * 3;
	constant BIT_COUNTER_BITS : natural := log2c(BIT_COUNTER_ONE_AND_HALF_VAL);
	
	
	signal bit_number, bit_number_next : unsigned(2 downto 0):= "000";				-- Which bit we are doing now
	signal bit_timer : unsigned(BIT_COUNTER_BITS-1 downto 0);	-- Tell me every half bit
	signal rx_bit : STD_LOGIC:='0';										-- And here's that signal
	signal rx_one_and_half_bit : STD_LOGIC:='0';						-- And here's that signal
	signal clrTimer: 	STD_LOGIC:= '1';									-- Whether to clear the timer
	signal data_out_next, data_out_reg: STD_LOGIC_VECTOR(7 downto 0);
	signal rx_busy_reg, rx_busy_next: STD_LOGIC:= '1';
	
	
	-- We turned data_strobe into a register to hopefully get rid of some of the problems we were having
	-- It turned out the problem was something different, so should we get rid of this register now?
	signal data_strobe_reg, data_strobe_next: STD_LOGIC:='0';
	
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
	data_strobe <= data_strobe_reg;
-- Bit Timer
-- Very similar to the one in the transmitter but with one major difference:
-- This one only resets itself after every one and a half bits. Which is useless
-- We have to reset it manually between every bit.
	process(clk, rst)
	begin
		if(clk'event and clk = '1') then
			if(clrTimer = '1') then
				bit_timer <= (others => '0');
				rx_bit <= '0';
				rx_one_and_half_bit <= '0';
			elsif(bit_timer = BIT_COUNTER_VAL) then
				bit_timer <= bit_timer + 1;
				rx_bit <= '1';
				rx_one_and_half_bit <= '0';
			elsif(bit_timer = BIT_COUNTER_ONE_AND_HALF_VAL) then
				bit_timer <= (others => '0');
				rx_bit <= '0';
				rx_one_and_half_bit <= '1';
			else
				bit_timer <= bit_timer + 1;
				rx_bit <= '0';
				rx_one_and_half_bit <= '0';
			end if;
		end if;
		if (rst = '1') then
			bit_timer <= (others =>'0');
			rx_bit <= '0';
			rx_one_and_half_bit <= '0';
		end if;	
	end process;


-- State and data registers, and output
	process(clk, rst)
	begin
		if(rst = '1') then
			state_reg 	<= idle;
			data_out_reg<= (others=>'0');
			rx_busy_reg	<= '0';
			bit_number	<= (others => '0');
			data_strobe_reg<= '0';
			--other things to reset?
		elsif(clk'event and clk = '1') then
			state_reg 		<= state_next;
			data_out_reg 	<= data_out_next;
			rx_busy_reg		<= rx_busy_next;
			bit_number		<= bit_number_next;
			data_strobe_reg <= data_strobe_next;
		end if;
	end process;
	data_out <= data_out_reg;
	rx_busy	<= rx_busy_reg;
	

-- Receiver FSM
	process(state_reg, rx_in, rx_bit, rx_one_and_half_bit, data_out_reg, bit_number) -- other things too?
	begin
		-- Signals that need to be assigned:
			-- state_next
			-- clrTimer
			-- bit_number_next
			-- data_strobe_next (only ever asserted for one clock cycle)
			-- data_out_next
			-- rx_busy_next
		case state_reg is
			when power_up =>					-- POWER_UP
				data_strobe_next <= '0';
				data_out_next <= (others=>'0');
				rx_busy_next <= '1';
				clrTimer		<= '1';				-- No need for timers in power up
				bit_number_next <= (others =>'0');			-- No need for bits in power up
				if(rx_in = '1') then				-- We stay in power up until rx goes high
					state_next <= idle;			-- GOTO idle
				else
					state_next <= power_up;		-- Stay in power up
				end if;
			when idle =>						-- IDLE
				data_strobe_next <= '0';
				data_out_next <= data_out_reg;
				clrTimer		<= '1';				-- No need for timers in idle
				bit_number_next <= (others=>'0');
				if(rx_in = '0') then				-- Do we have the start signal?
					state_next 	<= start_state;-- GOTO start state
					rx_busy_next <= '1';
				else
					state_next <= idle;			-- Stay in idle
					rx_busy_next <= '0';
				end if;
			when start_state =>				-- START_STATE
				rx_busy_next <= '1';
				data_strobe_next <= '0';
				bit_number_next <= (others=>'0');
				if(rx_one_and_half_bit = '1') then
					state_next <= bit_read;		-- GOTO bit_read
					clrTimer <= '1';				-- Reset timer for next bit
					data_out_next <= rx_in & data_out_reg(7 downto 1);	-- Load the next bit
				else
					state_next <= start_state;	-- Stay in start state
					clrTimer <= '0';				-- Keep timer going
					data_out_next <= (others=>'0');
				end if;
			when bit_read =>					-- BIT_READ
				rx_busy_next <= '1';
				if(rx_bit = '1') then
					clrTimer <= '1';				-- Reset timer for the next bit
					
					data_strobe_next <= '0';
					if(bit_number = 7) then 	-- Have we finished all the bits?
						state_next <= stop_state;
						bit_number_next <= (others=>'0');
						data_out_next <= data_out_reg;	-- DONT load the next bit
					else
						state_next <= bit_read;
						bit_number_next <= bit_number + 1;
						data_out_next <= rx_in & data_out_reg(7 downto 1);	-- Load the next bit
					end if;
				else
					state_next	<= bit_read;	-- Stay in bit read with this bit
					clrTimer	<= '0';				-- Gotta keep that timer going
					bit_number_next <= bit_number;-- I hope this doesnt cause problems
					data_out_next <= data_out_reg;	-- DONT load the next bit
					data_strobe_next <= '0';
				end if;
			when stop_state =>				-- stop_state
				data_out_next <= data_out_reg;
				bit_number_next <= (others=>'0');
				clrTimer <= '0';
				if(rx_bit = '1') then
					if(rx_in = '1') then			-- rx in is high. We win!
						state_next <= idle;
						rx_busy_next <= '0';
						data_strobe_next <= '1';
					else
						state_next <= stop_reject;
						rx_busy_next <= '1';
						data_strobe_next <= '0';
					end if;
				else
					state_next <= stop_state;
					rx_busy_next <= '1';
					data_strobe_next <= '0';
				end if;
			when stop_reject =>				-- STOP_REJECT
				data_strobe_next <= '0';
				data_out_next <= (others=>'0');
				bit_number_next <= (others=>'0');
				clrTimer	<= '1';
				if(rx_bit = '1') then			-- We stay here until rx goes high
					state_next <= idle;
					rx_busy_next <= '0';
				else
					state_next <= stop_reject;
					rx_busy_next <= '1';
				end if;
		end case;
		
	end process;







end taylor;

