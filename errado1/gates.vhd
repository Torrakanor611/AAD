LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXOr2 IS
  PORT (x0, x1: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateXOr2;

ARCHITECTURE logicFunction OF gateXOr2 IS
BEGIN
  y <= x0 XOR x1;
END logicFunction;


-------------------------


library ieee;
use ieee.std_logic_1164.all;

entity gateAnd2 is
	port(x0, x1		: in  std_logic;
		  y			: out std_logic);
end gateAnd2;

architecture logicFunction of gateAnd2 is
begin
	y <= x0 AND x1; 
end logicFunction;