----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2024 10:02:28 PM
-- Design Name: 
-- Module Name: serializer_tb - Behavioral
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

entity serializer_tb is
--  Port ( );
end serializer_tb;

architecture Behavioral of serializer_tb is
	component serializer is
	 	port (
	 		din : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			clk : in STD_LOGIC;
			serialout : out STD_LOGIC
	 		);
	 end component serializer;
	 signal din: STD_LOGIC_VECTOR(31 DOWNTO 0);
	 signal clk: STD_LOGIC;
	 signal serialout: STD_LOGIC;
	 signal clk_p: time := 32ns;
begin

	UUT: serializer port map(
		din => din,
		clk => clk,
		serialout => serialout
		);

	process begin
		clk <= '1';
		wait for clk_p/2;
		clk <= '0';
		wait for clk_p/2;
	end process;

	process begin
		din <= x"ACDCBEEF";
		wait for clk_p;
		din <= x"01234567";
		wait for clk_p;
	end process;

end Behavioral;
