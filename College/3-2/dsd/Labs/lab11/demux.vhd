entity demux
	port(switches : in std_logic_vector(15 downto 0);
		  demux1, demux2 : out std_logic_vector(15 downto 0));
end demux

architecture arch of demux is