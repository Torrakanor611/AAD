library ieee;
use ieee.std_logic_1164.all;

library binCounter4Bit;
use binCounter4Bit.all;

library controlUnit;
use controlUnit.all;

ENTITY encoderSerial IS
  PORT (clk, nRst:  IN STD_LOGIC;
        dOut: 		  OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END encoderSerial;

ARCHITECTURE Structural OF encoderSerial IS
	SIGNAL cOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	COMPONENT binCounter4Bit
		PORT (nRst: IN  STD_LOGIC;
				clk:  IN  STD_LOGIC;
				c:    OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
	END COMPONENT;
	COMPONENT controlUnit
		PORT (addr:  IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
				dOut:  OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END COMPONENT;
	
BEGIN
	bincnt   : binCounter4Bit PORT MAP (nRst, clk, cOut);
	ctrlunit : controlUnit PORT MAP (cOut, dOut);
END Structural;
