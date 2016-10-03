-------------------------------------------------------------------------------
-- Dr. Kaputa
-- synchronizer test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      -- gives you the std_logic type

entity synchronizer_tb is 
end synchronizer_tb;

architecture beh of synchronizer_tb is

component synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic;
    sync_out          : out std_logic
  );
end component;
  
constant period         : time := 20ns;                                              
signal clk              : std_logic := '0';
signal reset            : std_logic := '1';
signal async_in         : std_logic := '0';
signal sync_out         : std_logic;

begin 
uut: synchronizer 
  port map(
    clk               => clk,
    reset             => reset,
    async_in          => async_in,
    sync_out          => sync_out
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
    report "****************** TB Start ****************" severity note;
    wait for 3 * period;
    wait for 5 ns;
    async_in <= '1';
    
    report "****************** TB Finish ****************" severity note;
    wait;
  end process;  
end beh;