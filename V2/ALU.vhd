----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:19:31 10/04/2015 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.numeric_std.all; --libreria usada para sumar los STD_LOGIC_VECTORs


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( op1 : in  STD_LOGIC_VECTOR(31 downto 0);
           op2 : in  STD_LOGIC_VECTOR(31 downto 0);
           ALUop : in  STD_LOGIC_VECTOR(5 downto 0);
			  carry : in STD_LOGIC;
           AluResult : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end ALU;

architecture Behavioral of ALU is

signal tmp : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

begin
process(op1,op2,ALUop, carry)
	begin
	   case (ALUop) is --todos los codigos de entrada (ALUop) están igual a como se maneja el op3 en la arquitectura Sparc v8
			when "000000" => -- add
				AluResult <= op1 + op2;
			when "010000" => -- addcc
				AluResult <= op1 + op2;
			when "001000" => --addx
				AluResult <= op1 + op2 + carry;
			when "011000" => --addxcc
				AluResult <= op1 + op2 + carry;
			when "000001" => --and
				AluResult <= op1 and op2;			
			when "010001" => --andcc
				AluResult <= op1 and op2;
			when "000101" => --and not
				AluResult <= op1 and not(op2);
			when "010101" => --and not cc
				AluResult <= op1 and not(op2);
			when "000010" => -- or
				AluResult <= op1 or op2;
			when "010010" => -- orcc
				AluResult <= op1 or op2;
			when "000110" => --or not
				AluResult <= op1 or not(op2);
			when "010110" => --or not cc
				AluResult <= op1 or not(op2);
			when "000011" => --xor
				AluResult <= op1 xor op2;
			when "010011" => --xorcc
				AluResult <= op1 xor op2;
			when "000111" => --xnor
				AluResult <= op1 xor not(op2);
			when "010111" => --xnorcc
				AluResult <= op1 xor not(op2);
			when "000100" => -- sub
				AluResult <= op1 - op2;
			when "010100" => -- subcc
				AluResult <= op1 - op2;
			when "111100" => --SAVE
				ALUResult <= op1 + op2;
			when "111101" => --RESTORE
				ALUResult <= op1 + op2;
			when "100101" => --shift left logical (todas las operaciones de shift solo funcionan con bit_vector, por eso tantos casteos)
				AluResult <= to_stdlogicvector(to_bitvector(op1) sll conv_integer(op2(4 downto 0)));
			when "100110" => --shift right logical
				AluResult <= to_stdlogicvector(to_bitvector(op1) srl conv_integer(op2(4 downto 0)));
			when "100111" => --shift right arithmetic
				AluResult <= to_stdlogicvector(to_bitvector(op1) sra conv_integer(op2(4 downto 0)));
			when others => -- Cae el nop
				AluResult <= (others=>'0');
		end case;
	end process;
end Behavioral;

