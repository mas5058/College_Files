library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity toplev is
    port(
    clk                   : in std_logic;
    reset                 : in std_logic;
	switches              : in std_logic_vector(7 downto 0);
	memrecal              : in std_logic;
	memsave               : in std_logic;
	execute               : in std_logic;
    seven_seg_out         : out std_logic_vector (7 downto 0)
);
end entity toplev;

architecture arch of toplev is
signal datain,dataout : std_logic_vector(7 downto 0) := (others => '0');
signal enable,wesig,addr,rezsig : std_logic;

component alu2bitoper is
	port(
	a           : in std_logic_vector(7 downto 0);
	b           : in std_logic_vector(7 downto 0);
	oper        : in std_logic_vector(1 downto 0);
	result      : out std_logic_vector(7 downto 0)
		);
	end component;
	
component memory is
  port (
    clk               : in std_logic;
    we                : in std_logic;
    addr              : in std_logic_vector(addr_width - 1 downto 0);
    din               : in std_logic_vector(data_width - 1 downto 0);
    dout              : out std_logic_vector(data_width - 1 downto 0)
  );
end component;


component rising_edge_synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component;

component seven_seg is 
    port(inputs  : in std_logic_vector (3 downto 0);
        clk     : in std_logic;
        reset   : in std_logic;
        hex0 : out std_logic_vector (6 downto 0)
        );
        end component;
  
 begin
	mem: memory 
		port map(
			clk => clk,
			we => wesig,
			addr => addr,
			din => datain,
			dout => dataout)
  
  
    uut: seven_seg
		port map(
			inputs => sum_sig, 
			clk => clk,
			reset => reset,
			hex0 => seven_seg_out
        );
	alu:alu2bitoper
		port map(
			a => dataout,
			b => switches,
			oper => 
			result => rezsig
			);
	sumreg : process (reset,enable,clk)
	begin
	if reset = '1' then
		sum_sig <= (others => '0');
	elsif ((enable = '1') and (rising_edge(clk))) then
		sum_sig <= sum;
	end if;
end process;


end arch;
	
		