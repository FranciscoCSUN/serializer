library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity serializer is
	port( 
		din : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		clk : in STD_LOGIC;
		serialout : out STD_LOGIC
		);
end entity serializer;

architecture Behavioral of serializer is
	signal counter : integer := 0;
	signal buf : STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
	
	buf <= din when counter = 0 else buf;

	serialout <= din(counter);

	process(clk) begin
		if rising_edge(clk) then
			counter <= (counter + 1) mod buf'LENGTH;
		end if;
	end process;

	
end architecture Behavioral;