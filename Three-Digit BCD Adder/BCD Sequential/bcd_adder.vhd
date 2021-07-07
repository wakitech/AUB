library ieee;
use ieee.std_logic_1164.all;

entity bcd_adder is
	port (
		d1,d2 : in integer;
		clk: in std_logic;
		overflow: out std_logic;
		load: in std_logic;
		clear: in std_logic;
		dout : out integer		
);
end bcd_adder;
-----------------------

architecture bcd_adder_arch of bcd_adder is

signal counter: integer:=0;
signal Q4A,Q4B: std_logic_vector(3 downto 0);		-- two 4 bits vector to be added at each clock cycle
signal Q4sum: std_logic_vector(3 downto 0);
signal diff: std_logic_vector (0 to 1);
signal OP,b,cout, m_t:std_logic;			-- OP = '0' for addition and OP = '1' for subtraction
signal cin: std_logic:='0';					
signal M,Sx: std_logic_vector (1 to 3);			 --M compares each digit of d1 and d2 
signal bcd1,bcd2, bcd2_t, bcd1_t: std_logic_vector (11 downto 0);	--temporary signals
signal f,x1: std_logic_vector (12 downto 0);		-- f is the BCD output, to be converted to integer.

--------------------------------------------------------------------------------
component DIGITADD is					
	port(
		bcdA: in std_logic_vector(3 downto 0);
		bcdB: in std_logic_vector (3 downto 0);
		Cin: in std_logic;
		Flag, M: in std_logic;				-- Flag = '0' if addition and'1' if subtraction, M = '1' if bcdA >= bcdB 
		Sum: out std_logic_vector(3 downto 0);		-- M = '0' if bcdA < bcdB
		Cout: out std_logic
		);
end component;
----------------------
component INPUT port (CLK: in std_logic; 			--FSM (sends control signals)
		load,clear: in std_logic;
		S: out std_logic_vector(1 to 3));
end component;
-----------------------
component CTLUNIT is						-- This component determines which operation to perform, depending on
	port (							-- depending on which operand is bigger and the  signs of the operands, converts the integers
		d1: in integer;					-- to digits, then BCD
		d2: in integer;					
		OP: out std_logic;	
		bcd_first: out std_logic_vector(11 downto 0);
		bcd_second: out std_logic_vector (11 downto 0);		
		M : out std_logic_vector (1 to 3);		-- M is specific to each of the three operations performed by DIGITADD
		diff: out std_logic_vector (0 to 1);		--determines which opertions has been done ++,--,+-,-+
		b: out std_logic				--b='0' if d1<d2
);
 end component;
--------------------

component BCD_to_Decimal is					-- converts BCD outputs of the DIGITADD components to integer value
	port (
		bcdA: in std_logic_vector(12 downto 0);	
		dec : out integer
);
end component;
---------------------
component shiftreg is
	 port (
 CLK, CLR: in STD_LOGIC;
 RIN: in std_logic_vector(3 downto 0);
 LIN: in std_logic_vector(3 downto 0);
 S: in std_logic_vector(1 to 3);
 D: in STD_LOGIC_VECTOR (11 downto 0);
 Q: out STD_LOGIC_VECTOR (11 downto 0);
 Q4: out std_logic_vector(3 downto 0)
 );
end component;
---------------------	 
component DFF is
	port(CLK, CLR, D: in std_logic;
		Q, QN: out std_logic;
		S: in std_logic_vector(1 to 3));
end component;
---------------------
component M_shiftreg is
 port (
 CLK, CLR: in STD_LOGIC;
 S: in std_logic_vector(1 to 3);
 D: in STD_LOGIC_VECTOR (1 to 3);
 Q: out STD_LOGIC_VECTOR (1 to 3);
 M: out std_logic
 );
end component;

------------------------------------------------------------------------------------------------------


Begin


U0: CTLUNIT port map (					
			d1 => d1, 
			d2 => d2, 
			bcd_first=>bcd1,
			bcd_second=>bcd2,
			OP => OP, 
			M => M,
			diff=>diff,
			b=>b
);

U1: INPUT port map(
		CLK=>CLK,
		load=>load,
		clear=>clear,
		S=>Sx);						--Sx temporary control signal


process (diff,b)        --determine the sign of the output
begin
	if diff="00" then f(12)<='0';
	else if diff="01" then f(12)<='1';
	else if ((b='0' and diff="11") or (b='1' and diff="10")) then f(12)<='0'; else f(12)<='1'; 
	end if;
	end if;
	end if;
end process;


U2: M_shiftreg port map (
 			CLK=>CLK, CLR=>CLEAR,
 			S=>Sx,
 			D=>M,
 			M=>m_t
 );


U6: DFF port map(
			CLK=>CLK,
			CLR=>CLEAR,
			S=>Sx,
			D=>cout,
			Q=>cin
);
overflow<=cin;

U3: DIGITADD port map (
			bcdA =>Q4A,		
			bcdB =>Q4B, 
			Cin=> cin, 
			Flag => OP,
			M => m_t,
			Sum => Q4sum, 
			Cout => cout
);

U4: shiftreg port map ( 	-- shift register A

 	CLK=>CLK,
	CLR=>CLEAR,
 	RIN=>Q4sum,
 	LIN=>"0000",
 	S=>Sx,
 	D=>bcd1,
 	Q=>f(11 downto 0),  	-- output result will be the parallel output the shift reg. A
 	Q4=>Q4A
 );
U5:	shiftreg port map ( 	-- shift register B

 	CLK=>CLK,
	CLR=>CLEAR,
 	RIN=>"0000",
 	LIN=>"0000",
 	S=>Sx,
 	D=>bcd2,
 	Q=>x1(11 downto 0),
 	Q4=>Q4B
 );



	
U7 : BCD_TO_Decimal port map ( 	--display the decimal value of the operation.
				bcdA => f, 
				dec => dout
);

end bcd_adder_arch;









	
