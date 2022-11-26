----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2022 10:38:52
-- Design Name: 
-- Module Name: IF1 - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF1 is
  Port( clk: in std_logic;
  en: in std_logic;
  rst : in std_logic;
  brAddr: in std_logic_vector(15 downto 0);
  jmpAddr: in std_logic_vector(15 downto 0);
  pcSrc: in std_logic;
  jump: in std_logic;
  instr: out std_logic_vector(15 downto 0);
  pcout:out std_logic_vector(15 downto 0)
  );
  
end IF1;

architecture Behavioral of IF1 is

signal cnt: std_logic_vector(15 downto 0):= (others => '0');
signal mux1_out: std_logic_vector(15 downto 0) := (others =>'0');
signal mux2_out: std_logic_vector(15 downto 0) := (others =>'0');
signal plus_out: std_logic_vector(15 downto 0) := (others =>'0');
signal pc_out: std_logic_vector(15 downto 0) := (others =>'0');
signal S: std_logic := '0';  
signal AD: std_logic_vector(15 downto 0) := (others => '0');

type MEM is array (0 to 255) of std_logic_vector (15 downto 0);

signal rom: MEM := (
-- 2|7 + 4^5 
--B"111_000_001_0000010", --addi $1, $0, 2
--B"111_000_010_0000111", --addi $2, $0, 7
--B"000_001_010_011_0_101", --or $3, $1, $2
--B"111_000_100_0000100",  --addi $4, $0, 4
--B"111_000_101_0000101",  --addi $5, $0, 5
--B"000_100_101_110_0_111", --xor $6, $4, $5
--B"000_011_110_111_0_000", --add $7, $3, $6
--others => x"1111");
 
 --Suma numerelor puteri ale lui 2 care se afla pe pozitii pare
 
 
 ---------------------[ initializare ]----------------------
 B"000_000_000_010_0_000",    --add $2, $0, $0   //suma =0
 B"111_000_011_0000001",      --addi $3, $0, 1   //nr(putere 2) = 1
 B"110_000_100_0000001",      --lw $4, 1($0)     //pozitie inceput mem(poz1)-> 4
 B"000_000_000_000_0_000",    --NoOp
 B"110_000_101_0000010",      --lw $5, 2($0)     //pozitie final
 
 ----------------------[ verif poz inceput = para ]------------------- daca pozitia e impara, inmultim cu 2=> poz para
 B"111_100_110_0000000",      --addi $6, $4, 0    //poz inceput=> $6
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"000_110_110_110_0_011",    --srl $6, $6       //$6/2
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"000_110_110_110_0_010",    --sll $6, $6       //$6*2
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"100_110_100_0001001",      --beq $6, $4, 9    //daca poz = impara
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"111_100_100_0000001",      --addi $4, $4, 1   //$4++ii
 B"000_000_000_000_0_000",    --NoOp
 
 
 -----------------------[ $3 = 2^ $4 ]-------------------
 B"000_000_000_110_0_000",    --add $6, $0, $0    //i=0
 B"000_000_000_000_0_000",    --NoOp
 B"100_110_100_0001110",      --beq $6, $4, 14    //cat timp i != poz inceput
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"111_110_110_0000001",      --addi $6, $6, 1    //i=i++
 B"000_011_011_011_0_010",    --sll $3, $3        //$3=$3*2
 B"001_0000000001010",        --j 10
 B"000_000_000_000_0_000",    --NoOp
 
 
 ----------------------[ suma nr poz pare ]------------------
 B"000_101_100_110_0_001",    --sub $6, $5, $4    //$6 = $5 - $4
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"010_110_001_0010100",      --bgez $6, 20       //cat timp($6<=0)
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"111_100_100_0000010",      --addi $4, $4, 2    //i=i+2
 B"000_011_011_011_0_010",    --sll $3, $3        //$3=$3*4
 B"000_000_000_000_0_000",    --NoOp
 B"000_000_000_000_0_000",    --NoOp
 B"000_010_011_010_0_000",    --add $2, $2, $3    //s=s+$3
 B"001_0000000001110",        --j 14
 B"000_000_000_000_0_000",    --NoOp
 B"101_000_010_0000010",      --sw $2, 2($0)      //suma=> mem(poz2)
 others => x"0000"    
 );
 
begin

--PC
process(clk,en)
begin
if rising_edge(clk) then
  if en ='1' then
   pc_out<= mux2_out;
  end if;
end if;
end process;

--instr <= rom(conv_integer(pc_out));
--PLUS
plus_out<= pc_out+1;
pcout <= plus_out;

 --pentru mux1
 process(pcSrc, plus_out, brAddr)
 begin
 case(pcSrc) is
     when '0' => mux1_out <= plus_out;
    when others => mux1_out <= brAddr;
 end case;
 end process;
 
 --pentru mux2
 process(jump, mux1_out, jmpAddr)
 begin
 case(jump) is
    when '0' => mux2_out <=mux1_out;
     when others=> mux2_out <= jmpAddr;
 end case;
 end process;
 
 instr<= rom(conv_integer(pc_out(7 downto 0)));
 
 end Behavioral;