-------------------------------------------------------------------------------
-- Dr. Kaputa
-- state machine test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      -- gives you the std_logic type

entity state_machine_tb is 
end state_machine_tb;

architecture beh of state_machine_tb is

component state_machine
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    execute           : in std_logic;
    memsave           : in std_logic;
    memrecall         : in std_logic;
    we                : out std_logic;
    address           : out std_logic_vector(1 downto 0)
  );
  end component;
  
constant period         : time := 20ns;                                              
signal clk              : std_logic := '0';
signal reset            : std_logic := '1';
signal execute          : std_logic := '0';
signal memsave          : std_logic := '0';
signal memrecall          : std_logic := '0';
signal we          : std_logic := '0';
signal address         : std_logic_vector := "00";

begin 
uut: state_machine 
  port map(
    clk               => clk,
    reset             => reset,
    execute             => execute,
    memsave             => memsave,
    memrecall             => memrecall,
    reset             => reset,
    address             => address
	
    
  );
 
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
    
main: process 
  begin
    --assert false report "****************** TB Start ****************" severity note;
	reset <= '1';
	wait for 10 ns;
	reset <= '0';
	wait for 10 ns;
	execute <= '1';
	wait for 50 ns;
	execute <= '0';
	memsave <= '1';
	wait for 30 ns;
	memrecall <= '1';
    wait;
  end process;  
end beh;