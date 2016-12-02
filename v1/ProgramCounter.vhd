
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
    Port ( PC_IN : in  STD_LOGIC_VECTOR(31 downto 0);
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PC_OUT : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end ProgramCounter;

architecture Behavioral of ProgramCounter is

signal temp : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0');

begin
process(clk, reset, PC_IN)
	begin
	if rising_edge(clk) then
		if(reset = '1') then
			temp<=(others=>'0');
		else
			temp<=PC_IN;
		end if;
	--else 
		--temp<=PC_IN;
	end if;
	end process;
PC_OUT<=temp;
end Behavioral;

