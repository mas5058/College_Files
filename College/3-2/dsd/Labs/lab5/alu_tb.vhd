--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*********  Copyright 2011, Rochester Institute of Technology  ***************
--*****************************************************************************
--
--  DESIGNER NAME:  Jeanne Christman
--
--       LAB NAME:  ALU
--
--      FILE NAME:  ALU_tb.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This test bench will provide input to test an eight function ALU.
--    The ALU function will accept two 4-bit numbers and a 3-bit selection
--    signal that will enable the operations in the table below.  The outputs R
--    is the 8 bit result and Z is one bit indicating that the result is 0 
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 9/23/13  | JWC  | 1.0 | Created
-- | 3/12/14  | RJK  | 1.1 | Added self-checking capability
-- | 2/20/15  | RJK  | 1.2 | Fixed many bugs
-- | 2/23/15  | RJK  | 1.3 | Mod for Invert operation to agree with lecture.
-- | 1/19/16  | JWC  | 1.4 | Changed the operation select values from previous version
--
--*****************************************************************************
--*****************************************************************************

LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;            
--USE work.txt_util.all;

ENTITY alu_tb IS
END ENTITY alu_tb;

ARCHITECTURE test OF alu_tb IS

--the component name MUST match the entity name of the VHDL module being tested   
    COMPONENT lab5  
        PORT ( A  : in   STD_LOGIC_VECTOR(3 downto 0);                  --A input
               B  : in   STD_LOGIC_VECTOR(3 downto 0);                  --B input
               oper  : in   STD_LOGIC_VECTOR(2 downto 0);                  --Selects operation
               result  : out  STD_LOGIC_VECTOR(7 downto 0);                  --result
               Z  : out  STD_LOGIC                                      --Zero indicator     
             );
    END COMPONENT;


    -- testbench signals.  These do not need to be modified
    SIGNAL a_tb          : std_logic_vector(3 DOWNTO 0);
    SIGNAL b_tb          : std_logic_vector(3 DOWNTO 0);
    SIGNAL Sel_tb        : std_logic_vector(2 downto 0);
    --
    SIGNAL R_tb          : std_logic_vector(7 DOWNTO 0);
    SIGNAL Z_tb          : std_logic;

    -- converts a std_logic_vector into a hex string. Taken from txt_util package. Package obtained from http://www.stefanvhdl.com/
   function hstr(slv: std_logic_vector) return string is
       variable hexlen: integer;
       variable longslv : std_logic_vector(67 downto 0) := (others => '0');
       variable hex : string(1 to 16);
       variable fourbit : std_logic_vector(3 downto 0);
     begin
       hexlen := (slv'left+1)/4;
       if (slv'left+1) mod 4 /= 0 then
         hexlen := hexlen + 1;
       end if;
       longslv(slv'left downto 0) := slv;
       for i in (hexlen -1) downto 0 loop
         fourbit := longslv(((i*4)+3) downto (i*4));
         case fourbit is
           when "0000" => hex(hexlen -I) := '0';
           when "0001" => hex(hexlen -I) := '1';
           when "0010" => hex(hexlen -I) := '2';
           when "0011" => hex(hexlen -I) := '3';
           when "0100" => hex(hexlen -I) := '4';
           when "0101" => hex(hexlen -I) := '5';
           when "0110" => hex(hexlen -I) := '6';
           when "0111" => hex(hexlen -I) := '7';
           when "1000" => hex(hexlen -I) := '8';
           when "1001" => hex(hexlen -I) := '9';
           when "1010" => hex(hexlen -I) := 'A';
           when "1011" => hex(hexlen -I) := 'B';
           when "1100" => hex(hexlen -I) := 'C';
           when "1101" => hex(hexlen -I) := 'D';
           when "1110" => hex(hexlen -I) := 'E';
           when "1111" => hex(hexlen -I) := 'F';
           when "ZZZZ" => hex(hexlen -I) := 'z';
           when "UUUU" => hex(hexlen -I) := 'u';
           when "XXXX" => hex(hexlen -I) := 'x';
           when others => hex(hexlen -I) := '?';
         end case;
       end loop;
       return hex(1 to hexlen);
     end hstr;
   
BEGIN
--this must match component above
    UUT : lab5 PORT MAP (  
        a => a_tb,
        b => b_tb,
        oper => sel_tb,
        result => R_tb,
        Z => z_tb
        );

    ---------------------------------------------------------------------------
    -- NAME: Stimulus
    --
    -- DESCRIPTION:
    --    This process will apply the stimulus to the UUT
    ---------------------------------------------------------------------------
    stimulus : PROCESS
      VARIABLE temp_slv_8b : STD_LOGIC_VECTOR(7 DOWNTO 0);
      VARIABLE temp_signed_8b : SIGNED(7 DOWNTO 0);
      VARIABLE temp_unsigned_8b : UNSIGNED(7 DOWNTO 0);
    BEGIN
            -- create 3 loops to run through all the combinations of
            -- a and b numbers for each operation
      FOR k in 0 to 7 Loop
        sel_tb <= std_logic_vector(to_unsigned(k,3));
        FOR i IN 0 TO 15 LOOP
          a_tb <= std_logic_vector(to_unsigned(i,4));
            FOR j IN 0 TO 15 LOOP
              b_tb <= std_logic_vector(to_unsigned(j,4));
              WAIT FOR 10 ns;
              IF r_tb = x"00" THEN
                ASSERT z_tb = '1'
                  REPORT LF& "Incorrect Z Flag Response" SEVERITY error;
              END IF;
              
              Case k is
                WHEN 4 =>
                  temp_slv_8b := x"0" & (a_tb AND b_tb);
                  ASSERT r_tb = temp_slv_8b
                    REPORT "AND operation failed. "&LF&
                           "A="&hstr(a_tb)&", B="&hstr(b_tb)&", R="&hstr(r_tb) &LF&
                           "Result should be "&hstr(temp_slv_8b)
                      SEVERITY error;
                
                WHEN 5 =>
                  temp_slv_8b := x"0" & (a_tb OR b_tb);
                  ASSERT r_tb = temp_slv_8b
                    REPORT "OR operation failed. "&LF&
                           "A="&hstr(a_tb)&", B="&hstr(b_tb)&", R="&hstr(r_tb) &LF&
                           "Result should be "&hstr(temp_slv_8b)
                      SEVERITY error;

                WHEN 6 =>
                  temp_slv_8b := x"0" & (a_tb XOR b_tb);
                  ASSERT r_tb = temp_slv_8b
                    REPORT "XOR operation failed. "&LF&
                           "A="&hstr(a_tb)&", B="&hstr(b_tb)&", R="&hstr(r_tb) &LF&
                           "Result should be "&hstr(temp_slv_8b)
                      SEVERITY error;


                WHEN 7 =>
                  temp_slv_8b := NOT (x"0" & a_tb);
                  ASSERT r_tb = temp_slv_8b
                    REPORT "NOT operation failed. "&LF&
                           "A="&hstr(a_tb)&", R="&hstr(r_tb) &LF&
                           "Result should be "&hstr(temp_slv_8b)
                      SEVERITY error;
                     
                WHEN 0 =>
                  temp_signed_8b := resize(SIGNED(a_tb),r_tb'LENGTH) + resize(SIGNED(b_tb),r_tb'LENGTH);
                  ASSERT r_tb = std_logic_vector(temp_signed_8b)
                   -- ASSERT r_tb = std_logic_vector(resize(SIGNED(a_tb) + SIGNED(b_tb),r_tb'LENGTH))
                   REPORT "Sum operation failed. "&LF&
                           "A="&integer'image(to_integer(signed(a_tb)))&", B="&integer'image(to_integer(signed(b_tb)))&", R="&integer'image(to_integer(signed(r_tb)))&LF&
                           "Result should be "& integer'image(to_integer(temp_signed_8b))
                      SEVERITY error;

                WHEN 1 =>
                  temp_signed_8b := resize(SIGNED(a_tb),r_tb'LENGTH) - resize(SIGNED(b_tb),r_tb'LENGTH);
                  ASSERT r_tb = std_logic_vector(temp_signed_8b)
                  -- ASSERT r_tb = std_logic_vector(resize(SIGNED(a_tb) - SIGNED(b_tb),r_tb'LENGTH))
                    REPORT "Difference operation failed. "&LF&
                           "A="&integer'image(to_integer(signed(a_tb)))&", B="&integer'image(to_integer(signed(b_tb)))&", R="&integer'image(to_integer(signed(r_tb)))&LF&
                           "Result should be "& integer'image(to_integer(temp_signed_8b))
                      SEVERITY error;

                WHEN 2 =>
                  temp_signed_8b := resize(SIGNED(a_tb) * SIGNED(b_tb),r_tb'LENGTH);
                  ASSERT r_tb = std_logic_vector(temp_signed_8b)
                  -- ASSERT r_tb = std_logic_vector(resize(SIGNED(a_tb) * SIGNED(b_tb),r_tb'LENGTH))
                    REPORT "Multiply operation failed. "&LF&
                           "A="&integer'image(to_integer(signed(a_tb)))&", B="&integer'image(to_integer(signed(b_tb)))&", R="&integer'image(to_integer(signed(r_tb)))&LF&
                           "Result should be "& integer'image(to_integer(temp_signed_8b))
                      SEVERITY error;

                WHEN 3 =>
                  temp_signed_8b := RESIZE(SIGNED(NOT a_tb) + 1,temp_signed_8b'LENGTH);
                  ASSERT r_tb = std_logic_vector(temp_signed_8b)
                    REPORT "Two's Complement operation failed. "&LF&
                           "A=0x"&hstr(a_tb)&", R=0x"&hstr(r_tb) &LF&
                           "Result should be "& integer'image(to_integer(temp_signed_8b))
                      SEVERITY error;
                  IF j = 0 THEN EXIT; END IF;

                WHEN OTHERS => NULL;
              END CASE;  
            END LOOP;
          END LOOP;
        END LOOP;

        REPORT LF&"Simulation Completed" Severity Note;
        -----------------------------------------------------------------------
        -- This last WAIT statement needs to be here to prevent the PROCESS
        -- sequence from restarting.
        -----------------------------------------------------------------------
        WAIT;
    END PROCESS stimulus;


END ARCHITECTURE test;
