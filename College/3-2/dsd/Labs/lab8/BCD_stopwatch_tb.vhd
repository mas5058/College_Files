--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*********  Copyright 2010, Rochester Institute of Technology  ***************
--*****************************************************************************
--
--  DESIGNER NAME:  Jeanne
--
--       LAB NAME:  Counters and Timers with VHDL II
--
--      FILE NAME:  bcd_stopwatch_tb
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This test bench will provide input to test the implemention of the 
--    3-digit BCD counter. The pushbutton switch KEY0 is used to reset 
--    the counter to 0. The contents of the counter are displayed on 
--    the 7-segment displays, HEX2-0 which are verified via an assert statement.
--
--    This testbench puts the stopwatch in the test mode (100 ns) so the output
--    will change every 5 clock cycles. It is impossible to test the other modes 
--    of operation due to the high number of clock pulses required to change the 
--    output.
--
--    After counting is verified. The pushbutton stop input is tested.
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 03/29/15 | JWC  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY bcd_stopwatch_tb IS
END bcd_stopwatch_tb;


ARCHITECTURE test OF bcd_stopwatch_tb IS

   -- Component Declaration for the Unit Under Test (UUT)
   -- if you use a package with the component defined then you do not need this
   COMPONENT BCD_stopwatch
      PORT (
	     pushb, clk, reset_n : IN  std_logic;
       S                   : IN std_logic_vector(1 downto 0);
         --
         test        : OUT std_logic;
         hex0        : OUT std_logic_vector(6 DOWNTO 0);
         hex1        : OUT std_logic_vector(6 DOWNTO 0);
         hex2        : OUT std_logic_vector(6 DOWNTO 0)
         );
   END COMPONENT;

   -- define signals for component ports
   -- Inputs
   SIGNAL clk_tb    : std_logic := '0';
   SIGNAL reset_n_tb : std_logic := '0';
   signal pushb_tb   : std_logic := '1';
   signal S_tb       : std_logic_vector(1 downto 0) := "11";
   --
   -- Outputs
   signal test_tb     : std_logic;
   SIGNAL hex0        : std_logic_vector(6 DOWNTO 0);
   SIGNAL hex1        : std_logic_vector(6 DOWNTO 0);
   SIGNAL hex2        : std_logic_vector(6 DOWNTO 0);
   

   -- signals for test bench control
   SIGNAL sim_done : boolean := false;
   SIGNAL PERIOD_c : time    := 20 ns;  -- 50MHz
	
	--signals for self-checking purposes
  SIGNAL  checksum : integer;
  SIGNAL ones, tens, hundreds : integer;

BEGIN  -- test

   -- component instantiation
   UUT : BCD_stopwatch
      PORT MAP (
	     pushb  => pushb_tb,
         clk    => clk_tb,
         reset_n => reset_n_tb,
		 S       => S_tb,
         --
		 test        => test_tb,
         hex0        => hex0,
         hex1        => hex1,
         hex2        => hex2
         );

   -- This creates an clock_50 that will shut off at the end of the Simulation
   -- this makes a clock_50 that you can shut off when you are done.
   clk_tb <= NOT clk_tb AFTER PERIOD_C/2 WHEN (NOT sim_done) ELSE '0';


   ---------------------------------------------------------------------------
   -- NAME: Stimulus
   --
   -- DESCRIPTION:
   --    This process will apply stimulus to the UUT.
   ---------------------------------------------------------------------------
   stimulus : PROCESS
   
   BEGIN
      -- de-assert all inputs except the reset which is asserted
      reset_n_tb <= '0';
      WAIT FOR 5 ns;

      -- now lets sync the stimulus to the clock_50
      -- move stimulus 1ns after clock edge
      WAIT UNTIL clk_tb = '1';

      -- de-assert reset 
      reset_n_tb <= '1';
		-- allow the BCD counter to count to max value
		-- convert the hex outputs back to BDC digits
		--convert the BCD digits to an integer number
		--compare the number against the loop counter
		for i in 0 to 999 loop
		   wait for 5*PERIOD_C;
			 assert i = checksum
			 report "count is wrong. Is should be " & integer'image(i) & CR
			 severity error;
		end loop;   
		wait for 5*PERIOD_C;
      -- now test pushb for stop
	  	reset_n_tb <= '0';   --reset
		wait for 2*PERIOD_C;
		reset_n_tb <= '1';
		for i in 0 to 10 loop
		   wait for 5*PERIOD_C;
			 assert i = checksum
			 report "count is wrong. Is should be " & integer'image(i) & CR
			 severity error;
		end loop;  
	
		pushb_tb <= '0';
		wait for 20*PERIOD_C;  --output should not change
			assert checksum = 10
			report "count is wrong. Is should be 10"  & CR
			severity error;
      -- shutting down simulation
      sim_done <= true;
      WAIT FOR PERIOD_c*1;

      -----------------------------------------------------------------------
      -- This Last WAIT statement needs to be here to prevent the PROCESS
      -- sequence from re starting.
      -----------------------------------------------------------------------
      WAIT;
   END PROCESS stimulus;

	--------------------------------------------------------------------------
	-- the following three processes take the seven segment display values that 
	-- the UUT output and converts them to the corresponding BCD digit (0-9)
	-- the bcd digits are then converted to an integer value
	--------------------------------------------------------------------------
   checksum <= (hundreds * 100) + (10*tens) + ones;
   process (hex2) is
		begin
			case(hex2) is
				when  "1000000" => hundreds <= 0;
				when  "1111001" => hundreds <= 1;
				when  "0100100" => hundreds <= 2;
				when  "0110000" => hundreds <= 3;
				when  "0011001" => hundreds <= 4;
				when  "0010010" => hundreds <= 5;
				when  "0000010" => hundreds <= 6;
				when  "1111000" => hundreds <= 7;
				when  "0000000" => hundreds <= 8;
				when others => hundreds <= 9;
			end case;
		end process;
   process (hex1) is
		begin
			case(hex1) is
				when  "1000000" => tens <= 0;
				when  "1111001" => tens <= 1;
				when  "0100100" => tens <= 2;
				when  "0110000" => tens <= 3;
				when  "0011001" => tens <= 4;
				when  "0010010" => tens <= 5;
				when  "0000010" => tens <= 6;
				when  "1111000" => tens <= 7;
				when  "0000000" => tens <= 8;
				when others => tens <= 9; 
			end case;
		end process;
   process (hex0) is
		begin
			case(hex0) is
			 	when  "1000000" => ones <= 0;
				when  "1111001" => ones <= 1;
				when  "0100100" => ones <= 2;
				when  "0110000" => ones <= 3;
				when  "0011001" => ones <= 4;
				when  "0010010" => ones <= 5;
				when  "0000010" => ones <= 6;
				when  "1111000" => ones <= 7;
				when  "0000000" => ones <= 8;
				when others => ones <= 9; 
			end case;
		end process;

END test;
