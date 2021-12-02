LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY flipFlopDPET IS
  PORT (clk, D:     IN STD_LOGIC;
        nSet, nRst: IN STD_LOGIC;
        Q, nQ:      OUT STD_LOGIC);
END flipFlopDPET;

ARCHITECTURE behavior OF flipFlopDPET IS
BEGIN
  PROCESS (clk, nSet, nRst)
  BEGIN
    IF (nRst = '0')
	    THEN Q <= '0';
		      nQ <= '1';
		 ELSIF (nSet = '0')
		       THEN Q <= '1';
		            nQ <= '0';
	          ELSIF (clk = '1') AND (clk'EVENT)
	                THEN Q <= D;
		                  nQ <= NOT D;

	 END IF;
  END PROCESS;
END behavior;




LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY gates;
USE gates.all;

ENTITY binCounter4Bit IS
  PORT (nRst: IN STD_LOGIC;
        clk:  IN STD_LOGIC;
        c:    OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END binCounter4Bit;

ARCHITECTURE structure OF binCounter4Bit IS
  SIGNAL pD1, pD2: STD_LOGIC;
  SIGNAL iD1, iD2, iD3: STD_LOGIC;
  SIGNAL iQ0, iQ1, iQ2, iQ3: STD_LOGIC;
  SIGNAL inQ0: STD_LOGIC;
  
  COMPONENT gateAnd2
    PORT (x0, x1: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateXor2
    PORT (x0, x1: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT flipFlopDPET
    PORT (clk, D:     IN STD_LOGIC;
          nSet, nRst: IN STD_LOGIC;
          Q, nQ:      OUT STD_LOGIC);
  END COMPONENT;
  
BEGIN
  and1: gateAnd2 PORT MAP (iQ0, iQ1, pD1);
  and2: gateAnd2 PORT MAP (pD1, iQ2, pD2);
  
  xor1: gateXor2 PORT MAP (iQ0, iQ1, iD1);
  xor2: gateXor2 PORT MAP (pD1, iQ2, iD2);
  xor3: gateXor2 PORT MAP (pD2, iQ3, iD3);
  
  ffd0: flipFlopDPET PORT MAP (clk, inQ0, '1', nRst, iQ0, inQ0);
  ffd1: flipFlopDPET PORT MAP (clk, iD1,  '1', nRst, iQ1);
  ffd2: flipFlopDPET PORT MAP (clk, iD2,  '1', nRst, iQ2);
  ffd3: flipFlopDPET PORT MAP (clk, iD3,  '1', nRst, iQ3);
  
  c(0) <= iQ0;
  c(1) <= iQ1;
  c(2) <= iQ2;
  c(3) <= iQ3;
END structure;