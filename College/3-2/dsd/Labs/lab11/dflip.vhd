library ieee;
use ieee.std_logic_1164.all;

entity dflip is
	port(d : in std_logic_vector(15 downto 0);
		  enable : in std_logic;
		  q : out std_logic_vector(15 downto 0));
end dflip;

architecture arch of dflip is
begin
process(d, enable)
begin
	if enable = '1' then
		q <= d;
	else 
		q <= (others => '0');
	end if;
end process;
end arch;