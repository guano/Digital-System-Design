-- Taylor Cowley
-- Problem 14.3 - do 14.2 but with an instanciated component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_3 is
	Generic(WIDTH: natural);
    Port ( a : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cout : out  STD_LOGIC);
end problem_14_3;

architecture component_version of problem_14_3 is
  component problem_14_1
	port(	a, cin :in STD_LOGIC; 
			s,cout :out STD_LOGIC);
  end component;

	signal tmp : std_logic_vector(WIDTH-1 downto 0);
begin
	tmp(0) <= cin;
	half_adder: for i in 0 to WIDTH-1 generate
		adder: problem_14_1 port map(a=>a(i),cin=>tmp,s=>s(i),cout=>tmp);
	end generate;
	cout <= tmp(WIDTH-1);
end component_version;

