library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
	port (
		din: in STD_LOGIC_VECTOR(31 DOWNTO 0);
		clk: in STD_LOGIC;
		read_en: in STD_LOGIC;
		write_en: in STD_LOGIC;
		empty: out BOOLEAN;
		full: out BOOLEAN;
		sout: out STD_LOGIC
	);
end entity top;

architecture Behavioral of top is
	component serializer is
		port( 
			din: in STD_LOGIC_VECTOR(31 DOWNTO 0);
			clk: in STD_LOGIC;
			serialout: out STD_LOGIC
			);
	end component serializer;
	component fifo is
		port ( 
		    clk: IN STD_LOGIC;
		    read_en: IN STD_LOGIC;
		    write_en: IN STD_LOGIC;
		    din: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		    dout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		    empty: OUT BOOLEAN;
		    full: OUT BOOLEAN
		    );
	end component fifo;
	component clock_div is
    Port ( src_clk : in STD_LOGIC;
           factor : in INTEGER;
           new_clk : out STD_LOGIC);
	end component clock_div;
	signal d_fifo: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal serial_clk: STD_LOGIC;
	signal fifo_clk: STD_LOGIC;
	constant factor: integer:= 32;
begin
	serial_clk <= clk;

	serial_out: serializer port map(
		din => d_fifo,
		clk => serial_clk,
		serialout => sout
		);
	
	serial_clk_div: clock_div port map(
		src_clk => serial_clk,
		factor => factor,
		new_clk => fifo_clk
		);

	fifo_in: fifo port map(
		clk => fifo_clk,
		read_en => read_en,
		write_en => write_en,
		din => din,
		dout => d_fifo,
		empty => empty,
		full => full
		);
	
end architecture Behavioral;