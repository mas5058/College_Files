-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder test bench 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity generic_adder_tb is
end generic_adder_tb;

architecture arch of generic_adder_tb is

component generic_adder_beh is
  generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
end component generic_adder_beh;

constant NUM_BITS          : integer := 2;
constant SEQUENTIAL_FLAG   : boolean := true;     -- false : concurrent stimuli, true: sequential stimuli
signal a                   : std_logic_vector(NUM_BITS - 1 downto 0) := (others => '0');
signal b                   : std_logic_vector(NUM_BITS - 1 downto 0) := (others => '0');
signal cin                 : std_logic := '0';
signal sum                 : std_logic_vector(NUM_BITS - 1 downto 0);
signal cout                : std_logic;
signal cin_guard           : std_logic_vector(NUM_BITS - 2 downto 0) := (others => '0');

begin

uut: generic_adder_beh  
  generic map (
    bits => NUM_BITS
  )
  port map(
    a       => a,
    b       => b,
    cin     => cin,
    sum     => sum,
    cout    => cout
  );

sequential_stimuli: if SEQUENTIAL_FLAG generate
  sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 10 ns;   -- let all the initial conditions trickle through
      for i in 0 to ((2 ** NUM_BITS) - 1) loop
        a <= std_logic_vector(unsigned(a) + 1 );
        for j in 0 to ((2 ** NUM_BITS) - 1)  loop
          b <= std_logic_vector(unsigned(b) + 1 );
          wait for 10 ns;
        end loop;
      end loop;
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 
end generate sequential_stimuli;

concurrent_stimuli: if not SEQUENTIAL_FLAG generate
  b(0) <= not b(0) after 10 ns;
  b(1) <= not b(1) after 20 ns;
  a(0) <= not a(0) after 40 ns;
  a(1) <= not a(1) after 80 ns;
end generate concurrent_stimuli;

math_check : process(sum) 
  begin
    assert (unsigned(a) + unsigned(b) + unsigned(cin_guard & cin) = unsigned(sum))
    report  "a:" & integer'image(to_integer(unsigned(a))) & " " & 
            "b:" & integer'image(to_integer(unsigned(b))) & " " &
            "sum:" & integer'image(to_integer(unsigned(sum)));
  end process;
end arch;