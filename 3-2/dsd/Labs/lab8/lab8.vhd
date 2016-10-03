library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity lab8 is
	port(inputs : in std_logic_vector(15 downto 0);
		  clk   : in std_logic;
		  rot   : in std_logic;
		  resetn : in std_logic;
		  load : in std_logic;
		  h1    : out std_logic_vector(6 downto 0);
		  h2    : out std_logic_vector(6 downto 0);
		  m1    : out std_logic_vector(6 downto 0);
		  m2    : out std_logic_vector(6 downto 0);
		  s1    : out std_logic_vector(6 downto 0);
		  s2    : out std_logic_vector(6 downto 0));
	end lab8;

architecture arch of lab8 is
	signal hour2, hour1, minute2, minute1, second2, second1 : std_logic_vector(3 downto 0);
	signal count : std_logic;
	--signal count : std_logic_vector(26 downto 0);
	--integer count,second,minute,hour = 0;
	component bcd
		port(inputs  : in std_logic_vector (3 downto 0);
		 hex : out std_logic_vector (6 downto 0)
		 );
		 end component;
	component timer
		port(clk, rot, resetn : in std_logic;
		     flag : out std_logic);
		end component;
	begin
	--one bcd for each ssd
	timer1 : timer port map(
		clk => clk,
		rot => rot,
		resetn => resetn,
		flag => count);
		
	hourproc1 : bcd port map(
		inputs => hour2,
		hex => h1);
		
	hourproc2 : bcd port map(
		inputs => hour1,
		hex => h2);
		
	minuteproc1: bcd port map(
		inputs => minute2,
		hex => m1);

	minuteproc2: bcd port map(
		inputs => minute1,
		hex => m2);

	secondproc1: bcd port map(
		inputs => second2,
		hex => s1);
	
	secondproc2: bcd port map(
		inputs => second1,
		hex => s2);
	
	process(clk, second2, second1, hour1, hour2, minute1, minute2)
	begin
	if (resetn = '0') then
	--if reset is low, the clock is reset
		hour2 <= "0000";
		hour1 <= "0000";
		minute1 <= "0000";		
		minute2 <= "0000";
		second1 <= "0000";
		second2 <= "0000";
	elsif((clk'event) and clk = '1') then
		if (load = '0') then
		minute1 <= inputs(3 downto 0);
		minute2 <= inputs(7 downto 4);
		hour1 <= inputs(11 downto 8);
		hour2 <= inputs(15 downto 12);
		elsif count = '1' then 
			--below is a nested if.  This nested is causing the time to loop around.  Seconds loop at 59, minutes loop at 59, hour loops at 23. 
			if (second1) = "1001" then
				second1 <= "0000";
				if second2 = "0101" then
					second2 <= "0000";
						if minute1 = "1001" then
							minute1 <= "0000";
							if minute2 = "0101" then
								minute2 <= "0000";
								if (hour1 = "0011") and (hour2 = "0010") then
									hour1 <= "0000";
									hour2 <= "0000";
								elsif (hour1 = "1001") then
									hour1 <= "0000";
									hour2 <= hour2 + '1';
								else 
									hour1 <= hour1 + '1';
								end if;
							else
								minute2 <= minute2 + '1';
							end if;
						else
							minute1 <= minute1 + '1';
						end if;
					else
						second2 <= second2 + '1';
					end if;
				else
					second1 <= second1 + '1';
				end if;
			end if;
			end if;
			end process;
					
--	countcontrol:process(clk)
--		begin
--		if (clk'event and clk = '1') then
--			if count = "0101" then
--				count = (others => '0');
--			else 
--				count = count + '1';
--		end if;
--		end if;
--	end process;
--	
--	sec:process(clk)
--		begin
--		if (clk'event and clk = '1') then
--			if count = '0' then
--				if second = "00111011" then
--					second => (others => '0');
--				else
--					second => second + '1';
--					end if;
--			else
--				second => second;
--			end if;
--			end if;
--		end process;
--	sectrol:process(sec,clk)
--		begin
--		if (clk'event and clk = '1') then
--			if second = 59 then
--				second = 0;
--			else
--				second += 0;
--		end if;
--		end if;
--		end process;
				
--	min:process(clk, second)
--		begin
--		if (clk'event and clk = '1') then
--			if second = "00111100" then
--				if minute = "00111011" then
--					minute = (others => '0');
--				else
--					minute += '1';
--				end if;
--			end if;
--			end if;
--		end process;
--	mintrol:process (clk, minute)
--		begin
--		if (clk'event and clk = '1') then
--			if minute = 59 then
--				minute = 0;
--			else 
--				minute += 0;
--			end if;
--			end if;
--			end process;
--	hour:process(clk, minute)
--		begin
--		if (clk'event and clk = '1') then
--			if minute = "00111100" and second = "00111100" then
--				if hour = "0001011" and minute = "111011"  then
--					hour => (others => '0');
--				else 
--					hour = '1';
--				end if;
--			end if; 
--			end if;
--			end process;
--	hourtrol: process(clk)
--		begin
--		if (clk'event and clk = '1') then
--			if hour = 23 and minute = 59  then
--				hour = 0;
--			else 
--				hour += 0;
--			end if;
--			end if;
--			end process;
	
	END ARCH;