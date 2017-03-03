
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem10_5 is
	port(
		start: in:std_logic;
		data_out: out: std_logic;
		clk: in:std_logic;
	);
end problem10_5;

architecture part_c of problem10_5 is
	type part_a_states is(idle, preamble1, preamble2, preamble3, preamble4, preamble5, preamble6, preamble7, preamble8);
	signal state_reg, state_next: mc_state_type:= idle;
begin
-- We always go to the next state
	process(clk)
	begin
		if(clk'event and clk = '1')
			state_reg <= state_next;
		end if;
	end process;
	
-- next-state logic
	process(state_reg)
		case state_reg is
			when idle =>
				if(start = '1') then
					state_next = preamble1;
				end if;
			when preamble1 =>
				state_next <= preamble2;
			when preamble2 =>
				state_next <= preamble3;
			when preamble3 =>
				state_next <= preamble4;
			when preamble4 =>
				state_next <= preamble5;
			when preamble5 =>
				state_next <= preamble6;
			when preamble6 =>
				state_next <= preamble7;
			when preamble7 =>
				state_next <= preamble8;
			when preamble8 =>
				state_next <= idle;
	end process;
	
-- Moore output logic
	with state_reg select data_out <=
		'0' when idle | preamble2 | preamble4 | preamble 6 | preamble 8,
		'1' when others;
end part_c;

architecture part_d of problem10_5 is
	type part_a_states is(idle, preamble1, preamble2, preamble3, preamble4, preamble5, preamble6, preamble7, preamble8);
	constant idle: std_logic_vector(3 downto 0):="0000";
	constant preamble1: std_logic_vector(3 downto 0):="0001";
	constant preamble2: std_logic_vector(3 downto 0):="0010";
	constant preamble3: std_logic_vector(3 downto 0):="0011";
	constant preamble4: std_logic_vector(3 downto 0):="0100";
	constant preamble5: std_logic_vector(3 downto 0):="0101";
	constant preamble6: std_logic_vector(3 downto 0):="0110";
	constant preamble7: std_logic_vector(3 downto 0):="0111";
	constant preamble8: std_logic_vector(3 downto 0):="1000";
	signal state_reg, state_next: std_logic_vector(3 downto 0):= idle;
	signal data_out_buf: std_logic_vector:= '0';
begin
-- We always go to the next state
	process(clk)
	begin
		if(clk'event and clk = '1')
			state_reg <= state_next;
			data_out <= data_out_buf;
		end if;
	end process;
	
-- next-state logic
	process(state_reg)
		case state_reg is
			when idle =>
				if(start = '1') then
					state_next = preamble1;
				end if;
			when preamble1 =>
				state_next <= preamble2;
			when preamble2 =>
				state_next <= preamble3;
			when preamble3 =>
				state_next <= preamble4;
			when preamble4 =>
				state_next <= preamble5;
			when preamble5 =>
				state_next <= preamble6;
			when preamble6 =>
				state_next <= preamble7;
			when preamble7 =>
				state_next <= preamble8;
			when preamble8 =>
				state_next <= idle;
	end process;
	
-- Moore output logic
	with state_reg select data_out_buf <=
		'0' when idle | preamble2 | preamble4 | preamble 6 | preamble 8,
		'1' when others;
end part_d;

architecture part_e of problem10_5 is
	type part_a_states is(idle, preamble1, preamble2, preamble3, preamble4, preamble5, preamble6, preamble7, preamble8);
	signal state_reg, state_next: mc_state_type:= idle;
	signal out_buf_reg, out_next: std_logic:='0';
begin
-- We always go to the next state
	process(clk)
	begin
		if(clk'event and clk = '1')
			state_reg <= state_next;
			out_buf_reg <= out_next;
		end if;
	end process;
	
-- next-state logic
	process(state_reg)
		case state_reg is
			when idle =>
				if(start = '1') then
					state_next = preamble1;
				end if;
			when preamble1 =>
				state_next <= preamble2;
			when preamble2 =>
				state_next <= preamble3;
			when preamble3 =>
				state_next <= preamble4;
			when preamble4 =>
				state_next <= preamble5;
			when preamble5 =>
				state_next <= preamble6;
			when preamble6 =>
				state_next <= preamble7;
			when preamble7 =>
				state_next <= preamble8;
			when preamble8 =>
				state_next <= idle;
		end case
	end process;
-- Look ahead output logic
	process(state_next)
	begin
		out_next <= '0';
		case state_next is
			when idle =>
				out_next <= '0';
			when preamble1 =>
				out_next <= '1';
			when preamble2 =>
				out_next <= '0';
			when preamble3 =>
				out_next <= '1';
			when preamble4 =>
				out_next <= '0';
			when preamble5 =>
				out_next <= '1';
			when preamble6 =>
				out_next <= '0';
			when preamble7 =>
				out_next <= '1';
			when preamble8 =>
				out_next <= '0';
		end case
	end process;
	
-- output logic
	data_out <= out_buf_reg;
end part_e;









10.7 Can we apply the look-ahead output buffer to mealy output?
NO. Because Mealy outputs depend not only on the
current state (which we CAN predict in advance), but also on the
current input (which we CANNOT predict in advance), the output buffer
will not work for mealy outputs.
