library ieee;
use ieee.std_logic_1164.all;

entity lab4case is 
	port(a,b,c,d,e,b6  : IN std_logic;
			first, last  : out std_logic
			);
	end lab4case;
	
architecture arch of lab4case is 
	signal inputs : STD_LOGIC_VECTOR(5 DOWNTO 0);
	begin
		inputs <= b6 & a & b & c & d & e & b6;
		process (inputs)
			begin
				case inputs is
					when "100001" => first <= '1';
					when "100011" => first <= '1';
					when "100101" => first <= '1';
					when "101000" => first <= '1';
					when "101001" => first <= '1';
					when "101100" => first <= '1';
					when "101101" => first <= '1';
					when others => first <= '0';
					end case;
			case inputs is
					when "100001" => last <= '1';
					when "101100" => last <= '1';
					when "101111" => last <= '1';
					when "110010" => last <= '1';
					when "110011" => last <= '1';
					when others => last <= '0';
				end case;
				end process;
			end arch;

			