library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity toplev is
    port(
    clk                   : in std_logic;
    reset                 : in std_logic;
	switches              : in std_logic_vector(7 downto 0);
	op              : in std_logic_vector(1 downto 0);
	-- memrecall              : in std_logic;
	-- memsave               : in std_logic;
	-- execute               : in std_logic;
    seven_seg_out1         : out std_logic_vector (6 downto 0);
    seven_seg_out2         : out std_logic_vector (6 downto 0);
    seven_seg_out3         : out std_logic_vector (6 downto 0)
);
end entity toplev;

architecture arch of toplev is
--datain and dataout removed from 8 bit
signal rezsig, switchsig : std_logic_vector(7 downto 0) := (others => '0');
signal ones, tens, hundreds : std_logic_vector(3 downto 0) := (others => '0');
signal result_padded : std_logic_vector(11 downto 0) := (others => '0');
--signal exsig, savesig,recallsig: std_logic;

component alu2bitoper is
	port(
	a           : in std_logic_vector(7 downto 0);
	b           : in std_logic_vector(7 downto 0);
	oper        : in std_logic_vector(1 downto 0);
	result      : out std_logic_vector(7 downto 0)
		);
	end component;
	
-- component memory is
  -- port (
    -- clk               : in std_logic;
    -- we                : in std_logic;
    -- addr              : in std_logic_vector(addr_width - 1 downto 0);
    -- din               : in std_logic_vector(data_width - 1 downto 0);
    -- dout              : out std_logic_vector(data_width - 1 downto 0)
  -- );
-- end component;

-- component state_machine is 
  -- port (
    -- clk               : in std_logic;
    -- reset             : in std_logic;
    -- execute           : in std_logic;
    -- memsave           : in std_logic;
    -- memrecall         : in std_logic;
    -- we                : out std_logic
    -- address           : out std_logic_vector(1 downto 0)
  -- );
  
--end component;


-- component rising_edge_synchronizer is 
  -- port (
    -- clk               : in std_logic;
    -- reset             : in std_logic;
    -- input             : in std_logic;
    -- edge              : out std_logic
  -- );
-- end component;

component seven_seg is 
    port(inputs  : in std_logic_vector (3 downto 0);
        clk     : in std_logic;
        reset   : in std_logic;
        hex0 : out std_logic_vector (6 downto 0)
        );
        end component;
  
 begin
	-- mem: memory 
		-- port map(
			-- clk => clk,
			-- we => wesig,
			-- addr => addr,
			-- din => datain,
			-- dout => dataout);
	
	-- controlun:state_machine
		-- port map(
			-- clk => clk,
			-- we => wesig,
			-- address => addr,
			-- execute => execute,
			-- memrecall => memrecall,
			-- memsave => memsave,
			-- we => wesig
			-- );
  
  
    ssd1: seven_seg
		port map(
			inputs => hundreds, 
			clk => clk,
			reset => reset,
			hex0 => seven_seg_out1
        );
	ssd2: seven_seg
		port map(
			inputs => tens, 
			clk => clk,
			reset => reset,
			hex0 => seven_seg_out2
        );
	ssd3: seven_seg
		port map(
			inputs => ones, 
			clk => clk,
			reset => reset,
			hex0 => seven_seg_out3
        );
	alu:alu2bitoper
		port map(
			a => rezsig,
			b => switches,
			oper => op,
			result => rezsig
			);
	sumreg : process (reset,clk)
	begin
	if reset = '1' then
		rezsig <= (others => '0');
		--datain <= (others => '0');
		--dataout <= (others => '0');
		-- exsig <= (others => '0');
		-- savesig <= (others => '0');
		-- recallsig <= (others => '0');
		switchsig <= (others => '0');
		--enable <= (others => '0');
		--wesig <= (others => '0');
		--addr <= (others => '0');
		--switchsig <= (others => '0');

		
	elsif rising_edge(clk) then
	--synchornize inputs
		switchsig <= switches;
		--exsig <= execute;
		--savesig <= memsave;
		--recallsig <= memrecall;
		--datain <= rezsig;
	end if;
end process;

bcd: process(result_padded)
  -- temporary variable
  variable temp : STD_LOGIC_VECTOR (11 downto 0);
  
  -- variable to store the output BCD number
  -- organized as follows
  -- thousands = bcd(15 downto 12)
  -- hundreds = bcd(11 downto 8)
  -- tens = bcd(7 downto 4)
  -- units = bcd(3 downto 0)
  variable bcd : UNSIGNED (15 downto 0) := (others => '0');

  -- by
  -- https://en.wikipedia.org/wiki/Double_dabble
  
  begin
    -- zero the bcd variable
    bcd := (others => '0');
    -- read input into temp variable
    temp(11 downto 0) := result_padded;
    
    -- cycle 12 times as we have 12 input bits
    -- this could be optimized, we dont need to check and add 3 for the 
    -- first 3 iterations as the number can never be >4
    for i in 0 to 11 loop
      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      if bcd(11 downto 8) > 4 then  
        bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;

      -- thousands can't be >4 for a 12-bit input number
      -- so don't need to do anything to upper 4 bits of bcd
    
      -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
      bcd := bcd(14 downto 0) & temp(11);
    
      -- shift temp left by 1 bit
      temp := temp(10 downto 0) & '0';
    
    end loop;
 
    -- set outputs
    ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
    tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
    hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
    --thousands <= STD_LOGIC_VECTOR(bcd(15 downto 12));
  end process bcd; 

result_padded <= "0000" & rezsig;
end arch;
	
		