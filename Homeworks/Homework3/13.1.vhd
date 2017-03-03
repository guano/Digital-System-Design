--13.1 Taylor Cowley
--Consider a three-digit counter that counts from 000 t0 999 and wraps around.
-- Use the dec_counter of Section 13.2.1 as a component to design this circuit
--a. Design the block diagram of this circuit and properly label the formal 
--and actual signals.
--b. Follow the block diagram to derive the VHDL code.

library ieee;
use ieee.std_logic_1164.all;
entity thousand_counter is
	port(
		clk, reset: in std_logic;
		en: in std_logic;
		q_hundred, q_ten, q_one: out std_logic_vector(3 downto 0);
		p1000: out std_logic
	);
end thousand_counter;

architecture count of thousand_counter is
	component dec_counter
		port(
			clk, reset: in std_logic;
			en: in std_logic;
			q: out std_logic_vector(3 downto 0);
			pulse: out std_logic
		);
	end component;
	signal p_one, p_ten, p_hundred: std_logic;
begin
	one_digit: dec_counter
		port map(clk=>clk, reset=>reset, en=>en, pulse=>p_one, q=>q_one);
	ten_digit: dec_counter
		port map(clk=>clk, reset=>reset, en=>en, pulse=>p_ten, q=>q_ten);
	hundred_digit: dec_counter
		port map(clk=>clk, reset=>reset, en=>en, pulse=>p_hundred, q=>q_hundred);
		p1000 <= p_one and p_ten and p_hundred;
end count;








