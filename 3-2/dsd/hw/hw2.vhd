library ieee;
use ieee.std_logic_1164.all;

entity hw2 is
	port (a,b,c,d    :  IN std_logic;
			isprime1,isprime2,isprime3    : OUT std_logic
			);
end hw2;

architecture arch of hw2 is
signal inputs : std_logic_vector(3 downto 0);
begin
	--assignments
	
	isprime1 <= '1' when inputs = "0010" or inputs = "0011" or inputs = "0101" or inputs = "0111" or inputs = "1011" or inputs = "1101" else '0';
	--case
	inputs <= a & b & c & d;
	process (inputs)
	begin
	case inputs is
		when "0010" => isprime2 <= '1';
		when "0011" => isprime2 <= '1';
		when "0101" => isprime2 <= '1';
		when "0111" => isprime2 <= '1';
		when "1011" => isprime2 <= '1';
		when "1101" => isprime2 <= '1';
		when others => isprime2 <= '0';
		end case;
		end process;
	
	--if then else
	process (inputs)
	begin
	if 	((a='0') and (b='0') and (c='1') and (d='0')) then
		isprime3 <= '1';
	elsif 	((a='0') and (b='0') and (c='1') and (d='1')) then
		isprime3 <= '1';
	elsif 	((a='0') and (b='1') and (c='0') and (d='1')) then
		isprime3 <= '1';
	elsif  	((a='0') and (b='1') and (c='1') and (d='1')) then
		isprime3 <= '1';
	elsif  	((a='1') and (b='0') and (c='1') and (d='1')) then
		isprime3 <= '1';
	elsif 	((a='1') and (b='1') and (c='0') and (d='1')) then
		isprime3 <= '1';
	else
		isprime3 <= '0';
	end if;
	end process;
	
	end architecture arch;
