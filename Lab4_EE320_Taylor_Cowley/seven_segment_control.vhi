
-- VHDL Instantiation Created from source file seven_segment_control.vhd -- 17:19:46 02/14/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT seven_segment_control
	PORT(
		clk : IN std_logic;
		data_in : IN std_logic_vector(15 downto 0);
		dp_in : IN std_logic_vector(3 downto 0);
		blank : IN std_logic_vector(3 downto 0);          
		seg : OUT std_logic_vector(6 downto 0);
		dp : OUT std_logic;
		an : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	Inst_seven_segment_control: seven_segment_control PORT MAP(
		clk => ,
		data_in => ,
		dp_in => ,
		blank => ,
		seg => ,
		dp => ,
		an => 
	);


