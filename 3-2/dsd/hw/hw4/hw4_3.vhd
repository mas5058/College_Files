library ieee;
use ieee.std_logic_1164.all;

entity hw4_3 is
	port(a  : in std_logic_vector(3 downto 0);
		 z  : out std_logic_vector(6 downto 0));
	end hw4_3;

architecture arch of hw4_3 is 
	begin
	process (a)
	begin
	if (a = "0000") then
		z <= "1111110";
	elsif (a = "0001") then
		z <= "0110000";
	elsif (a = "0010") then
		z <= "1100000";
	elsif (a = "0011") then
		z <= "1111001";
	elsif (a = "0100") then
		z <= "0110011";
	elsif (a = "0101") then
		z <= "1011011";
	elsif (a = "0110") then
		z <= "1011111";
	elsif (a = "0111") then
		z <= "1110000";
	elsif (a = "1000") then
		z <= "1111111";
	elsif (a = "1001") then
		z <= "1111011";
	elsif (a = "1010") then
		z <= "1110111";
	elsif (a = "1011") then
		z <= "0011111";
	elsif (a = "1100") then
		z <= "1001110";
	elsif (a = "1101") then
		z <= "0111101";
	elsif (a = "1110") then
		z <= "1001111";
	else
		z <= "1000111";
	end if;
	end process;
	end arch;