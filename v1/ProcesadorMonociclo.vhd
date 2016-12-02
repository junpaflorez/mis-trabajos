----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:09 10/07/2015 
-- Design Name: 
-- Module Name:    ProcesadorMonociclo - Behavioral 
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

entity ProcesadorMonociclo is
    Port (  clk : in STD_LOGIC;
				reset : in STD_LOGIC;
				ProcessorOut : out  STD_LOGIC_vector(31 downto 0)
	 );
end ProcesadorMonociclo;

architecture Behavioral of ProcesadorMonociclo is
component add_module is
    Port ( Operator1 : in  STD_LOGIC_VECTOR(31 downto 0);
           Operator2 : in  STD_LOGIC_VECTOR(31 downto 0);
           Result : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

component ProgramCounter is
    Port ( PC_IN : in  STD_LOGIC_VECTOR(31 downto 0);
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PC_OUT : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

component instructionMemory is
    Port ( 
			  --clk : in STD_LOGIC;
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component unidadControl is
	Port ( --clk : in STD_LOGIC;
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           --op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           --cond : in  STD_LOGIC_VECTOR (3 downto 0);--condicional del branch
           --icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  --enableMem : out STD_LOGIC;
           --rfDest : out  STD_LOGIC;
           --rfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  --pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           --wrEnMem : out  STD_LOGIC;
           wrEnRF : out  STD_LOGIC;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

component registerFile is
    Port ( clk : in STD_LOGIC;
			  rs1 : in  STD_LOGIC_VECTOR(4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR(4 downto 0);
           rd : in  STD_LOGIC_VECTOR(4 downto 0);
           wren : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  Dwr : in STD_LOGIC_VECTOR(31 downto 0);
           Crs1 : out  STD_LOGIC_VECTOR(31 downto 0);
           Crs2 : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

component MUX is
    Port ( input0 : in  STD_LOGIC_VECTOR(31 downto 0);
           input1 : in  STD_LOGIC_VECTOR(31 downto 0);
			  selector : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

component ALU is
    Port ( op1 : in  STD_LOGIC_VECTOR(31 downto 0);
           op2 : in  STD_LOGIC_VECTOR(31 downto 0);
           ALUop : in  STD_LOGIC_VECTOR(5 downto 0);
			  carry : in STD_LOGIC;
           AluResult : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

component SEUDisp13 is
    Port ( disp13 : in  STD_LOGIC_VECTOR(12 downto 0);
           disp32 : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

signal DWR : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal incremento : STD_LOGIC_VECTOR(31 downto 0):="00000000000000000000000000000001";
signal add : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal result : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal IMaddress : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal InstructionOut : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal RFenabler : STD_LOGIC:='1';
signal ALUoperation : STD_LOGIC_VECTOR(5 downto 0):="111111";
signal ALUout : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal RS1content : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal RS2content : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal Disp32 : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal AluOperator2 : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal fakeCarry : STD_LOGIC:='0';

begin

	inc:add_Module port map(incremento, add, result);

	nextProgramCounter:ProgramCounter port map(result, reset, clk, add);
	
	PC:ProgramCounter port map(add, reset, clk, IMaddress);
	
	IM:InstructionMemory port map(IMaddress, reset,InstructionOut);
	
	uC:unidadControl port map(InstructionOut(31 downto 30), InstructionOut(24 downto 19), RFenabler, ALUoperation);
	
	RF:registerFile port map(clk, InstructionOut(18 downto 14), InstructionOut(4 downto 0),
									 InstructionOut(29 downto 25), RFenabler, reset, ALUout, RS1content, RS2content);
									 
	SEU:SEUDisp13 port map(InstructionOut(12 downto 0), Disp32);
	
	MUX21:MUX port map(RS2content, Disp32, InstructionOut(13), AluOperator2);
	
	ArithmeticLogicUnit:ALU port map(RS1content, AluOperator2, ALUoperation, fakeCarry, ALUout);
	
	ProcessorOut<=ALUout;
	

end Behavioral;

