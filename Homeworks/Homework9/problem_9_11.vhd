-- Taylor Cowley
-- problem 9.11: make a stack
-- part b: VHDL
-- Specs:
-- 	size of stack: 4 words
-- 	size of word: 8 bits
-- 	Push/pop same time? Pop happens first

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity problem_9_11 is
    port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           push : in  STD_LOGIC;
           pop : in  STD_LOGIC;
           empty : out  STD_LOGIC;
           full : out  STD_LOGIC;
           w_data : in  STD_LOGIC_VECTOR (7 downto 0);
           r_data : out  STD_LOGIC_VECTOR (7 downto 0));
end problem_9_11;

architecture stack of problem_9_11 is
	signal current_address : unsigned(3 downto 0):= "0000";	-- 4 addresses, with an extra to say it's full
	signal data_out_reg : std_logic_vector(7 downto 0):=(others=>'0');
	type memory_type is array (3 downto 0) of			-- 4 registers
				std_logic_vector(7 downto 0);				-- of 8 bits each
	signal stack_memory: memory_type;
begin
	
	-- The addressing is the next address to push to.
	-- Next address to pop from is address -1
	-- If address is 0, it's empty
	-- If address is 4, it's full.
	full	<=	current_address(3);		-- last bit is exclusively to tell if full
	empty	<=	'1' when current_address = 0 else	
				'0';
	r_data <= data_out_reg;
	process(clk, reset, push, pop)
	begin
		stack_memory(0) 	<= stack_memory(0);
		stack_memory(1) 	<= stack_memory(1);
		stack_memory(2) 	<= stack_memory(2);
		stack_memory(3)	<= stack_memory(3);
		current_address	<= current_address;
		data_out_reg		<= data_out_reg;
		if(reset = '1') then
			current_address <= (others=>'0');
			data_out_reg		<= (others=>'0');
		elsif(clk'event and clk = '1') then
	-- If we get a push and a pop at the same time, the pop executes first.
			if(push = '1' and pop = '1') then
				if(current_address = 0) then
					data_out_reg <= (others=>'0');
					stack_memory(to_integer(current_address)) <= w_data;
					current_address <= current_address+1;
				else
					data_out_reg <= stack_memory(to_integer(current_address-1));
					stack_memory(to_integer(current_address-1)) <= w_data;
				end if;
			elsif(pop = '1') then
				if(current_address = 0) then
					-- Trying to pop an empty stack! give em zeroes
					data_out_reg <= (others=>'0');
				else 
					data_out_reg <= stack_memory(to_integer(current_address-1));
					current_address <= current_address-1;
				end if;
			elsif(push = '1') then
				if(current_address(3) = '1') then
					-- Trying to push to a full stack! do nothing. Losers.
				else
					stack_memory(to_integer(current_address)) <= w_data;
					current_address <= current_address+1;
				end if;
			end if;
		end if;
	end process;
end stack;

