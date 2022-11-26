------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 01.03.2022 21:05:45 
---- Design Name: 
---- Module Name: RAM - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity RAM is

--    port ( clk : in std_logic;
--    we : in std_logic;
--    en : in std_logic;
--    addr : in std_logic_vector(7 downto 0);
--    di : in std_logic_vector(15 downto 0);
--    do : out std_logic_vector(15 downto 0));

--end RAM;

--architecture Behavioral of RAM is

--type ram_type is array (0 to 255) of std_logic_vector (15 downto 0);
--signal RAM: ram_type;
--begin
--    process (clk)
--    begin
--    if clk'event and clk = '1' then
--        if en = '1' then
--            if we = '1' then
--                RAM(conv_integer(addr)) <= di;
--            else
--                do <= RAM( conv_integer(addr));
--            end if;
--        end if;
--    end if;
--end process;

--end Behavioral;
