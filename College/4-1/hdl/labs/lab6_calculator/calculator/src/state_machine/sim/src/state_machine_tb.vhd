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
    nearby_opponent   : in std_logic;
    friend_wounded    : in std_logic;
    me_wounded        : in std_logic;
    fighting          : out std_logic
  );
  end component;
  
constant period         : time := 20ns;                                              
signal clk              : std_logic := '0';
signal reset            : std_logic := '1';
signal nearby_opponent  : std_logic := '0';
signal friend_wounded   : std_logic := '0';
signal me_wounded       : std_logic := '0';
signal fighting         : std_logic;

begin 
uut: state_machine 
  port map(
    clk               => clk,
    reset             => reset,
    nearby_opponent   => nearby_opponent,
    friend_wounded    => friend_wounded,
    me_wounded        => me_wounded,
    fighting          => fighting
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
    assert false report "****************** TB Start ****************" severity note;
    wait for 65 ns;     
    assert(fighting = '0') report "should be waiting";
    nearby_opponent <= '1';
    wait for 20 ns;          
    assert(fighting = '1') report "should be fighting";
    friend_wounded  <= '1';
    wait for 20 ns;
    assert(fighting = '0') report "should be healing";
    me_wounded      <= '1';
    wait for 20 ns;
    assert(fighting = '0') report "should be fleaing";
    assert false report "****************** TB Finish ****************" severity note;
    wait;
  end process;  
end beh;