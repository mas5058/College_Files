--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*********  Copyright 2011, Rochester Institute of Technology  ***************
--*****************************************************************************
--
--  DESIGNER NAME:  Jeanne Christman
--
--       LAB NAME:  Full_ALU
--
--      FILE NAME:  Full_ALU_tb.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This test bench will provide input to test an eight function ALU.
--    The ALU function will accept two 4-bit numbers and a 3-bit selection
--    signal that will enable the operations in the table below.  The output
--    will be displayed on three seven segment displays.  For operations 4-7
--    (logical) the display is a 2-digit hexidecimal number. For operations
--    0-3 (arithmetic) the display is a signed decimal number. Z is the zero 
--    indicator. 
--     
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 3/3/14   | JWC  | 1.0 | Created
-- | 3/9/16   | RJK  | 1.1 | Added self-checking features
-- | 3/13/16  | RJK  | 1.2 | Fixed syntax error at line 159; missing BEGIN.
--
--*****************************************************************************
--*****************************************************************************

LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;            

ENTITY Full_ALU_tb IS
END ENTITY Full_ALU_tb;

ARCHITECTURE test OF Full_ALU_tb IS

--the component name MUST match the entity name of the VHDL module being tested   
    COMPONENT Full_ALU  
        PORT ( A                : in   STD_LOGIC_VECTOR(3 downto 0); --A input
               B                : in   STD_LOGIC_VECTOR(3 downto 0); --B input
               Sel              : in   STD_LOGIC_VECTOR(2 downto 0); --Selects operation
               hex0,hex1, hex2  : out  STD_LOGIC_VECTOR(6 downto 0); --hex displays
               Z                : out  STD_LOGIC                     --Zero indicator     
             );
    END COMPONENT;

	constant ZERO:  std_logic_vector(6 downto 0) := "1000000";
	constant ONE:   std_logic_vector(6 downto 0) := "1111001";
	constant TWO:   std_logic_vector(6 downto 0) := "0100100";
	constant THREE: std_logic_vector(6 downto 0) := "0110000";
	constant FOUR:  std_logic_vector(6 downto 0) := "0011001";
	constant FIVE:  std_logic_vector(6 downto 0) := "0010010";
	constant SIX:   std_logic_vector(6 downto 0) := "0000010"; 
	constant SEVEN: std_logic_vector(6 downto 0) := "1111000";
	constant EIGHT: std_logic_vector(6 downto 0) := "0000000";
	constant NINE:  std_logic_vector(6 downto 0) := "0010000";
	constant A:     std_logic_vector(6 downto 0) := "0001000";
	constant B:     std_logic_vector(6 downto 0) := "0000011";
	constant C:     std_logic_vector(6 downto 0) := "1000110"; 
	constant D:     std_logic_vector(6 downto 0) := "0100001";
	constant E:     std_logic_vector(6 downto 0) := "0000110";
	constant F:     std_logic_vector(6 downto 0) := "0001110";
	constant DASH:  std_logic_vector(6 downto 0) := "0111111";
	constant blank: std_logic_vector(6 downto 0) := "1111111";

    TYPE ssd_array_type IS ARRAY (0 TO 17) OF std_logic_vector(6 downto 0);
    CONSTANT ssd_array_C : ssd_array_type:= (
        ZERO,  ONE,  TWO, THREE, FOUR, FIVE, SIX, SEVEN,
        EIGHT, NINE, A,   B,     C,    D,    E,   F,   
        DASH,  blank );

    -- testbench signals.  These do not need to be modified
    SIGNAL a_tb          : std_logic_vector(3 DOWNTO 0);
    SIGNAL b_tb          : std_logic_vector(3 DOWNTO 0);
    SIGNAL Sel_tb        : std_logic_vector(2 downto 0);
    --
    SIGNAL hex0_tb       : std_logic_vector(6 DOWNTO 0);
    SIGNAL hex1_tb       : std_logic_vector(6 DOWNTO 0);
    SIGNAL hex2_tb       : std_logic_vector(6 DOWNTO 0);
    SIGNAL Z_tb          : std_logic;

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
    UUT : Full_ALU PORT MAP (  
        a           => a_tb,
        b           => b_tb,
        sel         => sel_tb,
        hex0        => hex0_tb,
        hex1        => hex1_tb,
        hex2        => hex2_tb,
        Z           => z_tb
        );

    ---------------------------------------------------------------------------
    -- NAME: Stimulus
    --
    -- DESCRIPTION:
    --    This process will apply the stimulus to the UUT
    ---------------------------------------------------------------------------
    stimulus : PROCESS
        VARIABLE temp_slv_4b      : STD_LOGIC_VECTOR(3 DOWNTO 0);
        VARIABLE temp_signed_8b   : SIGNED(7 DOWNTO 0);
        VARIABLE ones_dig : INTEGER;
        VARIABLE tens_dig : INTEGER;

        PROCEDURE check_hex(temp_slv_4b : IN STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
        BEGIN
        ASSERT HEX2_tb = BLANK
                REPORT "HEX2 Incorrect. Should be Blank" & LF SEVERITY ERROR;
            ASSERT HEX1_tb = ZERO
                REPORT "HEX1 Incorrect. Should be Zero" & LF SEVERITY ERROR;
            ASSERT HEX0_tb = ssd_array_C(to_integer(unsigned(temp_slv_4b)))
                REPORT "HEX0 Incorrect. Should be "&hstr(temp_slv_4b) & LF SEVERITY ERROR;
        END PROCEDURE;

        PROCEDURE check_dec(temp_signed_8b : IN SIGNED(7 DOWNTO 0)) IS
            VARIABLE ones_dig : INTEGER;
            VARIABLE tens_dig : INTEGER;
        BEGIN
            tens_dig := abs(to_integer(temp_signed_8b  /  10));
            ones_dig := abs(to_integer(temp_signed_8b rem 10));
            -- Only check in the range of 2 digits plus sign bit
            IF temp_signed_8b < 100 THEN
                IF temp_signed_8b < 0 THEN
                    ASSERT HEX2_tb = DASH
                        REPORT "HEX2 Incorrect. Should be Dash" & LF SEVERITY ERROR;
                ELSE
                    ASSERT HEX2_tb = BLANK
                        REPORT "HEX2 Incorrect. Should be Blank" & LF SEVERITY ERROR;
                END IF;
                ASSERT HEX1_tb = ssd_array_C(tens_dig)
                    REPORT "HEX1 Incorrect. Should be "& integer'image(tens_dig) & LF SEVERITY ERROR;
                ASSERT HEX0_tb = ssd_array_C(ones_dig)
                    REPORT "HEX0 Incorrect. Should be "& integer'image(ones_dig) & LF SEVERITY ERROR;
             END IF;
         END PROCEDURE;


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
                    temp_slv_4b      := x"0";
                    temp_signed_8b   := x"00";
                    
                    Case k is
                      WHEN 4 =>
                        temp_slv_4b := a_tb AND b_tb;
                        check_hex(temp_slv_4b);
                      
                      WHEN 5 =>
                        temp_slv_4b := a_tb OR b_tb;
                        check_hex(temp_slv_4b);
                    
                      WHEN 6 =>
                        temp_slv_4b := a_tb XOR b_tb;
                        check_hex(temp_slv_4b);
                    
                      WHEN 7 =>
                        temp_slv_4b := NOT a_tb;
                        check_hex(temp_slv_4b);
                           
                      WHEN 0 =>
                        temp_signed_8b := resize(SIGNED(a_tb),temp_signed_8b'LENGTH) + resize(SIGNED(b_tb),temp_signed_8b'LENGTH);
                        check_dec(temp_signed_8b);

                      WHEN 1 =>
                        temp_signed_8b := resize(SIGNED(a_tb),temp_signed_8b'LENGTH) - resize(SIGNED(b_tb),temp_signed_8b'LENGTH);
                        check_dec(temp_signed_8b);

                      WHEN 2 =>
                        temp_signed_8b := resize(SIGNED(a_tb) * SIGNED(b_tb),temp_signed_8b'LENGTH);
                        check_dec(temp_signed_8b);

                      WHEN 3 =>
                        temp_signed_8b := RESIZE(SIGNED(NOT a_tb) + 1,temp_signed_8b'LENGTH);
                        check_dec(temp_signed_8b);

                      WHEN OTHERS => NULL;
                    END CASE;  
                    
                    IF temp_slv_4b = x"0" AND temp_signed_8b = x"00" THEN
                      ASSERT z_tb = '1'
                        REPORT LF& "Incorrect Z Flag Response" SEVERITY error;
                    END IF;

                END LOOP;
            END LOOP;
        END LOOP;

        -----------------------------------------------------------------------
        -- This last WAIT statement needs to be here to prevent the PROCESS
        -- sequence from restarting.
        -----------------------------------------------------------------------
        Report LF& "**************************" &LF&
                   "Simulation Complete" &LF&
                   "**************************" SEVERITY NOTE;
        WAIT;
    END PROCESS stimulus;


END ARCHITECTURE test;
