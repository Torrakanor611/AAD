LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY controlUnit IS
  PORT (addr:  IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        dOut: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END ControlUnit;

ARCHITECTURE behavior OF ControlUnit IS
    TYPE CMem IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
    CONSTANT prog: CMem := ("00000000", --E0  -> a=0,b=0,c=0,d=0,nRst=0,SEL=0,SELP=00
                            "11001000", --E1  -> a=1,b=1,c=0,d=0,nRst=1,SEL=0,SELP=00 
                            "10101000", --E2  -> a=1,b=0,c=1,d=0,nRst=1,SEL=0,SELP=00 
                            "10011000", --E3  -> a=1,b=0,c=0,d=1,nRst=1,SEL=0,SELP=00 
                            "01101000", --E4  -> a=0,b=1,c=1,d=0,nRst=1,SEL=0,SELP=00
                            "01011000", --E5  -> a=0,b=1,c=0,d=1,nRst=1,SEL=0,SELP=00
                            "00111000", --E6  -> a=0,b=0,c=1,d=1,nRst=1,SEL=0,SELP=00 
                            "11101000", --E7  -> a=1,b=1,c=1,d=0,nRst=1,SEL=0,SELP=00
									 "11011000", --E8  -> a=1,b=1,c=0,d=1,nRst=1,SEL=0,SELP=00
									 "10111000", --E9  -> a=1,b=0,c=1,d=1,nRst=1,SEL=0,SELP=00
									 "01111000", --E10 -> a=0,b=1,c=1,d=1,nRst=1,SEL=0,SELP=00
									 "11111000", --E11 -> a=1,b=1,c=1,d=1,nRst=1,SEL=0,SELP=00
									 "00001100", --E12 -> a=0,b=0,c=0,d=0,nRST=1,SEL=1,SELP=00
									 "00001101", --E13 -> a=0,b=0,c=0,d=0,nRst=1,SEL=1,SELP=01
									 "00001110", --E14 -> a=0,b=0,c=0,d=0,nRst=1,SEL=1,SELP=10
									 "00001111");--E15 -> a=0,b=0,c=0,d=0,nRst=1,SEL=1,SELP=11 
BEGIN
	dOut <= prog(to_integer(unsigned(addr)));	
END behavior;