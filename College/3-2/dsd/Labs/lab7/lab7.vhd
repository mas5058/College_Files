library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity lab7 is
	port (x, y : in std_logic_vector(3 downto 0);
		  sel  : in std_logic_vector (2 downto 0);
		  h0, h1, h2 : out std_logic_vector(6 downto 0);
		  Z         : out std_logic);
	end lab7;

architecture arch of lab7 is
	signal rez : std_logic_vector(7 downto 0);
	signal hhex0, hhex1, hhex2, dhex0, dhex1, dhex2 : std_logic_vector (6 downto 0);
	signal tens, ones : std_logic_vector(6 downto 0);
	signal absr : std_logic_vector(6 downto 0);


	
	component bcd is 
	port(inputs  : in std_logic_vector (7 downto 0);
		  s       : in std_logic;
		 hex0, hex1, hex2 : out std_logic_vector (6 downto 0)
		 );
		 end component;
	
	component alu is 
	port (a,b : in std_logic_vector (3 downto 0);
		  oper : in std_logic_vector(2 downto 0);
		  result    : out std_logic_vector(7 downto 0);
		  z         : out std_logic
	);
	end component;
	begin
	alu1 : alu port map (
		a => x,
		b => y,
		oper => sel,
		result => rez,
		z => Z);

	bcd1 : bcd port map (
		inputs => rez,
		s => sel(2),
		hex0 => h0,
		hex1 => h1,
		hex2 => h2); 
	end arch;
--	signedx <= x(3) & x(3) & x(3) & x(3) & x;
--	signedy <= y(3) & y(3) & y(3) & y(3) & y;
--	unsignedx <= "0000" & x;
--	unsignedy <= "0000" & y;
--	--result <= rez;
--	
--	pro1:process (sel, rez)
--	begin
--	case sel is
--		when "000" => rez <= signedx + signedy;
--		when "001" => rez <= signedx - signedy;
--		when "010" => rez <= (x * y);
--		when "011" => rez <= (not signedx) + '1';
--		when "100" => rez <= "0000" & (x and y);
--		when "101" => rez <= "0000" & (x or y);
--		when "110" => rez <= "0000" & (x xor y);
--		when "111" => rez <= "1111" & (not x);
--		when others => rez <= "00000000";
--		end case;
--	if (rez = "00000000") then
--	  Z <= '1';
--	 else
--	   Z <= '0';
--	 end if;
--		end process;
--	process(rez)
--	begin
--		case (rez(7 downto 4)) is
--			when "0000" => hhex1 <= (zero);
--			when "0001" => hhex1 <= (one);
--			when "0010" => hhex1 <= (two);
--			when "0011" => hhex1 <= (three);
--			when "0100" => hhex1 <= (four);
--			when "0101" => hhex1 <= (five);
--			when "0110" => hhex1 <= (six);
--			when "0111" => hhex1 <= (seven);
--			when "1000" => hhex1 <= (eight);
--			when "1001" => hhex1 <= (nine);
--			when "1010" => hhex1 <= (A);
--			when "1011" => hhex1 <= (b);
--			when "1100" => hhex1 <= (C);
--			when "1101" => hhex1 <= (d);
--			when "1110" => hhex1 <= (E);
--			when others => hhex1 <= (F);
--		end case;
--		
--		case (rez(3 downto 0)) is
--			when "0000" => hhex0 <= (zero);
--			when "0001" => hhex0 <= (one);
--			when "0010" => hhex0 <= (two);
--			when "0011" => hhex0 <= (three);
--			when "0100" => hhex0 <= (four);
--			when "0101" => hhex0 <= (five);
--			when "0110" => hhex0 <= (six);
--			when "0111" => hhex0 <= (seven);
--			when "1000" => hhex0 <= (eight);
--			when "1001" => hhex0 <= (nine);
--			when "1010" => hhex0 <= (A);
--			when "1011" => hhex0 <= (b);
--			when "1100" => hhex0 <= (C);
--			when "1101" => hhex0 <= (d);
--			when "1110" => hhex0 <= (E);
--			when others => hhex0 <= (F);
--		end case;
--		end process;
--		proc3:process (rez) 
--		begin
--		if (rez(7) = '0') then
--			absr <= rez(6) & rez(5) & rez(4) & rez(3) & rez(2) & rez(1) & rez(0);
--		else
--			absr <= (not (rez(6) & rez(5) & rez(4) & rez(3) & rez(2) & rez(1) & rez(0)) + '1');
--		end if;
--		end process;
--		proc4: process(absr, tens, dhex1)
--		begin
--			tens <= std_logic_vector(unsigned(absr)/10);
--			--same as process 1 and 2
--			case (tens (3 downto 0)) is
--			when "0000" => dhex1 <= zero;
--			when "0001" => dhex1 <= one;
--			when "0010" => dhex1 <= two;
--			when "0011" => dhex1 <= three;
--			when "0100" => dhex1 <= four;
--			when "0101" => dhex1 <= five;
--			when "0110" => dhex1 <= six;
--			when "0111" => dhex1 <= seven;
--			when "1000" => dhex1 <= eight;
--			when "1001" => dhex1 <= nine;
--			when "1010" => dhex1 <= A;
--			when "1011" => dhex1 <= b;
--			when "1100" => dhex1 <= C;
--			when "1101" => dhex1 <= D;
--			when "1110" => dhex1 <= E;
--			when others => dhex1 <= F;
--		end case;
--		end process;
--		proc5:process(absr, ones, dhex0)
--		begin
--			ones <= std_logic_vector(unsigned(absr) rem(10));
--			--same as process1 and 2
--			case (ones(3 downto 0)) is
--			when "0000" => dhex0 <= zero;
--			when "0001" => dhex0 <= one;
--			when "0010" => dhex0 <= two;
--			when "0011" => dhex0 <= three;
--			when "0100" => dhex0 <= four;
--			when "0101" => dhex0 <= five;
--			when "0110" => dhex0 <= six;
--			when "0111" => dhex0 <= seven;
--			when "1000" => dhex0 <= eight;
--			when "1001" => dhex0 <= nine;
--			when "1010" => dhex0 <= A;
--			when "1011" => dhex0 <= b;
--			when "1100" => dhex0 <= C;
--			when "1101" => dhex0 <= D;
--			when "1110" => dhex0 <= E;
--			when others => dhex0 <= F;
--		end case;
--		end process;
--	proc6:process(sel)
--		begin
--		if (sel(2) = '0') then
--			h1 <= hhex1;
--		else
--			h1 <= dhex1;
--		end if;
--		end process;
--	proc7:process(sel)
--	begin
--		if (sel(2) = '0') then
--			h0 <= hhex0;
--		else
--			h0 <= dhex0;
--		end if;
--		end process;
--	proc8:process(rez,sel)
--		begin
--			if (sel(2)  = '0') then
--				h2 <= "1111111";
--			else
--				if rez(7) = '1' then
--					if sel(2) = '1' then
--						h2 <= "1111110";
--					else
--						h2 <= "1111111";
--					end if;
--				else
--					h2 <= "1111111";
--			end if;
--			end if;
--		end process;
	--	end arch;
	