--*************************** VHDL Source Code******************************

--********* Copyright 2016, Rochester Institute of Technology***************

--***************************************************************************

--

-- DESIGNER NAME: Michael Sarlo

--

-- LAB NAME: JK Latch

--

-- FILE NAME: hw6.vhd

--

-------------------------------------------------------------------------------

--

-- DESCRIPTION

--

-- This design will .

--

--

-------------------------------------------------------------------------------

--

-- REVISION HISTORY

--

-- _______________________________________________________________________

-- | 3/16/16 | Michael Sarlo | 1.0 | Description |

-- |==========+======+=====+================================================

-- | | | |

-- | 11/23/03 | XXX | 1.0 | Created

-- | | | |

--

--***************************************************************************

--***************************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity hw6 is
	port (clk, resetn : in std_logic;
		  j, k        : in std_logic;
		  q, qn       : out std_logic);
	end hw6;

architecture arch of hw6 is 

	signal sq : std_logic; 
	signal inputs : std_logic_vector(1 downto 0);
	begin
	
	inputs <= j & k;
	process(clk,inputs, resetn)
	begin
	if(clk'event and clk = '1') then 
		--q <= (j and (qbar)) or ((not k) and sq);
	--end if;
	--end process;
	--process (j,k)
		if (resetn = '0') then
			sq <= '0';
			--qn <= '1';
		else
		case (inputs) is
			when "01" => sq <= '0';
			when "10" => sq <= '1';
			when "11" => sq <= (not sq);
			when others => sq <= sq;
		end case;
		end if;
		
--	case (j,k) is
--		when "01" => qbar <= '1';
--		when "10" => qbar <= '0';
--		when "11" => qbar <= (not qbar);
--		when others => qbar <= qbar;
--	end case;
	end if;
	end process;
	q <= sq;
	qn <= not sq;
	--q <= sq;
	--qn <= qbar;
	end arch;

	--sq <= (qbar nand (j nand qbar nand not clk);
	-- qbar <= (sq nand (k nand sq nand not clk);
	-- q <= sq;
	-- qn <= qbar;
	
	-- component srlatch
	-- port (s, r, e  : in std_logic
		  -- q, qn  : out std_logic);
	-- end component;
	
	-- begin
	
	-- parent: srlatch
		-- port map()
	
	-- child : srlatch
		-- port map(
				-- q => q
				-- q => qn);
	-- if clk = '0' then
		-- inputs <= j & k;
		-- case (inputs) is
			-- when "00" => 
			-- when "01" =>
			-- when "10" =>
			-- when others =>
		-- end case;
		-- qn <= (not sq);
		-- q <= sq;
		-- end if;
		-- end arch;