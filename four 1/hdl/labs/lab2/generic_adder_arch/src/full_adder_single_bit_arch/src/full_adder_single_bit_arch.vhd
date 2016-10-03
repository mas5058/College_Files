-------------------------------------------------------------------------------
-- Dr. Kaputa
-- single bit full adder [hierarchical]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity full_adder_single_bit_arch is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_arch;

architecture arch of full_adder_single_bit_arch is

component alu_and
  port(
    a      : in std_logic;
    b      : in std_logic;
    c      : out std_logic
    );
  end component;
  
component alu_or
  port(
    a      : in std_logic;
    b      : in std_logic;
    c      : out std_logic
    );
  end component;
  
component alu_xor
  port(
    a      : in std_logic;
    b      : in std_logic;
    c      : out std_logic
    );
  end component;

signal temp1  : std_logic;
signal temp2  : std_logic;
signal temp3  : std_logic;
signal temp4  : std_logic;
signal temp5  : std_logic;
  
begin 
  xor1_inst: alu_xor 
    port map(
      a     => a,
      b     => b,
      c     => temp1
    );
    
  xor2_inst: alu_xor 
    port map(
      a     => temp1,
      b     => cin,
      c     => sum 
    );
    
  and1_inst: alu_and 
    port map(
      a     => a,
      b     => b,
      c     => temp2 
    );
    
  and2_inst: alu_and 
    port map(
      a     => b,
      b     => cin,
      c     => temp3 
    );
    
  and3_inst: alu_and 
    port map(
      a     => cin,
      b     => a,
      c     => temp4 
    );
    
  or1_inst: alu_or 
    port map(
      a     => temp2,
      b     => temp3,
      c     => temp5 
    );
    
  or2_inst: alu_or 
    port map(
      a     => temp5,
      b     => temp4,
      c     => cout 
    );  

end arch; 