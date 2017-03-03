-- Taylor Cowley
-- Problem 14.1
-- Consider a 1-bit incrementor cell that adds 1 to the input operant. It has
-- two 1-bit input signals, a and cin, which represent the input operand and carry-in
-- respectively, and 2 1-bit output signals, s and cout, for the sum and carry-out
-- a. Derive the function table for this circuit
-- a		cin		s		cout
-- 0		0			0		0
--	0		1			1		0		
-- 1		0			1		0
-- 1		1			0		1
--
-- b. Derive the VHDL code for this circuit using only simple signal
-- assignment statements and logical operators
-- c. See Attached lined paper for hand-drawn diagram

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_1 is
	port(	a, cin :in STD_LOGIC; 
			s,cout :out STD_LOGIC);
end problem_14_1;

architecture half_adder of problem_14_1 is
begin
	cout	<= a and cin;
	s		<= a xor cin;
end half_adder;


-- Taylor Cowley
-- Problem 14.5 - make 14.1 parameterizable with a for loop

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity proble_14_5 is
	Generic(WIDTH: natural);
    Port ( a : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           cout : out  STD_LOGIC);
end proble_14_5;
architecture for_loop of proble_14_5 is
begin
	process(a, cin)
		variable tmp: std_logic;
	begin
		tmp := cin;
		for i in 0 to WIDTH-1 loop
			s(i-1) 	<= a(i-1) xor tmp;
			tmp 		:= a(i-1) and tmp;
		end loop;
	cout <= tmp;
	end process;
end for_loop;



-- Taylor Cowley
-- Problem 14.7- 14.2- for generate but no generic.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_7 is
    Port ( a : in  STD_LOGIC_VECTOR;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR ;
           cout : out  STD_LOGIC);
end problem_14_7;

architecture for_generate_no_generic of problem_14_7 is
	signal tmp : std_logic_vector(a'range);
begin
	tmp(a'low) <= cin;
	half_adder: for i in a'low to a'high generate
		tmp(i+1) <= a(i) and tmp(i);
		s(i)		<= a(i) xor tmp(i);
	end generate;
end for_generate_no_generic;











-- Taylor Cowley
-- Problem 14.6 - no for generate nor for loop
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_6 is
    Port ( a : in  STD_LOGIC_VECTOR;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR;
           cout : out  STD_LOGIC);
end problem_14_6;

architecture clever_array of problem_14_6 is
	signal carry: STD_LOGIC_VECTOR(a'length downto 0);
begin
	carry <= a and carry(carry'high-1 downto 0) & cin;
	s		<= carry(carry'high -1 downto 0) xor a;
	cout 	<= '1' when cin='1' and (a=(a'range=>'1')) else '0';
end clever_array;



-- Taylor Cowley
-- problem 14.2 - make the half adder with a generic width and for generate
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_2 is
	Generic(WIDTH: natural);
    Port ( a : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cout : out  STD_LOGIC);
end problem_14_2;

architecture for_generate of problem_14_2 is
	signal tmp : std_logic_vector(WIDTH downto 0);
begin
	tmp(0) <= cin;
	half_adder: for i in 0 to WIDTH-1 generate
		tmp(i+1) <= a(i) and tmp(i);
		s(i)		<= a(i) xor tmp(i);
	end generate;
	cout <= tmp(WIDTH-1);
end for_generate;



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




-- Taylor Cowley
-- Problem 14.4 - do 14.2 but use conditional generate for the boundry cases
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem_14_4 is
	Generic(WIDTH: natural);
    Port ( a : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           cout : out  STD_LOGIC);
end problem_14_4;

architecture conditional_generate of problem_14_4 is
	signal tmp : std_logic_vector(WIDTH downto 0);
begin
	tmp(0) <= cin;
	half_adder: for i in 0 to WIDTH-1 generate
		begin_gen: if(i=0) generate
			tmp(i) <= cin;
		end generate;
	
		mid_gen: if(i>0 and i < (WIDTH-1)) generate
			tmp(i+1) <= a(i) and tmp(i);
			s(i)		<= a(i) xor tmp(i);
		end generate;
		
		end_gen: if(i=(WIDTH-1)) generate
			cout <= tmp(WIDTH-1);
		end generate;
	end generate;
end conditional_generate;






