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

entity ProcesadorMonocicloV2 is
    Port (  clk : in STD_LOGIC;
				reset : in STD_LOGIC;
				ProcessorOut : out  STD_LOGIC_vector(31 downto 0)
	 );
end ProcesadorMonocicloV2;

architecture Behavioral of ProcesadorMonocicloV2 is
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
			  nRs1 : in  STD_LOGIC_VECTOR(5 downto 0);
           nRs2 : in  STD_LOGIC_VECTOR(5 downto 0);
           nRd : in  STD_LOGIC_VECTOR(5 downto 0);
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

component WindowManager is
	Port (  --clk : in STD_LOGIC;
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
end component;

component PSR is
	Port (  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC;
           CWP : out  STD_LOGIC;
           carry : out  STD_LOGIC;
           icc : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end component;

component PSRModifier is
	Port (  aluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           operando1 : in  STD_LOGIC; --operando 1 de la alu, bit más significativo
           operando2 : in  STD_LOGIC; --operando 2 de la alu, bit más significativo
           aluOp : in  STD_LOGIC_VECTOR (5 downto 0);
			  nzvc : out std_logic_vector(3 downto 0) --bits de los conditional codes
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

--señales para el windows manager
signal CurrentWindowPointer : STD_LOGIC:='0';
signal nRegisterSource1 : STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');
signal nRegisterSource2 : STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');
signal nRegisterDestination : STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');
signal nextCurrentWindowPointer : STD_LOGIC:='0';

--señales para el PSR
signal temp_nzvc : STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');
signal ALUcarry : STD_LOGIC:='0';
signal ConditionalCodes : STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');

begin

	inc:add_Module port map(incremento, add, result);

	nextProgramCounter:ProgramCounter port map(result, reset, clk, add);

	PC:ProgramCounter port map(add, reset, clk, IMaddress);

	IM:InstructionMemory port map(IMaddress, reset,InstructionOut);

	Windowing : WindowManager port map(InstructionOut(31 downto 30), InstructionOut(24 downto 19), InstructionOut(18 downto 14), InstructionOut(4 downto 0), InstructionOut(29 downto 25), CurrentWindowPointer, nRegisterSource1, nRegisterSource2, nRegisterDestination, nextCurrentWindowPointer);
	
	uC:unidadControl port map(InstructionOut(31 downto 30), InstructionOut(24 downto 19), RFenabler, ALUoperation);
		
	RF:registerFile port map(clk, nRegisterSource1, nRegisterSource2, nRegisterDestination, RFenabler, reset, ALUout, RS1content, RS2content);
									 
	SEU:SEUDisp13 port map(InstructionOut(12 downto 0), Disp32);

	MUX21:MUX port map(RS2content, Disp32, InstructionOut(13), AluOperator2);
	
	ProcessorStateRegister : PSR port map(clk, reset, temp_nzvc, nextCurrentWindowPointer, CurrentWindowPointer, ALUcarry, ConditionalCodes);
	
	ProcessorStateRegisterModifier : PSRModifier port map(ALUout, RS1content(31), AluOperator2(31), ALUoperation, temp_nzvc);

	ArithmeticLogicUnit:ALU port map(RS1content, AluOperator2, ALUoperation, ALUcarry, ALUout);

	ProcessorOut<=ALUout;
	

end Behavioral;

