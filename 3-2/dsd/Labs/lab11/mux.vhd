library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
	port(sel : std_logic_vector (1 downto 0);
		  input : in std_logic;
		  gpio : out std_logic);
end mux;

architecture arch of mux is
begin
	process(sel)
		begin	
			case(sel) is
				when "00" => gpio <= '0';
				when "01" => gpio <= '1';
				when others => gpio <= input;
			end case;
	end process;
end arch;
	