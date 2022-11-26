----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.02.2022 19:32:25
-- Design Name: 
-- Module Name: SSD - Behavioral
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

entity SSD is
   Port ( 
         clk: in STD_LOGIC;
         digits: in STD_LOGIC_VECTOR(15 DOWNTO 0);
         anod: out STD_LOGIC_VECTOR(3 downto 0);
         catod: out STD_LOGIC_VECTOR(6 downto 0));
end SSD;

architecture Behavioral of SSD is

signal A: STD_LOGIC_VECTOR(3 downto 0);
signal cnt: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal sel_m : STD_LOGIC_VECTOR(1 downto 0);

begin
--numaratorul
  counter: process(clk)
  begin
       if rising_edge(clk) then
           cnt <= cnt + 1;  
       end if;
  end process;
  
  sel_m <= cnt(15 downto 14);
  
  --multiplexor pt catod
  
   mux1:process (sel_m, digits)
  begin
     case sel_m is
        when "00" => A <= digits(3 downto 0);
        when "01" => A <=  digits(7 downto 4);
        when "10" => A <=  digits(11 downto 8);
        when "11" => A<= digits(15 downto 12);
        when others => A<= (others => 'X');
     end case;
  end process;
  
-- mux pentru anod

   mux2:process(sel_m)
   begin
     case sel_m is
        when "00" => anod <= "1110";
        when "01" => anod <= "1101";
        when "10" => anod <= "1011";
        when "11" => anod <= "0111";
        when others => anod <= (others => 'X');
      end case;
     end process;
     
    --hex to 7 seg dcd
    
     with A Select 
                  catod<= "1000000" when "0000",
               "1111001" when "0001",   --1
              "0100100" when "0010",   --2
              "0110000" when "0011",   --3
              "0011001" when "0100",   --4
              "0010010" when "0101",   --5
              "0000010" when "0110",   --6
              "1111000" when "0111",   --7
              "0000000" when "1000",   --8
              "0010000" when "1001",   --9
              "0001000" when "1010",   --A
              "0000011" when "1011",   --b
              "1000110" when "1100",   --C
              "0100001" when "1101",   --d
              "0000110" when "1110",   --E
              "0001110" when "1111",   --F
              (others => 'X') when  others;  
                       

end Behavioral;