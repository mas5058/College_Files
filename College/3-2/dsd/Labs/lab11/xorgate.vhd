library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xorgate is
	port(i1 , i2 : in std_logic_vector(15 downto 0);
		  clk, enable : in std_logic;
		  output : out std_logic_vector(15 downto 0));
	end xorgate;

architecture arch of xorgate is
begin
process(enable, clk)
begin
	if enable = '1' then
		if (clk = '1' and clk'event) then
			output <= i1 xor i2;
		end if;
	end if;
end process;
end arch;