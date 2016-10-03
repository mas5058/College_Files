library ieee
use ieee.std_logic_1164.all;
entity adderstruct is
    port{
    a     : in std_logic_vector(32 downto 0);
    b       : in std_logic;
    cin       : in std_logic;
    sum    : out std_logic;
    cout    : out std_logic;
    };
end adderstruct;

architecture arch of adderstruct is
    component and2
        port(a,b : in std_logic
             z   : out std_logic)
    end component
    
    component xor2
        port(a, b 
             z    )

