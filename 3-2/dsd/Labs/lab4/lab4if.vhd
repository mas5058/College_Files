library ieee;
use ieee.std_logic_1164.all;

entity lab4if is 
	port(a,b,c,d,e,b6  : IN std_logic;
			first, last  : out std_logic
			);
	end lab4if;

	architecture arch of lab4if is
	signal inputs : std_logic_vector(5 downto 0);
	begin
	inputs <= b6 & a & b & c & d & e;
	process (inputs)
	 begin
		if ((b6 = '1') and (a = '0') and (b = '0') and (c = '0') and (d = '0') and (e = '1')) then
			first <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '0') and (c = '0') and (d = '1') and (e = '1')) then
			first <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '0') and (c = '1') and (d = '0') and (e = '1')) then
			first <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '0') and (d = '0') and (e = '0')) then 
			first <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '0') and (d = '0') and (e = '1')) then
			first <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '1') and (d = '0') and (e = '0')) then
			first <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '1') and (d = '0') and (e = '1')) then
			first <= '1';
		else
			first <= '0';
		end if;
		
		if ((b6 = '1') and (a = '0') and (b = '0') and (c = '0') and (d = '0') and (e = '1')) then
			last <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '1') and (d = '0') and (e = '0')) then 
			last <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '1') and (d = '1') and (e = '1')) then
			last <= '1';
		elsif ((b6 = '1') and (a = '1') and (b = '0') and (c = '0') and (d = '1') and (e = '0')) then
			last <= '1';
		elsif ((b6 = '1') and (a = '1') and (b = '0') and (c = '0') and (d = '1') and (e = '1')) then
			last <= '1';
		else
			last <= '0';
		end if;
	end process;
	end arch;
		