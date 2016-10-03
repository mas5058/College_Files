-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder [hierarchical]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_adder_arch is
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
end entity generic_adder_arch;

architecture arch of generic_adder_arch is

component full_adder_single_bit_arch is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end component full_adder_single_bit_arch;

signal carry_internal: std_logic_vector(bits downto 0);

begin
  adders: for i in 0 to bits-1 generate
    full_adder: full_adder_single_bit_arch
      port map (
        a       => a(i),
        b       => b(i),
        cin     => carry_internal(i),
        sum     => sum(i),
        cout    => carry_internal(i+1)
      );
  end generate;
  
  carry_internal(0) <= cin; 
  cout <= carry_internal(bits);
end arch;