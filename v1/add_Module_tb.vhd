--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:17:17 09/30/2015
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/Arquitectura/ProcesadorMonociclo/add_Module_tb.vhd
-- Project Name:  ProcesadorMonociclo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: add_Module
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
 
ENTITY add_Module_tb IS
END add_Module_tb;
 
ARCHITECTURE behavior OF add_Module_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT add_Module
    PORT(
         Operator1 : IN  std_logic_vector(31 downto 0);
         Operator2 : IN  std_logic_vector(31 downto 0);
         Result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Operator1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Operator2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Result : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: add_Module PORT MAP (
          Operator1 => Operator1,
          Operator2 => Operator2,
          Result => Result
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Operator1 <= "00000000000000000000000000000001";
		Operator2 <= "00000000000000000000000000000001";
      wait for 10ms;
		Operator1 <= "00000000000000000000000100101101";--301
		Operator2 <= "00000000000000000000000000000100";--4

      wait;
   end process;

END;
