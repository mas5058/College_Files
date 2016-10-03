--Michael Sarlo 
--HW 6 problem 1
--3/16/16
--D Latch with Set

library ieee;
use ieee.std_logic_1164.all;

entity hw6_1 is
	port (clk, d, s : in std_logic;
		  q : out std_logic);
	end hw6_1;

architecture arch of hw6_1 is
	begin
	process(clk, s)
	begin
	if (s = '0') then
		q <= '1';
	elsif (clk = '1') then
		q <= d;
	end if;
	end process;
	end arch;
	