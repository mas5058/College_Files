-------------------------------------------------------------------------------
-- Dr. Kaputa
-- state machine example
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity state_machine is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    nearby_opponent   : in std_logic;
    friend_wounded    : in std_logic;
    me_wounded        : in std_logic;
    fighting          : out std_logic
  );
end state_machine;

architecture beh of state_machine is
-- signal declarations
constant sWait        : std_logic_vector(3 downto 0) := "0001";
constant sAttack      : std_logic_vector(3 downto 0) := "0010";
constant sHeal        : std_logic_vector(3 downto 0) := "0100";
constant sFlee        : std_logic_vector(3 downto 0) := "1000";

signal state_reg      : std_logic_vector(3 downto 0);
signal state_next     : std_logic_vector(3 downto 0);

begin 
-- state register
process(clk,reset)
begin 
  if (reset = '1') then 
    state_reg <= sWait;
  elsif (clk'event and clk = '1') then
    state_reg <= state_next;
  end if;
end process;

-- next state logic
process(state_reg,nearby_opponent,friend_wounded,me_wounded)
begin
  -- default values
  fighting    <= '0';
  state_next <= state_reg;    -- prevents a latch
  case state_reg is  
    when sWait =>
      if (friend_wounded = '1') then  
        state_next <= sHeal;
      elsif (nearby_opponent = '1') then
        state_next <= sAttack;
      end if;  
    when sAttack =>
      fighting <= '1';
      if (friend_wounded = '1') then  
        state_next <= sHeal;
      elsif (me_wounded = '1') then
        state_next  <= sFlee;
      elsif (nearby_opponent = '0') then
        state_next <= sWait;
      end if;
    when sHeal =>
      if (me_wounded = '1') then  
        state_next <= sFlee;
      elsif (friend_wounded = '0') then
        state_next <= sAttack;
      end if;
    when sFlee =>
      if (me_wounded = '0') then
        state_next <= sWait;
      end if;
    when others =>
      state_next <= sWait;
  end case;
end process;
end beh; 