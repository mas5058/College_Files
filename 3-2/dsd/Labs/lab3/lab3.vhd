library ieee;
use ieee.std_logic_1164.all;
entity lab3 is 
	port(a,b,c,d,e,b6    : IN std_logic;
			archf1, archf2, archf3, archl1, archl2, archl3    : out std_logic
			);
end lab3;

architecture arch of lab3 is  
signal inputs :STD_logic_vector(5 downto 0);
begin
	--struct
	
	archf1 <= (b6 and (not a) and (not d) and e) or (b6 and (not a) and b and (not d)) or (b6 and (not a) and (not b) and (not c) and e);
	archl1 <= (b6 and (not a) and (not b) and (not c) and (not d) and e) or (b6 and (not a) and b and c and (not d) and (not e)) or (b6 and b and c and (not a) and d and e) or (b6 and a and (not b) and (not c) and d);
	--con
	
	archf2 <= '1' when inputs = "100001" or inputs = "100011" or inputs = "100101" or inputs = "101000" or inputs = "101001" or inputs = "101100" or inputs = "101101" else '0';
	archl2 <= '1' when inputs = "100001" or inputs = "101100" or inputs = "101111" or inputs = "110010" or inputs = "110011" else '0';
	
	--behv
	inputs <= b6 & a & b & c & d & e;
	with inputs select
		archf3 <= '1' when "100001" | "100011" |"100101" | "101000" | "101001" | "101100" | "101101",
					 '0' when others;
	with inputs select
		archl3 <=  '1' when "100001" | "101100" | "101111" | "110010" | "110011",
					  '0' when others;
	
	
	end architecture arch;


	