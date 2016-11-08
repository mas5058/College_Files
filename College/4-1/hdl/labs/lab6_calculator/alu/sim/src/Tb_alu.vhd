LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
  
ENTITY Tb_alu IS
END Tb_alu;
  
ARCHITECTURE behavior OF Tb_alu IS
  
 -- Component Declaration for the Unit Under Test (UUT)
  
 component alu2bitoper is 
	port (a,b : in std_logic_vector (7 downto 0);
		  oper : in std_logic_vector(1 downto 0);
		  result    : out std_logic_vector(7 downto 0)
	);
	end component;
  
 
 --Inputs
 signal a : std_logic_vector(7 downto 0) := (others => '0');
 signal b : std_logic_vector(7 downto 0) := (others => '0');
 signal result : std_logic_vector(7 downto 0) := (others => '0');
 signal oper : std_logic_vector(1 downto 0) := (others => '0');
 
 --Outputs
 --signal out_alu : signed(3 downto 0);
  
BEGIN
  
 -- Instantiate the Unit Under Test (UUT)
 uut: alu2bitoper PORT MAP (
 a => a,
 b => b,
 oper => oper,
 result => result
 );
 
 -- Stimulus process
 stim_proc: process
 begin
 -- hold reset state for 100 ns.
 wait for 100 ns; 
 
 -- insert stimulus here 
 
 a <= "00001001";
 b <= "00000011";
  
 oper <= "00";
 wait for 100 ns; 
 oper <= "01";
 wait for 100 ns;
 oper <= "10";
 wait for 100 ns; 
 oper <= "11";
 wait for 100 ns; 
 end process;
 
END;