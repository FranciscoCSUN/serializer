----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 07:38:38 PM
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is
	component top is
		port (
			din: in STD_LOGIC_VECTOR(31 DOWNTO 0);
			clk: in STD_LOGIC;
			read_en: in STD_LOGIC;
			write_en: in STD_LOGIC;
			empty: out BOOLEAN;
			full: out BOOLEAN;
			sout: out STD_LOGIC
			);
	end component top;

	signal din: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal clk: STD_LOGIC;
	signal read_en: STD_LOGIC;
	signal write_en: STD_LOGIC;
	signal empty: BOOLEAN;
	signal full: BOOLEAN;
	signal sout: STD_LOGIC;

	signal clk_p: TIME:= 1ns;
begin

	UUT: top port map (
		din => din,
		clk => clk,
		read_en => read_en,
		write_en => write_en,
		empty => empty,
		full => full,
		sout => sout
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
		wait for 4*32*clk_p; -- buffer time for fifo
		read_en <= '1';	 -- fill and read
		write_en <= '1';
		wait for 4*32*clk_p; -- empty fifo
		read_en <= '1';
		write_en <= '0';
		wait;
	end process;

	process begin
		din <= x"01234567";
		wait for 32*clk_p;
		din <= x"FEEDBABE";
		wait for 32*clk_p;
		din <= x"FFEEDDCC";
		wait for 32*clk_p;
		din <= x"AABBABBA";
		wait for 32*clk_p;
		din <= x"FEEDBABE";
		wait for 32*clk_p;
	end process;

end Behavioral;
