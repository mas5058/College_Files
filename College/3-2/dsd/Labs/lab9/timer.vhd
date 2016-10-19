library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity timer is
	port(clk, resetn  : in std_logic;
		 delay : in std_logic_vector(27 downto 0);
		 flag, test: out std_logic);
	end timer;

architecture arch of timer is
	signal max_count : std_logic_vector(27 downto 0);
	signal int_count :std_logic_vector(27 downto 0);
	signal f,ts : std_logic;
	--signal flag : std_logic;
	--flag <= flag;
	begin
	flag <= f;
	test <= ts;
	max_count <= delay;
	delay0 :process(clk)
	begin
	if (rising_edge(clk)) then
		if (resetn = '0') then
			int_count <= (others => '0');
		else
			if(int_count = max_count) then
				int_count <= (others => '0');
			else
				int_count <= (int_count + '1');
			end if;
		end if;
	end if;
	end process;
	
	flaging:process (clk)
		begin
			if(rising_edge(clk)) then
				if (resetn = '0') then
					f<= '0';
					ts <= '0';
				else
					if (int_count = max_count) then
						f <= '1';
					else
						f <= '0';
					end if;
				end if;
				if f = '1' then
					ts <= not ts;
				end if;
			end if;
		end process;
		end arch;