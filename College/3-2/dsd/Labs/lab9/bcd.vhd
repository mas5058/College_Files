--Michael Sarlo
--Digital System Design
--Lab6 3/10/16

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity bcd is 
	port(inputs  : in std_logic_vector (3 downto 0);
		 hex : out std_logic_vector (6 downto 0)
		 );
		 end bcd;
		 
	architecture arch of bcd is 
	signal hhex: std_logic_vector (6 downto 0);
	constant zero : 
			std_logic_vector(6 downto 0):= "1000000";
	constant one : 
			std_logic_vector(6 downto 0):= "1111001";
	constant two : 
			std_logic_vector(6 downto 0):= "0100100";
	constant three : 
			std_logic_vector(6 downto 0):= "0110000";
	constant four : 
			std_logic_vector(6 downto 0):= "0011001";
	constant five : 
			std_logic_vector(6 downto 0):= "0010010";
	constant six : 
			std_logic_vector(6 downto 0):= "0000010";
	constant seven : 
			std_logic_vector(6 downto 0):= "1111000";
	constant eight : 
			std_logic_vector(6 downto 0):= "0000000";
	constant nine : 
			std_logic_vector(6 downto 0):= "0010000";
	constant A : 
			std_logic_vector(6 downto 0):= "0001000";
	constant b : 
			std_logic_vector(6 downto 0):= "0000011";
	constant C : 
			std_logic_vector(6 downto 0):= "1000110";
	constant d : 
			std_logic_vector(6 downto 0):= "0100001";
	constant E : 
			std_logic_vector(6 downto 0):= "0000110";
	constant F : 
			std_logic_vector(6 downto 0):= "0001110";
	begin
	h: process (inputs) 
		begin
		case (inputs(3 downto 0)) is
			when "0000" => hex <= (zero);
			when "0001" => hex <= (one);
			when "0010" => hex <= two;
			when "0011" => hex <= three;
			when "0100" => hex <= four;
			when "0101" => hex <= five;
			when "0110" => hex <= six;
			when "0111" => hex <= seven;
			when "1000" => hex <= eight;
			when "1001" => hex <= nine;
			when "1010" => hex <= A;
			when "1011" => hex <= b;
			when "1100" => hex <= C;
			when "1101" => hex <= d;
			when "1110" => hex <= E;
			when others => hex <= F;
		end case;
		end process;
		end arch;