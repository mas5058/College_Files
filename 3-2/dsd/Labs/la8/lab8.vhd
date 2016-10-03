--Michael Sarlo
--Digital System Design
--Lab6 3/10/16

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity lab6 is 
	port(inputs  : in std_logic_vector (7 downto 0);
		  s       : in std_logic;
		 hex0, hex1, hex2 : out std_logic_vector (6 downto 0)
		 );
		 end lab6;
		 
	architecture arch of lab6 is 
	signal hhex0, hhex1, hhex2, dhex0, dhex1, dhex2: std_logic_vector (6 downto 0);
	signal tens, ones : std_logic_vector (6 downto 0);
	signal absr : std_logic_vector(6 downto 0);
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