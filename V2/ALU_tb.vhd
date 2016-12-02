--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:39:52 10/04/2015
-- Design Name:   
-- Module Name:   C:/Users/Oportunidades/Desktop/Arquitectura de Computadores/ProcesadorMonociclo/ALU_tb.vhd
-- Project Name:  ProcesadorMonociclo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         op1 : IN  std_logic_vector(31 downto 0);
         op2 : IN  std_logic_vector(31 downto 0);
         ALUop : IN  std_logic_vector(5 downto 0);
         carry : IN  std_logic;
         AluResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op1 : std_logic_vector(31 downto 0) := (others => '0');
   signal op2 : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUop : std_logic_vector(5 downto 0) := (others => '0');
   signal carry : std_logic := '0';

 	--Outputs
   signal AluResult : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          op1 => op1,
          op2 => op2,
          ALUop => ALUop,
          carry => carry,
          AluResult => AluResult
        );

   -- Clock process definitions

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		op1 <= "00000000000000000000000000000111";
		op2 <= "00000000000000000000000000000111";
		ALUop <= "000000"; --add
		wait for 5 ms;
		op1 <= "00000000000000000000000000000011";
		op2 <= "00000000000000000000000000000001";
		ALUop <= "000000"; --add
		wait for 5 ms;
		op1 <= "00000000000000000000000000000011";
		op2 <= "00000000000000000000000000000001";
		ALUop <= "000100"; --sub
		wait for 5 ms;
		op1 <= "10000000000000000000000000000011";
		op2 <= "00000000000000000001000000000001";
		ALUop <= "000010"; --or
		wait for 5 ms;
		op1 <= "10000000000000000000000000000011";
		op2 <= "00000000000000000000000000000001";
		ALUop <= "100101"; --sll
		wait for 5 ms;		
		op1 <= "10000000000000000000000000000011";
		op2 <= "00000000000000000000000000000001";
		ALUop <= "100111"; --sra
		wait for 5 ms;
		
      -- insert stimulus here 

      wait;
   end process;

END;
