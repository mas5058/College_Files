library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
		port(a,b  : in std_logic_vector(3 downto 0);
			s     : in std_logic;
			y     : out std_logic_vector(3 downto 0)
			);
	end mux2to1;

architecture arch of mux2to1 is
	begin
	process (s)
	begin
	if (s = '0') then
		y <= a;
	else
		y <= b;
	end if;
	end process;
	end architecture;