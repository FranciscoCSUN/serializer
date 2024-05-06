library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fifo is
  port ( 
    clk: IN STD_LOGIC;
    read_en: IN STD_LOGIC;
    write_en: IN STD_LOGIC;
    din: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    empty: OUT BOOLEAN;
    full: OUT BOOLEAN
    );
end fifo;

architecture Behavioral of fifo is

  signal addr_write: integer := 0;
  signal addr_read: integer := 0;
  signal size: integer := 0;

  type type2d is array (0 TO 3) of STD_LOGIC_VECTOR(31 DOWNTO 0);
  signal RAM: type2d;

  procedure read(
    signal RAM: inout type2d; 
    signal addr_read: inout integer;
    signal size: inout integer;
    signal dout: out STD_LOGIC_VECTOR) is
  begin
    dout <= RAM(addr_read);

    if size > 0 then
      RAM(addr_read) <= (others=>'X');
      addr_read <= (addr_read + 1) mod RAM'LENGTH;
      size <= size - 1;
    end if;

  end procedure;

  procedure write(
    signal RAM: inout type2d; 
    signal addr_write: inout integer; 
    signal data_in: in STD_LOGIC_VECTOR; 
    signal size: inout integer) is
  begin

    if size < RAM'LENGTH then
      RAM(addr_write) <= data_in;
      addr_write <= (addr_write + 1) mod RAM'LENGTH;
      size <= size + 1;
    end if;

  end procedure;

begin

  empty <= size = 0;
  full <= size = RAM'LENGTH;
  
  process(clk) begin
    if rising_edge(clk) then
      if read_en = '1' then
        read(RAM, addr_read, size, dout);
      end if;
    end if;

    if falling_edge(clk) then
      if write_en = '1' then
        write(RAM, addr_write, din, size);
      end if;
    end if;
  end process;
end Behavioral;
