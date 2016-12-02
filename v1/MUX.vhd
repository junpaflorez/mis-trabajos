----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:42:14 10/04/2015 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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

entity MUX is
    Port ( input0 : in  STD_LOGIC_VECTOR(31 downto 0);
           input1 : in  STD_LOGIC_VECTOR(31 downto 0);
			  selector : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end MUX;

architecture Behavioral of MUX is

signal tmp : STD_LOGIC_VECTOR(31 downto 0) :=(others =>'0');

begin
process(input0, input1, selector)
	begin
		if(selector = '0') then
			tmp<=input0;
		else
			tmp<=input1;
		end if;
	end process;
output<=tmp;
end Behavioral;

