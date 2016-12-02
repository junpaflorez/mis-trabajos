----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:08:13 10/16/2015 
-- Design Name: 
-- Module Name:    WindowManager - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WindowManager is
    Port ( --clk : in STD_LOGIC;
			  OP : in STD_LOGIC_VECTOR(1 downto 0);
			  OP3 : in STD_LOGIC_VECTOR(5 downto 0);
			  RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0); 
           RD : in  STD_LOGIC_VECTOR (4 downto 0); 
           CWP : in  STD_LOGIC;
			  nRS1 : out STD_LOGIC_VECTOR(5 downto 0);
			  nRS2 : out STD_LOGIC_VECTOR(5 downto 0);
			  nRD : out STD_LOGIC_VECTOR(5 downto 0);
			  nCWP : out STD_LOGIC
			  );
end WindowManager;

architecture Behavioral of WindowManager is

signal RS1Int,RS2Int,RDInt: integer range 0 to 39:=0;
signal temp_nCWP : STD_LOGIC:='0';

begin
process(OP, OP3, CWP, RS1, RS2, RD)--, clk)
	begin
	--if rising_edge(clk) then
	if(OP = "10" and OP3 = "111100") then --SAVE
		temp_nCWP<='0';
	else if(OP = "10" and OP3 = "111101")then --RESTORE
				temp_nCWP<='1';
			--else
				--temp_nCWP<=CWP;
			end if;
	end if;
		
	if(RS1>="00000" and RS1<="00111") then
		RS1Int<=conv_integer(RS1);
		else
			if(RS1>="11000" and RS1<="11111")then
						RS1Int<=conv_integer(RS1)-(conv_integer(CWP)*16);
			else
				if(RS1>="10000" and RS1<="10111") then
					RS1Int<=conv_integer(RS1)+(conv_integer(CWP)*16);
				else
					if(RS1>="01000" and RS1<="01111") then
						RS1Int<=conv_integer(RS1)+(conv_integer(CWP)*16);
					end if;
				end if;
			end if;
	end if;
	
	if(RS2>="00000" and RS2<="00111") then
		RS2Int<=conv_integer(RS2);
		else
			if(RS2>="11000" and RS2<="11111") then
				RS2Int<=conv_integer(RS2)-(conv_integer(CWP)*16);
			else
				if(RS2>="10000" and RS2<="10111") then
					RS2Int<=conv_integer(RS2)+(conv_integer(CWP)*16);
				else
					if(RS2>="01000" and RS2<="01111")then
						RS2Int<=conv_integer(RS2)+(conv_integer(CWP)*16);
					end if;
				end if;
			end if;
	end if;

	if(RD>="00000" and RD<="00111") then
		RDInt<=conv_integer(RD);
		else
			if(RD>="11000" and RD<="11111") then
				RDInt<=conv_integer(RD)-(conv_integer(temp_nCWP)*16);
			else
				if(RD>="10000" and RD<="10111") then
					RDInt<=conv_integer(RD)+(conv_integer(temp_nCWP)*16);
				else
					if(RD>="01000" and RD<="01111")then
						RDInt<=conv_integer(RD)+(conv_integer(temp_nCWP)*16);
					end if;
				end if;
			end if;
	end if;
	--end if;
end process;
nCWP<=temp_nCWP;
nRS1<=conv_std_logic_vector(RS1Int, 6);
nRS2<=conv_std_logic_vector(RS2Int, 6);
nRD<=conv_std_logic_vector(RDInt, 6);

end Behavioral;

