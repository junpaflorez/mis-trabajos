--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:12:57 10/04/2015
-- Design Name:   
-- Module Name:   C:/Users/Oportunidades/Desktop/Arquitectura de Computadores/ProcesadorMonociclo/SEUDis13_tb.vhd
-- Project Name:  ProcesadorMonociclo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SEUDisp13
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY SEUDis13_tb IS
END SEUDis13_tb;
 
ARCHITECTURE behavior OF SEUDis13_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEUDisp13
    PORT(
         disp13 : IN  std_logic_vector(12 downto 0);
         disp32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal disp13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal disp32 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEUDisp13 PORT MAP (
          disp13 => disp13,
          disp32 => disp32
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		disp13<="1000000000000";
		wait for 5 ms;
		disp13<="0100111000000";
		wait for 5 ms;
		disp13<="0011000111111";
		wait for 5 ms;
		disp13<="1000011111100";
		wait for 5 ms;

      wait;
   end process;

END;
