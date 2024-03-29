library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity lab9 is
	port (pushb : in std_logic;
			s : in std_logic_vector(1 downto 0);
			clk : in std_logic;
			resetn : in std_logic;
			test   : out std_logic;
			h0, h1, h2 : out std_logic_vector(6 downto 0));
end lab9;
--DELAY IS THE SAME AS TIMER FROM LAB8
architecture arch of lab9 is
	signal d0, d1, d2, f, andres : std_logic;
	signal delay : std_logic_vector(27 downto 0);
	signal bcd0, bcd1, bcd2 : std_logic_vector(3 downto 0);
	component bcd
			port(inputs  : in std_logic_vector (3 downto 0);
			 hex : out std_logic_vector (6 downto 0)
			 );
	 end component;
	 
	component counter is 
		port(enable : in std_logic;
			  clk,reset    : in std_logic;
			  bcd0,bcd1, bcd2 : out std_logic_vector(3 downto 0));
	end component;
	 
	component timer is 
	port(clk, resetn  : in std_logic;
		 delay : in std_logic_vector(27 downto 0);
		 flag, test: out std_logic);
	end component;
	begin
	counter0: counter port map(
		enable => andres,
		reset => resetn,
		clk => clk,
		bcd0 => bcd0,
		bcd1 => bcd1,
		bcd2 => bcd2);
	
	timer0 : timer port map(
		delay => delay,
		clk => clk,
		resetn => resetn,
		test => test,
		flag => f);
	
	bcd2ssd0 : bcd port map(
		inputs => bcd0,
		hex => h0);
	
	bcd2ssd1 : bcd port map(
		inputs => bcd1,
		hex => h1);
		
	bcd2ssd2: bcd port map(
		inputs => bcd2,
		hex => h2);
	andres <= f and pushb;
	process(s)
	begin
	--s is a two bit number that is an input
	case(s) is
		when "00" => delay <= X"2FAF07F"; --1 second
		when "01" => delay <= X"2FAF07F"; --1 second
		when "10" => delay <= X"000C34F"; --1 ms
		when others => delay <= X"0000004"; --100 ns
	end case;
	
	end process;
end arch;	