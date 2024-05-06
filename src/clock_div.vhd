----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 10:07:09 PM
-- Design Name: 
-- Module Name: clock_div - Behavioral
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

entity clock_div is
    Port ( src_clk : in STD_LOGIC;
           factor : in integer;
           new_clk : out STD_LOGIC);
end clock_div;

architecture Behavioral of clock_div is
    signal counter: integer := 0;
    signal new_clk_temp : STD_LOGIC := '1';
begin

    new_clk <= new_clk_temp;

    process(src_clk) begin
        if rising_edge(src_clk) then
            
            if counter < factor/2 - 1 then
                counter <= counter + 1;
            else
                counter <= 0;
                new_clk_temp <= not new_clk_temp;
            end if;
        end if;
        
    end process;


end Behavioral;
