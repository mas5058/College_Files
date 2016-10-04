-------------------------------------------------------------------------------
-- Dr. Kaputa
-- toplevcount test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity toplevelcount_tb is
end toplevelcount_tb;

architecture arch of toplevelcount_tb is

component toplevelcount is
  port (
    clk                   : in std_logic;
    reset                 : in std_logic;
    --enable                : in std_logic;
    seven_seg_out         : out std_logic_vector (6 downto 0)
    --sum                   : out std_logic_vector (3 downto 0)
   );
end component;  

signal output       : std_logic;
constant period     : time := 20 ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal seven_seg_out       : std_logic_vector(6 downto 0);
--signal sum                 : std_logic_vector(3 downto 0);

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

uut: toplevelcount  
  generic map (
    max_count => 4
  )
  port map(
    clk => clk,
    reset => reset,
--    enable => enable,
    seven_seg_out => seven_seg_out
    --sum => sum
  );
end arch;