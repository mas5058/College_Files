 library ieee;
use ieee.std_logic_1164.all;

entity lab42 is 
	port(a,b,c,d,e,b5 ,b6  : IN std_logic;
			firstcase, lastcase,firstif, lastif  : out std_logic
			);
	end lab42;
	
architecture arch of lab42 is 
	signal inputs : STD_LOGIC_VECTOR(5 DOWNTO 0);
	begin
		inputs <= b6 & a & b & c & d & e;
		process (inputs)
			begin
				case inputs is
					when "100001" => firstcase <= '1';
					when "100011" => firstcase <= '1';
					when "100101" => firstcase <= '1';
					when "101000" => firstcase <= '1';
					when "101001" => firstcase <= '1';
					when "101100" => firstcase <= '1';
					when "101101" => firstcase <= '1';
					when others => firstcase <= '0';
					end case;
			case inputs is
					when "100001" => lastcase <= '1';
					when "101100" => lastcase <= '1';
					when "101111" => lastcase <= '1';
					when "110010" => lastcase <= '1';
					when "110011" => lastcase <= '1';
					when others => lastcase <= '0';
				end case;
				end process;
			process (inputs)
	 begin
		if ((b6 = '1') and (a = '0') and (b = '0') and (c = '0') and (d = '0') and (e = '1')) then
			firstif <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '0') and (c = '0') and (d = '1') and (e = '1')) then
			firstif <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '0') and (c = '1') and (d = '0') and (e = '1')) then
			firstif <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '0') and (d = '0') and (e = '0')) then 
			firstif <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '0') and (d = '0') and (e = '1')) then
			firstif <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '1') and (d = '0') and (e = '0')) then
			firstif <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '1') and (d = '0') and (e = '1')) then
			firstif <= '1';
		else
			firstif <= '0';
		end if;
		
		if ((b6 = '1') and (a = '0') and (b = '0') and (c = '0') and (d = '0') and (e = '1')) then
			lastif <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '1') and (d = '0') and (e = '0')) then 
			lastif <= '1';
		elsif ((b6 = '1') and (a = '0') and (b = '1') and (c = '1') and (d = '1') and (e = '1')) then
			lastif <= '1';
		elsif ((b6 = '1') and (a = '1') and (b = '0') and (c = '0') and (d = '1') and (e = '0')) then
			lastif <= '1';
		elsif ((b6 = '1') and (a = '1') and (b = '0') and (c = '0') and (d = '1') and (e = '1')) then
			lastif <= '1';
		else
			lastif <= '0';
		end if;
	end process;
			end arch;

			