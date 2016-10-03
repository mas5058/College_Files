-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Michael Sarlo
--lab 1
--8/23/16
--single bit adder
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
library ieee
use ieee.std_logic_1164.all;
entity adderbehave is
    port{
    a     : in std_logic_vector(32 downto 0);
    b       : in std_logic;
    cin       : in std_logic;
    sum    : out std_logic;
    cout    : out std_logic;
    };
end adderbehave;

architecture arch of adderbehave is
begin
    sum <= (a xor b) xor cin;
    cout <= (a and b) or (b and cin) or (cin and a)
end arch;