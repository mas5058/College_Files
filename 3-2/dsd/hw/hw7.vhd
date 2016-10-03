library ieee;
use ieee.std_logic_1164.all;

entity hw6 is
	port (clk, resetn : in std_logic;
		  j, k        : in std_logic;
		  q, qn       : out std_logic);
	end hw6;

architecture arch of hw6 is 
begin
	if clk = '1' then
		