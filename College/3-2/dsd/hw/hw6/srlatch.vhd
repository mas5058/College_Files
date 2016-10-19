library ieee;
use ieee.std_logic_1164.all;

entity srlatch
	port (s, r, e  : in std_logic
		  q, qn  : out std_logic);
	end srlatch

architecture arch of srlatch is
	signal qs, qbar : std_logic;
	begin
	process (s,r,e qs, qbar)
	begin
	qs <= qbar nor (s and e);
	qbar <= qs nor (r and e);
	end process;
	end architecture;
	