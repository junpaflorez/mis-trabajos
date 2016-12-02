library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEUDisp30 is
    Port ( Disp30 : in  STD_LOGIC_VECTOR (29 downto 0);
           SEU32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEUDisp30;

architecture Behavioral of SEUDisp30 is

begin
process(Disp30)
	begin
		if(Disp30(29) = '1')then
			SEU32(29 downto 0) <= Disp30;
			SEU32(31 downto 30) <= (others=>'1');
		else
			SEU32(29 downto 0) <= Disp30;
			SEU32(31 downto 30) <= (others=>'0');
		end if;
	end process;
end Behavioral;