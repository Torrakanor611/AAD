library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library gates;
use gates.all;

-- 1 not gate + 2 and gates + 1 xor gate
entity mux_2to1 is
port (A,B 		: in STD_LOGIC;
		S			: in STD_LOGIC;
		Z			: out STD_LOGIC);
end mux_2to1;

architecture Behavioral of mux_2to1 is
	signal sig_nS 		: std_logic;
	signal aux1, aux2 : std_logic;

	COMPONENT gateNot
   PORT (x0				: IN STD_LOGIC;
         y				: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateAnd2
   PORT (x0, x1		: IN STD_LOGIC;
         y				: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateXOr2
   PORT (x0, x1		: IN STD_LOGIC;
         y				: OUT STD_LOGIC);
	END COMPONENT;
	
begin
	not1 : gateNot PORT MAP(S, sig_nS);
	
	and1 : gateAnd2 PORT MAP(sig_nS, A, aux1);
	and2 : gateAnd2 PORT MAP(S, B, aux2);
	
	xor1 : gateXor2 PORT MAP(aux1, aux2, Z);
end Behavioral;


-------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- 3 not gates + 6 and gates + 3 xor gates
entity mux_4to1 is
 port(
     A,B,C,D 	: in STD_LOGIC;
     S0,S1		: in STD_LOGIC;
     Z			: out STD_LOGIC
  );
end mux_4to1;

architecture bhv of mux_4to1 is
	signal aux1, aux2 : std_logic;	

	COMPONENT mux_2to1
	port (A,B 			: in  STD_LOGIC;
			S   			: in  STD_LOGIC;
			Z   			: out STD_LOGIC);
	END COMPONENT;

begin
	mux211 : mux_2to1 PORT MAP(A, B, S0, aux1);
	mux212 : mux_2to1 PORT MAP(C, D, S0, aux2);
	
	mux213 : mux_2to1 PORT MAP(aux1, aux2, s1, Z);
end bhv;