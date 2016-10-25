library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--each button is rising edge synchonized and each input is synchonized
entity alu2bitoper is 
	port (a,b : in std_logic_vector (7 downto 0);
		  oper : in std_logic_vector(1 downto 0);
		  result    : out std_logic_vector(7 downto 0)
	);
	end alu2bitoper;
	

	architecture arch of alu2bitoper is
	signal rez,signeda,signedb, unsigneda, unsignedb : std_logic_vector(7 downto 0);
	signal reztemp : std_logic_vector(16 downto 0);
	begin
	result <= rez;
	--signeda <= a(3) & a(3) & a(3) & a(3) & a;
	--signedb <= b(3) & b(3) & b(3) & b(3) & b;
	--unsigneda <= "0000" & a;
	--unsignedb <= "0000" & b;
	process (a,b,oper,signeda,signedb,unsigneda)
	begin
	case oper is
		when "00" => rez <= unsigned(a) + unsigned(b);
		when "01" => rez <= unsigned(a) - unsigned(b);
		when "10" => rez <= (unsigned(a) * unsigned(b));
		when "11" => 
			reztemp <= (std_logic_vector(unsigned("00000000" & a)/unsigned("00000000" & b)));
			rez <= reztemp(7 downto 0);
		when others => rez <= "00000000";
		end case;
		end process;
		end arch;
	-- if (oper = "000") then
		-- result <= a + b;
	-- elsif (oper = "001") then
		-- result <= a + ((not b) + '1');
	-- elsif (oper = "010") then
		-- result <= a * b;
	-- elsif (oper = "011") then
		-- result <= (not a + '1');
	-- elsif (oper = "100") then
		-- result <= a and b;
	-- elsif (oper = "101") then
		-- result <= a or b;
	-- elsif (oper = "110") then
		-- result <= a xor b;
	-- else 
		-- result <= not a;
		-- end if;
		