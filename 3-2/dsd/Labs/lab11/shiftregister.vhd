library ieee;
use ieee.std_logic_1164.all;

entity shiftregister is
	port(en, load, sh,resetn, clk: in std_logic;
			d : in std_logic_vector(15 downto 0);
		  output : out std_logic);
end shiftregister;

architecture arch of shiftregister is
signal dsignal: std_logic_vector(15 downto 0);
begin
	process(clk, en, load,sh)
	begin
		if resetn = '0' then
			output <= '1';
		elsif (clk'event and clk = '1') then
			if load = '1' then
				dsignal <= d;
			elsif sh = '1' then
				if en = '1' then
					output <= dsignal(0);
					dsignal(15 downto 1) <= dsignal (14 downto 0);
				end if;
			end if;
		end if;
	--end if;
end process;
end arch;
			