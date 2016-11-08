library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--each button is rising edge synchonized and each input is synchonized
entity alu2bitoper is 
	port (a,b : in std_logic_vector (7 downto 0);
		  oper : in std_logic_vector(1 downto 0);
		  result    : out std_logic_vector(7 downto 0)
	);
	end alu2bitoper;
	

	architecture arch of alu2bitoper is
	signal result_sig : std_logic_vector(7 downto 0) := (others => '0');
	signal result_sigtemp : std_logic_vector(15 downto 0) := (others => '0');
	begin
	result <= result_sig(7 downto 0);
	--result_sig <= std_logic_vector(unsigned(a)+unsigned(b));
	 process (a,b,oper,result_sigtemp,result_sig)
	 begin
	 case oper is
		  when "00" => result_sig <= std_logic_vector(unsigned(a)+unsigned(b));
		  when "01" => result_sig <= std_logic_vector(unsigned(a)-unsigned(b));
		  when "10" => result_sigtemp <= std_logic_vector(unsigned(a)*unsigned(b));
			       result_sig <= result_sigtemp(7 downto 0);
		 when "11" => 
			 result_sigtemp <= (std_logic_vector(unsigned("00000000" & a)/unsigned("00000000" & b)));
			 result_sig <= result_sigtemp(7 downto 0);
		 when others => result_sig <= "00000000";
		 end case;
		 end process;
	 end arch;
	