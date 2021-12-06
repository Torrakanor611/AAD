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


-------------------------


library ieee;
use ieee.std_logic_1164.all;

entity gateNand2 is
	port(x0, x1		: in  std_logic;
		  y			: out std_logic);
end gateNand2;

architecture logicFunction of gateNand2 is
begin
	y <= x0 NAND x1; 
end logicFunction;


-------------------------




----------------------------

library ieee;
use ieee.std_logic_1164.all;

entity gateNot is
	port(x0		: in  std_logic;
		  y			: out std_logic);
end gateNot;

architecture logicFunction of gateNot is
begin
	y <= Not x0; 
end logicFunction;