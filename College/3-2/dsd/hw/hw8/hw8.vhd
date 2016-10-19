library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity hw8 is 
	port (start,full : in std_logic;
			timer : in std_logic;
			water, rotate : out std_logic);
	end hw8;
	
architecture arch of hw8 is
	type state_type is (idle, fill, agitate, rinse , spin);
	signal outputs : std_logic_vector(1 downto 0);
	signal count : std_logic_vector(3 downto 0);
--	signal max_count : std_logic_vector(3 downto 0);
	signal current, nextstate : state_type; 
	--inputs <= full & start;
	begin
	water <= outputs(1);
	rotate <= outputs(0);
	process(full, start, count, current)
	begin
		if start = '0' then
			nextstate <= idle;
		else
			if full = '0' then
				if count < "0111" then
					nextstate <= fill;
				else
					nextstate <= rinse;
				end if;
			else
				if count < "0111" then
					nextstate <= agitate;
				else
					nextstate <= spin;
				end if;
			end if;
		end if;
		
		if (count = "1010") then
			nextstate <= idle;
		end if;
		
		case(nextstate) is
			when idle => outputs <= "00";
			when fill => outputs <= "10";
			when agitate => outputs <= "01";
			when rinse => outputs <= "10";
			when spin => outputs <= "01";
		end case;
		end process;
		sync: process(timer)
		begin
		if(timer'event and timer = '1') then
			current <= nextstate;
			count <= count + '1';
		end if;
		end process;
		end arch;
--		case(inputs) is
--			when "01" => water <= '1';
--			when others => water <= '0';
--		end case;
--		
--		case(inputs) is
--			when "11" => rotate <= '0';
--			when others => rotate <= '0';
--		end case;