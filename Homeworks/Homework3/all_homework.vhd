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




--13.2 Taylor Cowley
--Resesigh the three-digit decimal counter of 13.1 
--using the mod-n counter of section 13.3
--a. Derive the block diagram and properly label the formal and actual signals
--b. Follow the block diagram to derive the VHDL code.
architecture generic_arch of thousand_counter is
	component mod_n_counter
		generic(
			N: natural;
			WIDTH: natural
		);
		port(
			clk, reset: in std_logic;
			en: in std_logic;
			q: out std_logic_vector(WIDTH-1 downto 0);
			pulse: out std_logic
		);
	end component;
	signal p_one, p_ten, p_hundred: std_logic;
begin
	one_digit: mod_n_counter
		generic map(N=>10, WIDTH=>4)
		port map(clk=>clk, reset=>reset, en=>en, 
				pulse=>p_one, q=>q_one);
	ten_digit: mod_n_counter
		generic map(N=>10, WIDTH=>4)
		port map(clk=>clk, reset=>reset, en=>en,
				pulse=>p_ten, q=>q_ten);
	hundred_digit: mod_n_counter
		generic map(N=>10, WIDTH=>4)
		port map(clk=>clk, reset=>reset, en=>en,
				pulse=>p_hundred, q=>q_hundred);
		p1000 <= p_one and p_ten and p_hundred;
end generic_arch;



--13.1 (variant) Taylor Cowley
-- Repeat problem 13.1 but use the "Entity Instantiation syntax" 
--(section 13.4.4) instead of the component instantiation to 
--construct this three digit decimal counter.

architecture vhdl_93_arch of thousand_counter is
	signal p_one, p_ten, p_hundred:std_logic;
begin
	one_digit: entity work.dec_counter(up_arch)
		port map(clk=>clk, reset=>reset, en=>en,
				pulse=>p_one, q=>q_one);
	ten_digit: entity work.dec_counter(up_arch)
		port map(clk=>clk, reset=>reset, en=>en,
				pulse=>p_ten, q=>q_ten);
	hundred_digit: entity work.dec_counter(up_arch)
		port map(clk=>clk, reset=>reset, en=>en,
				pulse=>p_hundred, q=>q_hundred);
	p1000<= p_one and p_ten and p_hundred
end vhdl_93_arch;



