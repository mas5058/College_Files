library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity lab10 is
  port(dime, nickel, quarter : in  std_logic;
       coin_return           : in  std_logic;
       dispense              : in  std_logic;
       clk                   : in  std_logic;
       reset                 : in  std_logic;
       changeback            : out std_logic;
       red_bull              : out std_logic;
       hex0, hex1            : out std_logic_vector(6 downto 0));
end lab10;

architecture arch of lab10 is
  type state_type is (wait1, nickelstate, quarterstate, dimestate, enough, change, excess, vend);
  signal current, next_state : state_type;
  signal money0, money1            : std_logic_vector(3 downto 0) := "0000";
  -- money was made two different signals, so it would be easier to represent on the seven segement display
  component bcd
    port(inputs : in  std_logic_vector (3 downto 0);
         hex    : out std_logic_vector (6 downto 0)
         );
  end component;
begin

  bcd2ssd0 : bcd port map(
    inputs => money0,
    hex    => hex0);

  bcd2ssd1 : bcd port map(
    inputs => money1,
    hex    => hex1);

  process(next_state, money0, money1,clk, reset)
	begin
	if (reset = '0') then
	    money1 <= "0000";
		 money0 <= "0000";
   elsif (rising_edge(clk)) then
		case(next_state) is
		--adds an amount of money depending on state.  
			when nickelstate =>
				if (money0 = "0101") then
				--this checks if the lsb is 5. if so add 1 to the msb, and make the lsb 5
					money1 <= money1 + '1';
					money0 <= "0000";
				else
				--if the lsb is not 5, make it 5
					money0 <= "0101";
					money1 <= money1;
				end if;
			when dimestate => money1 <= money1 + '1';
			when quarterstate =>
				if (money0 = "0101") then
				 --if the lsb is 5, then make the lsb 0 and add 3 to the msb
					money1 <= money1 + "0011";
					money0 <= "0000";
				else
				-- if the lsb is 0, then add 2 to msb, and 5 to lsb
					money1 <= money1 + "0010";
					money0 <= "0101";
				end if;
			when change => 
				--when the change state occurs, both values become zero
				money0 <= "0000";
				money1 <= "0000";
			when vend =>
				--subtracts 75 cents
				if (money0 = "0101") then
					money1 <= money1 - "0111";
					money0 <= "0000";
				else
					money1 <= money1 - "1000";
					money0 <= "0101";
				end if;
			when others =>
					money1 <= money1;
					money0 <= money0;
			end case;
		end if;
  end process;
  caseproc:process(current, money1, money0, dime, quarter, nickel, dispense, coin_return)
  begin
  --changes states
  case(current) is
	when wait1 => 
		if (money1 >= "1000") or (money0 = "0101" and money1 >= "0111") then
			--if money is greater then or equal to 75
			next_state <= enough;
		elsif dime = '1' then
			--if a dime is inserted,
			next_state <= dimestate;
		elsif quarter = '1' then
			-- if a quarter is inserted
			next_state <= quarterstate;
		elsif nickel = '1' then
			--if a nickel is inserted
			next_state <= nickelstate;
		elsif coin_return = '1' then
			-- if coin return is clicked
			next_state <= change;
		else
			next_state <= wait1;
		end if;
	when dimestate =>
		if (money1 >= "1000") or (money0 = "0101" and money1 >= "0111") then
		--if money is greater then or equal to 75
			next_state <= enough;
		else
			next_state <= wait1;
		end if;
	when quarterstate =>
		if (money1 >= "1000") or (money0 = "0101" and money1 >= "0111") then
		--if money is greater then or equal to 75
			next_state <= enough;
		else
			next_state <= wait1;
		end if;
	when nickelstate =>
		if (money1 >= "1000") or (money0 = "0101" and money1 >= "0111") then
		--if money is greater then or equal to 75
			next_state <= enough;
		else
			next_state <= wait1;
		end if;
	when enough =>
		if (dispense = '1') then
		--if the dispense input is selected, only happens during excess and enough
			next_state <= vend;
		elsif (dime = '1' or quarter = '1' or nickel = '1') then
			next_state <= excess;
		elsif coin_return = '1' then
			next_state <= change;
		else
			next_state <= enough;
		end if;
	when excess => 
		if (dispense = '1') then
		--if the dispense input is selected, only happens during excess and enough
			next_state <= vend;
		elsif (dime = '1' or quarter = '1' or nickel = '1') then
			next_state <= excess;
		elsif coin_return = '1' then
			next_state <= change;
		else
			next_state <= excess;
		end if;
	when vend =>
		if (money1 > "0000") or (money0 > "0000") then	
		--if money is greather then zero, then go to change state.
			next_state <= change;
		else
			next_state <= wait1;
		end if;
	when others => next_state <= wait1;
	end case;
	end process;

	process(next_state)
	--sets the outputs in each state 
	begin
		if next_state = change then
		--change state puts out change
			changeback <= '1';
			red_bull <= '0';
		elsif (next_state = vend) then
		--vend state puts out red bull
			red_bull <= '1';
			changeback <= '0';
		else
			red_bull <= '0';
			changeback <= '0';
		end if;
	end process;

sync: process(clk, reset)
		if reset = '0' then
			current <= wait1;
		elsif clk'event and clk = '1' then
			current <= next_state;
		end if;
	end process;
	begin
end arch;
