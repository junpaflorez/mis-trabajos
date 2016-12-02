--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:04:13 10/02/2015
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/Arquitectura/ProcesadorMonociclo/registerFile_tb.vhd
-- Project Name:  ProcesadorMonociclo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registerFile
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
 
ENTITY registerFile_tb IS
END registerFile_tb;
 
ARCHITECTURE behavior OF registerFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registerFile
    PORT(
         clk : IN  std_logic;
         rs1 : IN  std_logic_vector(5 downto 0);
         rs2 : IN  std_logic_vector(5 downto 0);
         rd : IN  std_logic_vector(5 downto 0);
         wren : IN  std_logic;
			reset : IN std_logic;
         Dwr : IN  std_logic_vector(31 downto 0);
         Crs1 : OUT  std_logic_vector(31 downto 0);
         Crs2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rs1 : std_logic_vector(5 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(5 downto 0) := (others => '0');
   signal rd : std_logic_vector(5 downto 0) := (others => '0');
   signal wren : std_logic := '0';
	signal reset : std_logic := '0';
   signal Dwr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Crs1 : std_logic_vector(31 downto 0);
   signal Crs2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registerFile PORT MAP (
          clk => clk,
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          wren => wren,
			 reset => reset,
          Dwr => Dwr,
          Crs1 => Crs1,
          Crs2 => Crs2
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
		
		rs1 <="001000";
		rs2 <="010000";
		rd <="000110";
		wren<='1';
		dwr<="00000000000000000000000000000111";
		wait for 5 ms;
		
		rs1 <="000110";
		rs2 <="010000";
		rd <="010000";
		dwr<="00000000000000000000000000000011";
		wait for 5 ms;
		
		rs1 <="010000";
		rs2 <="000000";
		rd <="000000";
		dwr<="00000011111111111111111110000000";
		wait for 5 ms;
		
		
      wait;
   end process;

END;
