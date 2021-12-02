LIBRARY ieee;
USE ieee.std_logic_1164.all;

library gates;
use gates.all;

library mux;
use mux.all;

library binCounter4Bit;
use binCounter4Bit.all;

library controlUnit;
use controlUnit.all;

ENTITY Hamm_encoder_serial IS
  PORT (clk:  			IN STD_LOGIC;
        nRst: 			IN STD_LOGIC;
		  din: 			IN STD_LOGIC;
		  aux : out STD_LOGIC_VECTOR(7 DOWNTO 0);
		  aux1 : out STD_LOGIC_VECTOR(3 downto 0);
        dout:      	OUT STD_LOGIC);
END Hamm_encoder_serial;

ARCHITECTURE structure OF Hamm_encoder_serial IS
	signal sig_a, sig_b, sig_c, sig_d : STD_LOGIC;
	
	signal sig_x12, sig_x13, sig_x14, sig_x15 : STD_LOGIC;
	
	signal sig_x12_a, sig_x13_b, sig_x14_c, sig_x15_d : STD_LOGIC;
	
	signal sig_mux41out: STD_LOGIC;
	
	SIGNAL cOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL sOut : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	COMPONENT gateAnd2
    PORT (x0, x1		: IN STD_LOGIC;
          y				: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateXOr2
    PORT (x0, x1		: IN STD_LOGIC;
          y				: OUT STD_LOGIC);
	END COMPONENT;
	
	component flipFlopDPET
	 PORT (clk, D		: IN STD_LOGIC;
          nSet, nRst	: IN STD_LOGIC;
          Q, nQ		: OUT STD_LOGIC);
	 end component;
	
	component mux_4to1
	 port (A,B,C,D 	: in STD_LOGIC;
		    S0,S1		: in STD_LOGIC;
		    Z				: out STD_LOGIC);
	end component;
	
	component mux_2to1
	 port (A,B 			: in STD_LOGIC;
			 S				: in STD_LOGIC;
			 Z				: out STD_LOGIC);
	end component;
	
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
	ctrlunit : controlUnit PORT MAP (cOut, sOut);
	
	aux <= sOut;
	aux1(0) <= sig_x12_a;
	aux1(1) <= sig_x13_b;
	aux1(2) <= sig_x14_c;
	aux1(3) <= sig_x15_d;
	

	and1 : gateAnd2 port map(sOut(7), din, sig_a);
	and2 : gateAnd2 port map(sOut(6), din, sig_b);
	and3 : gateAnd2 port map(sOut(5), din, sig_c);
	and4 : gateAnd2 port map(sOut(4), din, sig_d);

	xor1 : gateXOr2 port map(sig_a, sig_x12, sig_x12_a);
	xor2 : gateXOr2 port map(sig_b, sig_x13, sig_x13_b);
	xor3 : gateXOr2 port map(sig_c, sig_x14, sig_x14_c);
	xor4 : gateXOr2 port map(sig_d, sig_x15, sig_x15_d);
	
	ffp0 : flipFlopDPET port map(clk, sig_x12_a, '1', sOut(3), sig_x12);
	ffp1 : flipFlopDPET port map(clk, sig_x13_b, '1', sOut(3), sig_x13);
	ffp2 : flipFlopDPET port map(clk, sig_x14_c, '1', sOut(3), sig_x14);
	ffp3 : flipFlopDPET port map(clk, sig_x15_d, '1', sOut(3), sig_x15);
	
	m410 : mux_4to1 port map(sig_x12, sig_x13, sig_x14, sig_x15, sOut(0), sOut(1), sig_mux41out);
	
	m210 : mux_2to1 port map(din, sig_mux41out, sOut(2), dout);

END structure;