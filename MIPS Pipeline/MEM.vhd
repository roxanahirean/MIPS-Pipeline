----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2022 13:11:39 
-- Design Name: 
-- Module Name: MEM - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity MEM is
    Port (
        clk : in std_logic;
        en : in std_logic;
        MemWrite : in std_logic;
        ALUResIn : in std_logic_vector(15 downto 0);
        RD2 : in std_logic_vector(15 downto 0);
        MemData : out std_logic_vector(15 downto 0);
        ALUResOut: out std_logic_vector(15 downto 0));
end MEM;

architecture Behavioral of MEM is

type ram_type is array (0 to 15) of std_logic_vector(15 downto 0);
signal ram : ram_type := (x"0001", x"0002", x"0003", x"0004", x"0005", x"0006", x"0007", x"0008", x"0009", others => x"0000");

begin

    data_memory: process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' and MemWrite = '1' then
                ram(conv_integer(ALUResIn(3 downto 0))) <= RD2;
            end if;
        end if;
     end process;
     
     MemData <= ram(conv_integer(ALUResIn(4 downto 0)));
     ALUResOut <= ALUResIn;
     
end Behavioral;

