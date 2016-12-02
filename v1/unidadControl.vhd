----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:12:47 10/04/2015 
-- Design Name: 
-- Module Name:    unidadControl - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity unidadControl is
	Port ( --clk : in STD_LOGIC;
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           --op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           --cond : in  STD_LOGIC_VECTOR (3 downto 0);--condicional del branch
           --icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  --enableMem : out STD_LOGIC;
           --rfDest : out  STD_LOGIC;
           --rfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  --pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           --wrEnMem : out  STD_LOGIC;
           wrEnRF : out  STD_LOGIC;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end unidadControl;

architecture Behavioral of unidadControl is

begin
	process(op, op3) --clk)
		begin
		--if rising_edge(clk) then
			if(op = "10") then
				case op3 is
					when "000000" => --add
						wrEnRF <= '1';
						ALUOP<="000000";
					when "010000" => -- addcc
						ALUOP <= "010000";
						wrEnRF<='1';
					when "001000" => --addx
						ALUOP <= "001000";
						wrEnRF<='1';
					when "011000" => --addxcc
						ALUOP <= "011000";
						wrEnRF<='1';
					when "000001" => --and
						ALUOP <= "000001";
						wrEnRF<='1';
					when "000101" => --and not
						ALUOP <= "000101";
						wrEnRF<='1';
					when "000010" => -- or
						ALUOP <= "000010";
						wrEnRF<='1';
					when "000110" => --or not
						ALUOP <= "000110";
						wrEnRF<='1';
					when "000011" => --xor
						ALUOP <= "000011";
						wrEnRF<='1';
					when "000111" => --xnor
						ALUOP <= "000111";
						wrEnRF<='1';
					when "000100" => -- sub
						ALUOP <= "000100";
						wrEnRF<='1';
					when "010100" => -- subcc
						ALUOP <= "010100";
						wrEnRF<='1';
					when "100101" => --shift left logical (todas las operaciones de shift solo funcionan con bit_vector, por eso tantos casteos)
						ALUOP <= "100101";
						wrEnRF<='1';
					when "100110" => --shift right logical
						ALUOP <= "100110";
						wrEnRF<='1';
					when "100111" => --shift right arithmetic
						ALUOP <= "100111";
						wrEnRF<='1';
					when others => -- Cae el nop
						ALUOP <= (others=>'1');
						wrEnRF<='0';
				end case;
			else 
			ALUOP<="111111";
			wrEnRF<='0';
			end if;
	end process;


end Behavioral;

