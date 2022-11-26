----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2022 12:23:57
-- Design Name: 
-- Module Name: reg_file - Behavioral
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

entity reg_file is
port (
    clk : in std_logic;
    ra1 : in std_logic_vector (2 downto 0);
    ra2 : in std_logic_vector (2 downto 0);
    wa : in std_logic_vector (2 downto 0);
    wd : in std_logic_vector (15 downto 0);
    regwr : in std_logic;
    en: in std_logic;
    rd1 : out std_logic_vector (15 downto 0);
    rd2 : out std_logic_vector (15 downto 0);
    reg0 : out std_logic_vector (15 downto 0);
    reg1 : out std_logic_vector (15 downto 0);
    reg2 : out std_logic_vector (15 downto 0);
    reg3 : out std_logic_vector (15 downto 0);
    reg4 : out std_logic_vector (15 downto 0);
    reg5 : out std_logic_vector (15 downto 0);
    reg6 : out std_logic_vector (15 downto 0);
    reg7 : out std_logic_vector (15 downto 0));
end reg_file;

architecture Behavioral of reg_file is

type reg_array is array (0 to 15) of std_logic_vector(15 downto 0);
signal reg_file : reg_array := (x"0001", x"0002", x"0003", x"0004", x"0005", x"0006", x"0007", x"0008", x"0009", others => x"0000");

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if regwr = '1' then
                reg_file(conv_integer(wa)) <= wd;
            end if;
        end if;
    end process;
    rd1 <= reg_file(conv_integer(ra1));
    rd2 <= reg_file(conv_integer(ra2));
    
    reg0 <= reg_file(0);
    reg1 <= reg_file(1);
    reg2 <= reg_file(2);
    reg3 <= reg_file(3);
    reg4 <= reg_file(4);
    reg5 <= reg_file(5);
    reg6 <= reg_file(6);
    reg7 <= reg_file(7);
    
end Behavioral;