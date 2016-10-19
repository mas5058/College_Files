library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity counter is 
	port(enable : in std_logic;
		  clk    : in std_logic;
		  reset  : in std_logic;
		  bcd0,bcd1, bcd2 : out std_logic_vector(3 downto 0));
	end counter;

architecture arch of counter is
--ROLLS AT 999 make count 3 4 bit numbers
	signal count0,count1,count2 : std_logic_vector(3 downto 0);
	begin
	bcd0 <= count0;
	bcd1 <= count1;
	bcd2 <= count2;
	--count3 is msb, count0 is lsb.
	process(clk, enable, reset)
	begin
	if (rising_edge(clk)) then
		if (enable = '1') then
			--count0 = count0 + '1';
			if (count0 = "1001") then
				count0 <= "0000";
				if count1 = "1001" then
					count1 <= "0000";
					if count2 = "1001" then
						count2 <= "0000";
					else
						count2 <= count2 + '1';
					end if;
				else
					count1 <= count1 + '1';
				end if;
			else
				count0 <= count0 + '1';
			end if;
		
		elsif(reset = '0') then
			count0 <= "0000";
			count1 <= "0000";
			count2 <= "0000";
		else 
			count0 <= count0;
			count1 <= count1;
			count2 <= count2;
		end if;
		end if;
	end process;
	end arch;
			