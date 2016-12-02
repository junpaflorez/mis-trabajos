
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SEUDisp13 is
    Port ( disp13 : in  STD_LOGIC_VECTOR(12 downto 0);
           disp32 : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end SEUDisp13;

architecture Behavioral of SEUDisp13 is

begin
process(disp13)
	begin
		if(disp13(12) = '1')then
			disp32(12 downto 0) <= disp13;
			disp32(31 downto 13) <= (others=>'1');
		else
			disp32(12 downto 0) <= disp13;
			disp32(31 downto 13) <= (others=>'0');
		end if;
	end process;
end Behavioral;

