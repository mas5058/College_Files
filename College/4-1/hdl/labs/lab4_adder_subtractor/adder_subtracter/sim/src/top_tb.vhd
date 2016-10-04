-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture arch of top_tb is

component top is 
	port (a, b 			 : in std_logic_vector (2 downto 0);
		  oper 			 : in std_logic_vector(1 downto 0);
		  add,sub,clk,reset 	 : in std_logic;
		  hex0,hex1,hex2 : out std_logic_vector (6 downto 0);
	);
	end component; 

--signal output       : std_logic;
constant period     : time := 20ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';

begin

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

uut: top  
  port map(
    clk       => clk,
	a         =>    a,
	b         =>    b,
	oper      =>  oper,
    reset     => reset,
    hex0      =>  hex0,
    hex1      =>  hex1,
    hex2      =>  hex2
  );
end arch;