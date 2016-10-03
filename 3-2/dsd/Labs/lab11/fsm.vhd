library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity fsm is
	port (key1, clk, key2, flag, resetn :in std_logic;
			den1, den2, xoren, timen, shiftld, shiftsh: out std_logic;
			muxseal : out std_logic_vector(1 downto 0)); 
end fsm; 

architecture behave of fsm is 
	type state_type is (start, input, lockin, lockencrypt,load,shift, output,xors,pulse);
	signal current_state, next_state : state_type; 
	signal count : std_logic_vector(3 downto 0);
	begin
	sync: process(clk, resetn)
	begin
		if resetn = '0' then
			current_state <= input;
		elsif clk'event and clk = '1' then
			current_state <= next_state;
		end if;
	end process;
	
	process(current_state, count, clk, resetn, flag)
	begin
	  if (resetn = '0') then
	     count <= "0000";
		elsif (clk'event and clk = '1') then
		  if (flag = '1') then 
			if current_state = pulse then
				count <= count + '1';
			else
				count <= "0000";
			end if;
		end if;
		end if;
	end process;

	process(key1, key2, flag, current_state, count)
		begin
		case(current_state) is
		  when start => 
		      if flag = '1' then
		          next_state <= input;
		       else
		          next_state <= start;
		        end if;
			when input =>
				if (key1 = '0') then
					next_state <= lockin;
				else 
					next_state <= input; 
				end if; 
			when lockin =>
				if (key2 = '0') then	
					next_state <= lockencrypt; 
				else 
					next_state <= lockin; 
				end if; 
			when lockencrypt => next_state <= xors;
			when xors => next_state <= load;

			when load => next_state <= shift;
			when shift => next_state <= pulse;
			when others => 
				if (count < "1111") then
					next_state <= pulse;
					
				else
					next_state <= input;
					--count <= "0000";
				end if;
			end case;
		end process;
	process(current_state)
		begin
		if (current_state = start) then
		  den1 <= '0';
			den2 <= '0';
			xoren <= '0';
			timen <= '0';
			shiftld <= '0';
			shiftsh <= '0';
			muxseal <= "00";
		elsif (current_state = input) then
			den1 <= '0';
			den2 <= '0';
			xoren <= '0';
			timen <= '0';
			shiftld <= '0';
			shiftsh <= '0';
			muxseal <= "01";
		elsif (current_state = lockin) then
			den1 <= '0';
			den2 <= '1';
			xoren <= '0';
			timen <= '0';
			shiftld <= '0';
			shiftsh <= '0';
			muxseal <= "01";
		elsif (current_state = lockencrypt) then 
			den1 <= '1';
			den2 <= '0';
			xoren <= '0';
			timen <= '0';
			shiftld <= '0';
			shiftsh <= '0';
			muxseal <= "01";
		elsif (current_state = xors) then 
			den1 <= '0';
			den2 <= '0';
			xoren <= '1';
			timen <= '0';
			shiftld <= '0';
			shiftsh <= '0';
			muxseal <= "01";
		elsif (current_state = load) then 
			den1 <= '0';
			den2 <= '0';
			xoren <= '0';
			timen <= '0';
			shiftld <= '1';
			shiftsh <= '0';
			muxseal <= "01";
		elsif (current_state = shift) then 
			den1 <= '0';
			den2 <= '0';
			xoren <= '0';
			timen <= '0';
			shiftld <= '0';
			shiftsh <= '1';
			muxseal <= "11";
		else
			den1 <= '0';
			den2 <= '0';
			xoren <= '0';
			timen <= '0';
			shiftld <= '0';
			shiftsh <= '0';
			muxseal <= "11";
		end if;
		
	end process;
end behave;


