----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2022 13:08:38 
-- Design Name: 
-- Module Name: EX - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity EX is
    Port (
        RD1 : in std_logic_vector (15 downto 0);
        ALUSrc : in std_logic;
        RD2 : in std_logic_vector (15 downto 0);
        ext_imm : in std_logic_vector (15 downto 0);
        sa : in std_logic;
        func : in std_logic_vector(2 downto 0);
        ALUOp: in std_logic_vector(2 downto 0);
        PCp1: in std_logic_vector(15 downto 0); 
        rt: in std_logic_vector(2 downto 0);
        rd: in std_logic_vector(2 downto 0);
        RegDst: in std_logic;
        Zero: out std_logic;
        ALURes: out std_logic_vector(15 downto 0);
        BranchAddress: out std_logic_vector(15 downto 0);
        wa: out std_logic_vector(2 downto 0));
end EX;

architecture Behavioral of EX is

signal B : std_logic_vector(15 downto 0) := (others => '0');
signal C : std_logic_vector(15 downto 0) := (others => '0');
signal ALUCtrl : std_logic_vector(3 downto 0) := (others => '0');

begin
    ALUControl: process(ALUOp, func)
    begin
        case ALUOp is
            when "000" => 
                case func is
                    when "000" => ALUCtrl <= "0000";
                    when "001" => ALUCtrl <= "0001";
                    when "010" => ALUCtrl <= "0010";
                    when "011" => ALUCtrl <= "0011";
                    when "100" => ALUCtrl <= "0100";
                    when "101" => ALUCtrl <= "0101";
                    when "110" => ALUCtrl <= "0110";
                    when "111" => ALUCtrl <= "0111";
                end case;
            when "010" => ALUCtrl <= "0000";
            when "001" => ALUCtrl <= "0001";
            when others => ALUCtrl <= (others => '0');
        end case;            
    end process; 
    
    ALU: process(ALUCtrl, RD1, B, sa)
    begin
        case ALUCtrl is
            when "0000" => C <= RD1 + B;
            when "0001" => C <= RD1 - B;
            when "0010" => 
                if sa = '1' then
                    C <= B(14  downto 0) & "0";
                else
                    C <= B;
                end if;
            when "0011" =>
                if sa = '1' then
                    C <= "0" & B(15 downto 1);
                else
                    C <= B;
                end if;
            when "0100" => C <= RD1 and B;
            when "0101" => C <= RD1 or B;
            when "0110" =>  if signed(RD1) < signed(B) then
                               C <= x"0001";
                           else
                               C <= x"0000";
                           end if;
            when "0111" => C<= RD1 + B; --sau xor
              
            when "1000" => 
                if signed(RD1) < signed(B) then
                    C <= x"0001";
                else
                    C <= x"0000";
                end if;
            when others => C <= (others => 'X');
        end case;
    end process;
    
    B <= ext_imm when ALUSrc = '1' else RD2;
    ALURes <= C;
    Zero <= '1' when C = x"0000" else '0'; 
    BranchAddress <= PCp1 + ext_imm;
    wa <= rt when RegDst = '0' else rd;
    
end Behavioral;


