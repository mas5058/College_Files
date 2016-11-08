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
    we                : out std_logic;
    address           : out std_logic_vector(1 downto 0)
  );
  
end state_machine;

architecture beh of state_machine is
-- signal declarations

constant wait0        : std_logic_vector(3 downto 0) := "0000";
constant save        : std_logic_vector(3 downto 0) := "0001";
constant load      : std_logic_vector(3 downto 0) := "0010";
constant execute0      : std_logic_vector(3 downto 0) := "0100";
constant execute1        : std_logic_vector(3 downto 0) := "1000";

signal state_reg      : std_logic_vector(3 downto 0);
signal state_next     : std_logic_vector(3 downto 0);
signal wesig     : std_logic;


begin 
-- state register
process(clk,reset)
begin 
  if (reset = '1') then 
    state_reg <= (others => 0);
    we <= '0';
    address <= (others => 0);
  elsif (clk'event and clk = '1') then
    state_reg <= state_next;
    we <= wesig;
  end if;
end process;

-- next state logic
process(state_reg)
begin
  -- default values
  --fighting    <= '0';
  state_next <= state_reg;    -- prevents a latch
  case state_reg is  
    when wait0 =>
      if (execute = '1') then  
        state_next <= execute0;
      elsif (memsave = '1') then
        state_next <= save;
      elsif (memrecall = '1') then
        state_next <= load;
      end if;  
    when execute0 =>
      state_next <= execute1;
      end if;
    when execute1 =>
       address <= "00";
       wesig <= '1';
       state_next <= wait0;
	when save =>
      address <= "01";
      wesig <= '1';
      state_next <= wait0
      end if;
    when others =>
      address <= "00";
      wesig <= '0';
      state_next <= wait0;
      
  end case;
end process;
end beh; 