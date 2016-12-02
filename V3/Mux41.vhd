library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux41 is
    Port ( 
			  PCDisp30 : in  STD_LOGIC_VECTOR (31 downto 0); --call
           PCDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);-- branches
           PC4 : in  STD_LOGIC_VECTOR (31 downto 0); -- en este caso no tenemos corrimiento de palabras
           PCAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           PCAddressOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux41;

architecture Behavioral of Mux41 is

begin

process(PCDisp30,PCDisp22,PC4,PCAddress,PCSource)
begin
		case PCSource is
			when "00" =>
				PCAddressOut <= PCAddress;
			when "01" =>
				PCAddressOut <= PCDisp30;
			when "10" =>
				PCAddressOut <= PCDisp22;
			when "11" =>
				PCAddressOut <= PC4;
			when others =>
				PCAddressOut <= PC4;
		end case;
end process;

end Behavioral;