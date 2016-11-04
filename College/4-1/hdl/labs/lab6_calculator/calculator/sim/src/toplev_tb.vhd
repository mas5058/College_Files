
library ieee;
use ieee.std_logic_1164.all;      -- gives you the std_logic type
use ieee.numeric_std.all;

entity toplev_tb is 
end toplev_tb;

architecture beh of toplev_tb is

component toplev is 
  port (
    clk                   : in std_logic;
    reset                 : in std_logic;
	execute           : in std_logic;
	memsave           : in std_logic;
	memrecall         : in std_logic;
	switches              : in std_logic_vector(7 downto 0);
	op                    : in std_logic_vector(1 downto 0);
    seven_seg_out1         : out std_logic_vector (6 downto 0);
    seven_seg_out2         : out std_logic_vector (6 downto 0);
    seven_seg_out3         : out std_logic_vector (6 downto 0)
);
end component;
  
constant period         : time := 20ns;                                              
signal clk              : std_logic := '0';
signal reset            : std_logic := '1';
signal execute            : std_logic := '1';
signal memrecall            : std_logic := '1';
signal memsave            : std_logic := '1';
signal switches             : std_logic_vector(7 downto 0);
signal seven_seg_out1             : std_logic_vector(6 downto 0);
signal seven_seg_out2             : std_logic_vector(6 downto 0);
signal seven_seg_out3             : std_logic_vector(6 downto 0);
signal op                         : std_logic_vector(1 downto 0);

begin 
uut: toplev 
  port map(
    clk                  => clk,
    op                   => op,
    reset                => reset,
    memrecall                => memrecall,
    memsave                => memsave,
    execute                => execute,
    switches             => switches,
    seven_seg_out1       => seven_seg_out1,
    seven_seg_out2       => seven_seg_out2,
    seven_seg_out3       => seven_seg_out3
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
  reset <= '1';
  execute <= '1';
  op <= "00";
  switches <= "00001000";
  wait for 100 ns;
  reset <= '0';
  wait for 100 ns;
  switches <= "00001001";
  wait for 100 ns;
  op <= "01";
  switches <= "00001010";
  wait for 100 ns;
  op <= "10";
  switches <= "00001011";
  wait for 100 ns;
  op <= "11";
  switches <= "00000111";
  wait for 100 ns;
  op <= "00";
   switches <= std_logic_vector(unsigned(switches) + 1);
   wait for 100 ns;
  end process;  
end beh;