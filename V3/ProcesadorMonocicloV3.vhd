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

entity ProcesadorMonocicloV3 is
    Port (  clk : in STD_LOGIC;
				reset : in STD_LOGIC;
				ProcessorOut : out  STD_LOGIC_vector(31 downto 0)
	 );
end ProcesadorMonocicloV3;

architecture Behavioral of ProcesadorMonocicloV3 is
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
           op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cond : in  STD_LOGIC_VECTOR (3 downto 0);--condicional del branch
           icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  enableMem : out STD_LOGIC;
           rfDest : out  STD_LOGIC;
           rfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           wrEnMem : out  STD_LOGIC;
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
           Crs2 : out  STD_LOGIC_VECTOR(31 downto 0);
			  Crd : out STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

component MUX is
    Port ( input0 : in  STD_LOGIC_VECTOR(31 downto 0);
           input1 : in  STD_LOGIC_VECTOR(31 downto 0);
			  selector : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end component;

component MUX21 is
    Port ( input0 : in  STD_LOGIC_VECTOR(5 downto 0);
           input1 : in  STD_LOGIC_VECTOR(5 downto 0);
			  selector : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(5 downto 0)
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
	Port (  OP : in STD_LOGIC_VECTOR(1 downto 0);
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

component Mux41 is
    Port ( 
			  PCDisp30 : in  STD_LOGIC_VECTOR (31 downto 0); --call
           PCDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);-- branches
           PC4 : in  STD_LOGIC_VECTOR (31 downto 0); -- en este caso no tenemos corrimiento de palabras
           PCAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           PCAddressOut : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component SEUDisp22 is
    Port ( SEU22 : in  STD_LOGIC_VECTOR (21 downto 0);
           SEU32 : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component SEUDisp30 is
    Port ( Disp30 : in  STD_LOGIC_VECTOR (29 downto 0);
           SEU32 : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component dataMemory is
    Port ( clk : in  STD_LOGIC;
			  enableMem : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  cRD : in  STD_LOGIC_VECTOR (31 downto 0);
           address : in STD_LOGIC_VECTOR (31 downto 0);				
           wrEnMem : in  STD_LOGIC;
           datoMem : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component Mux41RfS is
    Port ( 
			  dataToRf : in  STD_LOGIC_VECTOR (31 downto 0); --call
           ALU_Result : in  STD_LOGIC_VECTOR (31 downto 0);-- branches
           ProgramCounter : in  STD_LOGIC_VECTOR (31 downto 0); -- en este caso no tenemos corrimiento de palabras
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           MuxOut: out  STD_LOGIC_VECTOR (31 downto 0));
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

--señales para los modulos que tienen que ver con los conditional branches
signal chosenProgramCounter : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal cacheEnabler : STD_LOGIC:='0';
signal mux21O7Controller : STD_LOGIC:='0';
signal mux41RfSelector : STD_LOGIC_VECTOR(1 downto 0):=(others=>'0');
signal PCSelector : STD_LOGIC_VECTOR(1 downto 0):=(others=>'0');
signal cacheWrEn : STD_LOGIC:='0';
signal cacheOut : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal toRegisterDestination : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal CallTo : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal BranchTo : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');

signal CallResult : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal BranchResult : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');

--señales para el control de flujo relacionado con el registro O7
signal O7 : STD_LOGIC_VECTOR(5 downto 0):="001111";
signal chosenRegisterDestination : STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');
signal contentRegisterDestination : STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');

begin

	inc : add_Module port map(incremento, add, result);

	nextProgramCounter : ProgramCounter port map(chosenProgramCounter, reset, clk, add);

	PC : ProgramCounter port map(add, reset, clk, IMaddress);

	IM : InstructionMemory port map(IMaddress, reset,InstructionOut);

	Windowing : WindowManager port map(InstructionOut(31 downto 30), InstructionOut(24 downto 19), 
													InstructionOut(18 downto 14), InstructionOut(4 downto 0), 
													InstructionOut(29 downto 25), CurrentWindowPointer, nRegisterSource1,
													nRegisterSource2, nRegisterDestination, nextCurrentWindowPointer);
	
	uC : unidadControl port map(InstructionOut(31 downto 30), InstructionOut(24 downto 22), InstructionOut(24 downto 19),
										InstructionOut(28 downto 25), ConditionalCodes, cacheEnabler, mux21O7Controller, mux41RfSelector,
										PCSelector, cacheWrEn, RFenabler, ALUoperation);
		
	RF : registerFile port map(clk, nRegisterSource1, nRegisterSource2, chosenRegisterDestination, RFenabler, reset, 
										toRegisterDestination, RS1content, RS2content, contentRegisterDestination);
									 
	SEU : SEUDisp13 port map(InstructionOut(12 downto 0), Disp32);

	MUX21ALU : MUX port map(RS2content, Disp32, InstructionOut(13), AluOperator2);
	
	MUX21O7 : MUX21 port map(nRegisterDestination, O7, mux21O7Controller, chosenRegisterDestination);

	ProcessorStateRegister : PSR port map(clk, reset, temp_nzvc, nextCurrentWindowPointer, CurrentWindowPointer,
														ALUcarry, ConditionalCodes);

	ProcessorStateRegisterModifier : PSRModifier port map(ALUout, RS1content(31), AluOperator2(31), ALUoperation,
																			temp_nzvc);

	ArithmeticLogicUnit : ALU port map(RS1content, AluOperator2, ALUoperation, ALUcarry, ALUout);

	cache : dataMemory port map(clk, cacheEnabler, reset, contentRegisterDestination, ALUout, cacheWrEn, cacheOut);

	SeuCall : SEUDisp30 port map(InstructionOut(29 downto 0), CallTo);
	
	PCCall : add_Module port map(IMaddress, CallTo, CallResult);
	
	SeuBranch : SEUDisp22 port map(InstructionOut(21 downto 0), BranchTo);
	
	PCBranch : add_Module port map(IMaddress, BranchTo, BranchResult);

	MUX41PC : Mux41 port map(CallResult, BranchResult, result, ALUout, PCSelector, chosenProgramCounter);

	MUX41RFSource : Mux41Rfs port map(cacheOut, ALUout, IMaddress, mux41RfSelector, toRegisterDestination);

	ProcessorOut<=toRegisterDestination;
	

end Behavioral;

