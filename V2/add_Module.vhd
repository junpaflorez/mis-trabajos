
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; --libreria usada para sumar los STD_LOGIC_VECTORs

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity add_Module is
    Port ( Operator1 : in  STD_LOGIC_VECTOR(31 downto 0);
           Operator2 : in  STD_LOGIC_VECTOR(31 downto 0);
           Result : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end add_Module;

architecture Behavioral of add_Module is

signal temp1 : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0');
signal temp2 : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0');

begin

temp1<=Operator1;
temp2<=Operator2;

result<= STD_LOGIC_VECTOR(unsigned(temp1) + unsigned(temp2));


end Behavioral;

