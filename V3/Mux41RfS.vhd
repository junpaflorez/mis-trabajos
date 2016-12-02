----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:14:19 11/10/2015 
-- Design Name: 
-- Module Name:    Mux41RfS - Behavioral 
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

entity Mux41RfS is
    Port ( 
			  dataToRf : in  STD_LOGIC_VECTOR (31 downto 0); --call
           ALU_Result : in  STD_LOGIC_VECTOR (31 downto 0);-- branches
           ProgramCounter : in  STD_LOGIC_VECTOR (31 downto 0); -- en este caso no tenemos corrimiento de palabras
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           MuxOut: out  STD_LOGIC_VECTOR (31 downto 0));
end Mux41RfS;

architecture Behavioral of Mux41RfS is

begin

process(dataToRf,ALU_RESULT,ProgramCounter,RFSource)
begin
		case RFSource is
			when "00" =>
				MuxOut <= dataToRF;
			when "01" =>
				MuxOut <= ALU_Result;
			when "10" =>
				MuxOut <= ProgramCounter;
			when others =>
				MuxOut <= Alu_Result;
		end case;
end process;

end Behavioral;

