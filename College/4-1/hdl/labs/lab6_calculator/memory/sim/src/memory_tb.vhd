-------------------------------------------------------------------------------
-- Dr. Kaputa
-- memory test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      -- gives you the std_logic type
use ieee.numeric_std.all;

entity memory_tb is 
end memory_tb;

architecture beh of memory_tb is

component memory is 
  generic (addr_width : integer := 2;
           data_width : integer := 4);
  port (
    clk               : in std_logic;
    we                : in std_logic;
    addr              : in std_logic_vector(addr_width - 1 downto 0);
    din               : in std_logic_vector(data_width - 1 downto 0);
    dout              : out std_logic_vector(data_width - 1 downto 0)
  );
end component;

-- constant declarations
constant period         : time := 20ns;                                              
constant ADDR_WIDTH     : integer := 2;                                              
constant DATA_WIDTH     : integer := 4;     
                                         
signal clk              : std_logic := '0';
signal we               : std_logic := '0';
signal addr             : std_logic_vector(ADDR_WIDTH -1 downto  0);
signal din              : std_logic_vector(DATA_WIDTH -1 downto  0);
signal dout             : std_logic_vector(DATA_WIDTH -1 downto  0);

signal reset            : std_logic := '1';

-- signal declarations
constant sIdle          : std_logic_vector(2 downto 0) := "001";
constant sWrite         : std_logic_vector(2 downto 0) := "010";
constant sRead          : std_logic_vector(2 downto 0) := "100";
 
signal state_reg        : std_logic_vector(2 downto 0);
signal state_next       : std_logic_vector(2 downto 0);

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

-- state register
process(clk,reset)
begin 
  if (reset = '1') then 
    state_reg <= sIdle;
  elsif (clk'event and clk = '1') then
    state_reg <= state_next;
  end if;
end process;

-- next state logic
process(state_reg)
begin
  -- default values
  we    <= '0';
  addr  <= "00";
  din   <= "0000";
  case state_reg is  
    when sIdle =>
      state_next <= sWrite;
    when sWrite =>
      -- write to address 01
      we          <= '1';
      addr        <= "01";
      din         <= "0101";
      state_next  <= sRead;
    when sRead =>
      -- read from address 01
      addr        <= "01";
      state_next  <= sIdle;
    when others =>
      state_next  <= sIdle;
  end case;
end process;

uut: memory 
  generic map (addr_width => ADDR_WIDTH,
               data_width => DATA_WIDTH)
  port map(
    clk           => clk,
    we            => we,
    addr          => addr,
    din           => din,
    dout          => dout
  );
end beh;