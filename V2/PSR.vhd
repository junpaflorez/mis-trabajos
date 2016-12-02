----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:21 10/21/2015 
-- Design Name: 
-- Module Name:    PSR - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC;
           CWP : out  STD_LOGIC;
           carry : out  STD_LOGIC;
           icc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR;

architecture Behavioral of PSR is

signal PSRegister: STD_LOGIC_VECTOR (31 DOWNTO 0):= (others=>'0');


begin
	process(clk, reset, nCWP)
	begin
		if(rising_edge(clk))then
			if(reset = '1') then
				CWP <= '0';
				carry <= '0';
				icc <= "0000";
			else
				PSRegister(23 downto 20) <= nzvc;
				--PSRegister(0) <= nCWP;
				carry <= PSRegister(20);
				icc <= PSRegister(23 downto 20);
				--CWP <= PSRegister(0);
				CWP<=nCWP;
			end if;
		end if;
	end process;
end Behavioral;