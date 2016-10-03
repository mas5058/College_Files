library ieee;
use ieee.std_logic_1164.all;

entity hw7_3 is
	port(clk : in std_logic;
		  sh : in std_logic;
		  din : in std_logic_vector(7 downto 0);
		  dir : in std_logic;
		  sin : in std_logic;
		  sout : out std_logic
		  );
end hw7_3;

architecture arch of hw7_3 is
signal q,d : std_logic_vector(7 downto 0);
begin
process(dir, clk, sh)
begin
	if(clk'event and clk = '1') then	
	d <= q;
		if (dir = '1') then
			if (sh = '1') then
				q(0) <= sin;
				q(1) <= d(0);
				q(2) <= d(1);
				q(3) <= d(2);
				q(4) <= d(3);
				q(5) <= d(4);
				q(6) <= d(5);
				q(7) <= d(6);
				sout <= d(7);
			else
				q(0) <= d(1);
				q(1) <= d(2);
				q(2) <= d(3);
				q(3) <= d(4);
				q(4) <= d(5);
				q(5) <= d(6);
				q(6) <= d(7);
				q(7) <= sin;
				sout <= d(0);
			end if;
		else
			q <= din;
		end if;
	end if;
	end process;
end arch;
				
				
			