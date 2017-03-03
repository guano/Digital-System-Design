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

