library ieee;
use ieee.std_logic_1164.all;

entity hw4_2 is
	port (a, b, c, enable      : in std_logic;
		  z0,z1,z2,z3,z4,z5,z6,z7 : out std_logic);
		 end hw4_2;

architecture arch of hw4_2 is 
	begin
	process (a,b,c,enable) is 
	begin
	if (enable = '1') then
		z0 <= (not a) and (not b) and (not c);
		z1 <= (not a) and (not b) and (c);
		z2 <= (not a) and (b) and (not c);
		z3 <= (not a) and (b) and (c);
		z4 <= (a) and (not b) and (not c);
		z5 <= (a) and (not b) and (c);
		z6 <= (a) and (b) and (not c);
		z7 <= (a) and (b) and (c);
	else
		z0 <= '0';
		z1 <= '0';
		z2 <= '0';
		z3 <= '0';
		z4 <= '0';
		z5 <= '0';
		z6 <= '0';
		z7 <= '0';	
	end if;
	end process;
end arch;
		 