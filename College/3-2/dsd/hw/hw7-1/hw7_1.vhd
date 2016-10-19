library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
--ex on 557, question on 621
entity hw7_1 is
	port (n_cp, n_rd : in std_logic;
			q          : out std_logic_vector(3 downto 0));
	end hw7_1;

architecture arch of hw7_1 is
	signal qs : std_logic_vector(3 downto 0);
	begin
	process (n_cp, n_rd)
	begin
		if (n_rd = '0' or qs = "1100") then
			qs <= (others => '0');
		elsif (n_cp'event and n_cp = '1') then
			qs <= qs+"0001";
		end if;
		q <= qs;
	end process;
end arch;