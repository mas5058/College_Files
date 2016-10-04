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
	proc1: process (inputs) 
		begin
		case (inputs(7 downto 4)) is
			when "0000" => hhex1 <= (zero);
			when "0001" => hhex1 <= (one);
			when "0010" => hhex1 <= two;
			when "0011" => hhex1 <= three;
			when "0100" => hhex1 <= four;
			when "0101" => hhex1 <= five;
			when "0110" => hhex1 <= six;
			when "0111" => hhex1 <= seven;
			when "1000" => hhex1 <= eight;
			when "1001" => hhex1 <= nine;
			when "1010" => hhex1 <= A;
			when "1011" => hhex1 <= b;
			when "1100" => hhex1 <= C;
			when "1101" => hhex1 <= d;
			when "1110" => hhex1 <= E;
			when others => hhex1 <= F;
		end case;
		end process;
	proc2:process (inputs) 
		begin
		case inputs(3 downto 0) is
			when "0000" => hhex0 <= zero;
			when "0001" => hhex0 <= one;
			when "0010" => hhex0 <= two;
			when "0011" => hhex0 <= three;
			when "0100" => hhex0 <= four;
			when "0101" => hhex0 <= five;
			when "0110" => hhex0 <= six;
			when "0111" => hhex0 <= seven;
			when "1000" => hhex0 <= eight;
			when "1001" => hhex0 <= nine;
			when "1010" => hhex0 <= A;
			when "1011" => hhex0 <= b;
			when "1100" => hhex0 <= C;
			when "1101" => hhex0 <= D;
			when "1110" => hhex0 <= E;
			when others => hhex0 <= F;
		end case;
		end process;
	proc3:process (inputs, absr) 
		begin
		if (inputs(7) = '0') then
			absr <= inputs(6) & inputs(5) & inputs(4) & inputs(3) & inputs(2) & inputs(1) & inputs(0);
		else
			absr <= (not (inputs(6) & inputs(5) & inputs(4) & inputs(3) & inputs(2) & inputs(1) & inputs(0)) + '1');
		end if;
		end process;
	
	proc4: process(absr, tens, dhex1)
		begin
			tens <= std_logic_vector(unsigned(absr)/10);
			--same as process 1 and 2
			case (tens (3 downto 0)) is
			when "0000" => dhex1 <= zero;
			when "0001" => dhex1 <= one;
			when "0010" => dhex1 <= two;
			when "0011" => dhex1 <= three;
			when "0100" => dhex1 <= four;
			when "0101" => dhex1 <= five;
			when "0110" => dhex1 <= six;
			when "0111" => dhex1 <= seven;
			when "1000" => dhex1 <= eight;
			when "1001" => dhex1 <= nine;
			when "1010" => dhex1 <= A;
			when "1011" => dhex1 <= b;
			when "1100" => dhex1 <= C;
			when "1101" => dhex1 <= D;
			when "1110" => dhex1 <= E;
			when others => dhex1 <= F;
		end case;
		end process;
	proc5:process(absr, ones, dhex0)
		begin
			ones <= std_logic_vector(unsigned(absr) rem(10));
			--same as process1 and 2
			case (ones(3 downto 0)) is
			when "0000" => dhex0 <= zero;
			when "0001" => dhex0 <= one;
			when "0010" => dhex0 <= two;
			when "0011" => dhex0 <= three;
			when "0100" => dhex0 <= four;
			when "0101" => dhex0 <= five;
			when "0110" => dhex0 <= six;
			when "0111" => dhex0 <= seven;
			when "1000" => dhex0 <= eight;
			when "1001" => dhex0 <= nine;
			when "1010" => dhex0 <= A;
			when "1011" => dhex0 <= b;
			when "1100" => dhex0 <= C;
			when "1101" => dhex0 <= D;
			when "1110" => dhex0 <= E;
			when others => dhex0 <= F;
		end case;
		end process;
	proc6:process(hhex1, dhex1,s)
		begin
		if s = '1' then
			hex1 <= hhex1;
		else
			hex1 <= dhex1;
		end if;
		end process;
	proc7:process(hhex0, dhex0,s)
	begin
		if s = '1' then
			hex0 <= hhex0;
		else
			hex0 <= dhex0;
		end if;
		end process;
	proc8:process(inputs, s)
		begin
			if (s  = '1') then
				hex2 <= "1111111";
			else
				if inputs(7) = '1' then
					hex2 <= "0111111";
				else
					hex2 <= "1111111";
			end if;
			end if;
		end process;
		end arch;