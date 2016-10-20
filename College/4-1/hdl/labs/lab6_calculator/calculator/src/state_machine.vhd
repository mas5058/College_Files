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
    execute           : in std_logic;
    memsave           : in std_logic;
    memrecall         : in std_logic;
    we                : out std_logic
    address           : out std_logic_vector(1 downto 0)
  );
  
end state_machine;

architecture beh of state_machine is
-- signal declarations

constant swait        : std_logic_vector(3 downto 0) := "0000";
constant sexecute        : std_logic_vector(3 downto 0) := "0001";
constant smemsave      : std_logic_vector(3 downto 0) := "0010";
constant smemcall      : std_logic_vector(3 downto 0) := "0100";
constant reset        : std_logic_vector(3 downto 0) := "1000";

signal state_reg      : std_logic_vector(3 downto 0);
signal state_next     : std_logic_vector(3 downto 0);

begin 
-- state register
process(clk,reset)
begin 
  if (reset = '1') then 
    state_reg <= reset;
  elsif (clk'event and clk = '1') then
    state_reg <= state_next;
  end if;
end process;

-- next state logic
process(state_reg,nearby_opponent,friend_wounded,me_wounded)
begin
  -- default values
  --fighting    <= '0';
  state_next <= state_reg;    -- prevents a latch
  case state_reg is  
    when sWait =>
      if (execute = '1') then  
        state_next <= sexecute;
      elsif (memsave = '1') then
        state_next <= smemsave;
      end if;  
    when sexecute =>
      execute <= '1';
      if (memcall = '1') then  
        state_next <= smemcall;
      elsif (smemsave = '1') then
        state_next  <= smemsave;
      end if;
    when smemcall =>
      if (memsave = '1') then  
        state_next <= smemsave;
	elsif (execute = '1') then
		state_next <= sexecute;
      end if;
	when smemsave =>
      if (memcall = '1') then  
        state_next <= smemcall;
	elsif (execute = '1') then
		state_next <= sexecute;
      end if;
    when others =>
      state_next <= sWait;
  end case;
end process;
end beh; 