----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2024 05:19:19 PM
-- Design Name: 
-- Module Name: fifo_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_tb is
--  Port ( );
end fifo_tb;

architecture Behavioral of fifo_tb is
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

	signal clk: STD_LOGIC;
	signal read_en: STD_LOGIC;
	signal write_en: STD_LOGIC;
	signal din: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal dout: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal empty: BOOLEAN;
	signal full: BOOLEAN;

	signal clk_p: time:= 32ns;
begin 

	UUT: fifo port map ( 
	    clk => clk,
	    read_en => read_en,
	    write_en => write_en,
	    din => din,
	    dout => dout,
	    empty => empty,
	    full => full
	    );

	process begin
		clk <= '1';
		wait for clk_p/2;
		clk <= '0';
		wait for clk_p/2;
	end process;

	process begin
		read_en <= '0';
		write_en <= '1';
		wait for clk_p; -- buffer time for fifo
		wait for 4*clk_p; -- fill fifo
		read_en <= '1';	 -- fill and read
		write_en <= '1';
		wait;
	end process;

	process begin
		din <= x"BEEBDAAB";
		wait for clk_p;
		din <= x"01233210";
		wait for clk_p;
		din <= x"32100123";
		wait for clk_p;
		din <= x"FEADBEAD";
		wait for clk_p;
		din <= x"FFFFEEEE";
		wait for clk_p;
	end process;	

end Behavioral;
