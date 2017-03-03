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

