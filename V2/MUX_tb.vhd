--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:48:28 10/04/2015
-- Design Name:   
-- Module Name:   C:/Users/Oportunidades/Desktop/Arquitectura de Computadores/ProcesadorMonociclo/MUX_tb.vhd
-- Project Name:  ProcesadorMonociclo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX
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
 
ENTITY MUX_tb IS
END MUX_tb;
 
ARCHITECTURE behavior OF MUX_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX
    PORT(
         input0 : IN  std_logic_vector(31 downto 0);
         input1 : IN  std_logic_vector(31 downto 0);
         selector : IN  std_logic;
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input0 : std_logic_vector(31 downto 0) := (others => '0');
   signal input1 : std_logic_vector(31 downto 0) := (others => '0');
   signal selector : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          input0 => input0,
          input1 => input1,
          selector => selector,
          output => output
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		input0 <= "00000000000000000000000000000000";
		input1 <= "11111111111111111111111111111111";
		selector <= '0';
		wait for 5 ms;
		selector <= '1';
		wait for 5 ms;
		input1 <= "11111111111111110000000000000000";
      wait;
   end process;

END;
