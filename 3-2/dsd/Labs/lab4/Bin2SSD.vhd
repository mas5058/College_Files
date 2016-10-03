library ieee;
use ieee.std_logic_1164.all;

entity Bin2SSD
		port(bin : in std_logic_vector(3 downto 0);
		         hex : out std_logic_vector(6 downto 0)
					);
	end Bin2SSD;

architecture arch of Bin2SSD