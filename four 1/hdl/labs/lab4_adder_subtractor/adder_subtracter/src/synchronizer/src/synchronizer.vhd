-------------------------------------------------------------------------------
-- Dr. Kaputa
-- synchronizer example
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic;
    sync_out          : out std_logic
  );
end synchronizer;

architecture beh of synchronizer is
-- signal declarations
signal flop1     : std_logic;
signal flop2     : std_logic;

begin 
double_flop :process(reset,clk,async_in)
  begin
    if reset = '1' then
      flop1 <= '0';   
      flop2 <= '0';	
    elsif rising_edge(clk) then
      flop1 <= async_in;
      flop2 <= flop1;
    end if;
end process;

sync_out <= flop2;
end beh; 