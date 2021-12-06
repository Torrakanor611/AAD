LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

library gates;
use gates.all;

ENTITY contMem IS
  PORT (addr:  IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        dOut: OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END contMem;

ARCHITECTURE behavior OF contMem IS
BEGIN
  PROCESS (addr)
  TYPE CMem IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR (6 DOWNTO 0);
    CONSTANT prog: CMem := ("1100000", --E0  -> a=1,b=1,c=0,d=0,SEL=0,SELP=00 
									 "1010000", --E1  -> a=1,b=0,c=1,d=0,SEL=0,SELP=00 
									 "1001000", --E2  -> a=1,b=0,c=0,d=1,SEL=0,SELP=00 
									 "0110000", --E3  -> a=0,b=1,c=1,d=0,SEL=0,SELP=00
									 "0101000", --E4  -> a=0,b=1,c=0,d=1,SEL=0,SELP=00
									 "0011000", --E5  -> a=0,b=0,c=1,d=1,SEL=0,SELP=00 
									 "1110000", --E6  -> a=1,b=1,c=1,d=0,SEL=0,SELP=00
									 "1101000", --E7  -> a=1,b=1,c=0,d=1,SEL=0,SELP=00
									 "1011000", --E8  -> a=1,b=0,c=1,d=1,SEL=0,SELP=00
									 "0111000", --E9  -> a=0,b=1,c=1,d=1,SEL=0,SELP=00
									 "1111000", --E10 -> a=1,b=1,c=1,d=1,SEL=0,SELP=00
									 "0000100", --E11 -> a=0,b=0,c=0,d=0,SEL=1,SELP=00
									 "0000101", --E12 -> a=0,b=0,c=0,d=0,SEL=1,SELP=01
									 "0000110", --E13 -> a=0,b=0,c=0,d=0,SEL=1,SELP=10
									 "0000111", --E14 -> a=0,b=0,c=0,d=0,SEL=1,SELP=11
									 "0000000"); --E15 --estado reset  -> a=0,b=0,c=0,d=0,SEL=0,SELP=00
    VARIABLE pos: INTEGER;
  BEGIN
    pos := CONV_INTEGER (addr);
    dOut <= prog(pos);
  END PROCESS;
END behavior;



LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY controlUnit IS
  PORT (nGRst: 	IN STD_LOGIC;
		  binRst:	In std_logic;
		  addr:  	IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        dOut: 		OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		  nRst:		out std_logic);
END ControlUnit;

ARCHITECTURE behavior OF ControlUnit IS
	signal sig_binRst : std_logic;
	
	component contMem
   PORT (addr:  IN STD_LOGIC_VECTOR (3 DOWNTO 0);
         dOut: OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
	END component;
	
	component gateNot
	port(x0		 : in  std_logic;
		  y			: out std_logic);
	end component;
	
	component gateAnd2
	port(x0, x1		: in  std_logic;
		  y			: out std_logic);
	end component;
	
BEGIN
	cMem: contMem PORT MAP (addr, dOut);
	
	not1: gateNot port map(binRst, sig_binRst); 
	
	and5 : gateAnd2 port map(nGRst, sig_binRst, nRst);
	
END behavior;