--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*********  Copyright 2010, Rochester Institute of Technology  ***************
--*****************************************************************************
--
--  DESIGNER NAME:  Jeanne Christman
--
--       LAB NAME:  encryption receiver
--
--      FILE NAME:  receiver_tb.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This test bench will provide input to test the encryption receiver
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 11/13/13 | JWC  | 1.0 | original 
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;           -- need for conv_std_logic_vector
USE ieee.std_logic_unsigned.ALL;        -- need for "+"


ENTITY receiver_tb IS
END receiver_tb;


ARCHITECTURE test OF receiver_tb IS

   -- Component Declaration for the Unit Under Test (UUT)
   -- if you use a package with the component defined then you do not need this
component receiver is 
PORT ( CLOCK_50         		 : IN std_logic;
       SW               		 : IN std_logic_vector(17 downto 0);
		 KEY               		 : IN std_logic_vector(2 downto 0);
		 HEX0,HEX1,HEX2,HEX3     : OUT std_logic_vector(6 downto 0);
		 GPIO_1                  : IN   std_logic);
		 --LEDR                    : OUT std_logic_vector(15 downto 0));
END component;

   -- define signals for component ports
   SIGNAL clock_50        : std_logic                    := '0';
   SIGNAL sys_reset_n     : std_logic                    := '0';
   SIGNAL key1            : std_logic                    := '1';
   SIGNAL key2            : std_logic                    := '1';
   SIGNAL switches        : std_logic_vector(17 DOWNTO 0) := "000000000000000000";
   SIGNAL data            : std_logic     := '1';
   -- Outputs
   SIGNAL hex0   : std_logic_vector(6 DOWNTO 0);
   SIGNAL hex1   : std_logic_vector(6 DOWNTO 0);
   SIGNAL hex2   : std_logic_vector(6 DOWNTO 0);
   SIGNAL hex3   : std_logic_vector(6 DOWNTO 0);

   -- signals for test bench control
   SIGNAL sim_done : boolean := false;
   SIGNAL PERIOD_c : time    := 20 ns;  -- 50MHz

BEGIN  -- test

   -- component instantiation
   UUT : receiver
      PORT MAP (
         clock_50           => clock_50,
         key(0)        => sys_reset_n,
         key(1)          => key1,
		 key(2)          => key2,
         SW              => switches,
         --
         hex0            => hex0,
         hex1            => hex1,
         hex2            => hex2,
         hex3            => hex3,
		 GPIO_1          => data 
         );

   -- This creates an clock_50 that will shut off at the end of the Simulation
   -- this makes a clock_50 that you can shut off when you are done.
   clock_50 <= NOT clock_50 AFTER PERIOD_C/2 WHEN (NOT sim_done) ELSE '0';


   ---------------------------------------------------------------------------
   -- NAME: Stimulus
   --
   -- DESCRIPTION:
   --    This process will apply stimulus to the UUT.
   ---------------------------------------------------------------------------
   stimulus : PROCESS
   BEGIN
      -- de-assert all input except the reset which is asserted
      sys_reset_n     <= '0';
      --key1            <= '1';
	  key2            <= '1';
      switches(15 downto 0)        <= x"FFFF";
	  switches(17) <= '1';

      -- now lets sync the stimulus to the clock_50
      -- move stimulus 1ns after clock edge
      WAIT UNTIL clock_50 = '1';
      WAIT FOR 1 ns;
      WAIT FOR PERIOD_c*2;

      -- de-assert reset
      sys_reset_n <= '1';
      WAIT FOR PERIOD_c*2;

      WAIT FOR PERIOD_c*100;
      key2 <= '0';
      WAIT FOR PERIOD_c*10;
	  key2 <= '1';
      WAIT FOR PERIOD_c*100;
      data <= '0';
	  wait for PERIOD_c*50;
      for i in 0 to 15 loop
	      data <= not(data);
		  wait for PERIOD_c*50;
	  end loop;
	  data <= '1';
	  wait for PERIOD_c*50;
	  switches(17) <= '0';
	  wait for PERIOD_c *30;

      sim_done <= true;
      WAIT FOR PERIOD_c*1;

      -----------------------------------------------------------------------
      -- This Last WAIT statement needs to be here to prevent the PROCESS
      -- sequence from re starting.
      -----------------------------------------------------------------------
      WAIT;

   END PROCESS stimulus;



END test;
