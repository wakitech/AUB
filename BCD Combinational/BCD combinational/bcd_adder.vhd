library ieee;
use ieee.std_logic_1164.all;

entity bcd_adder is
	port (
		d1,d2 : in integer;
		overflow: out std_logic;
		dout : out integer
		
);
end bcd_adder;

architecture bcd_adder_arch of bcd_adder is
signal diff: std_logic_vector (0 to 1);
signal OP,b:std_logic;					-- OP = '0' for addition and OP = '1' for subtraction
signal C,M: std_logic_vector (1 to 3);			-- C is the intermediary COUT for DIGITADD, M compares each digit of d1 and d2 
signal bcd1,bcd2, bcd2_t, bcd1_t: std_logic_vector (11 downto 0);	
signal f: std_logic_vector (12 downto 0);		-- f is the BCD output, to be converted to integer.

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

component CTLUNIT is						-- This component determines which operation to perform, depending on
	port (							-- depending on which operand is bigger and the  signs of the operands, converts the integers
		d1: in integer;					-- to digits, then BCD, and finally computes the final sign of the output.
		d2: in integer;					
		OP: out std_logic;
		bcd_first: out std_logic_vector(11 downto 0);
		bcd_second: out std_logic_vector (11 downto 0);		
		M : out std_logic_vector (1 to 3);		-- M is specific to each of the three operations performed by DIGITADD
		diff: out std_logic_vector (0 to 1);
		b: out std_logic
);
 end component;


component BCD_to_Decimal is					-- converts BCD outputs of the DIGITADD components to integer value
	port (
		bcdA: in std_logic_vector(12 downto 0);	
		dec : out integer
);
end component;

Begin

U1: CTLUNIT port map (					
			d1 => d1, 
			d2 => d2, 
			bcd_first=>bcd1,
			bcd_second=>bcd2,
			OP => OP, 
			M => M,
			diff=>diff,
			b=>b
);


U2: DIGITADD port map (
			bcdA =>bcd1(3 downto 0), 		
			bcdB => bcd2(3 downto 0), 
			Cin=> '0', 
			Flag => OP,
			M => M(1),
			Sum => f(3 downto 0), 
			Cout => C(1)
);

U3: DIGITADD port map (
			bcdA =>bcd1(7 downto 4), 
			bcdB => bcd2(7 downto 4), 
			Cin=> C(1), 
			Flag => OP, 
			M => M(2), 
			Sum => f(7 downto 4), 
			Cout => C(2)
);

U4: DIGITADD port map (
			bcdA =>bcd1(11 downto 8), 
			bcdB => bcd2(11 downto 8), 
			Cin=>C(2), 
			Flag => OP, 
			M => M(3), 
			Sum => f(11 downto 8), 
			Cout => overflow		
);

process (diff,b)        --determine the sign of the output
begin
	if diff="00" then f(12)<='0';
	else if diff="01" then f(12)<='1';
	else if (b='0' and diff="10") then f(12)<='1'; else f(12)<='0'; 
	end if;
	end if;
	end if;
end process;

	--display the decimal value of the operation.
U5 : BCD_TO_Decimal port map ( 
				bcdA => f, 
				dec => dout
);

end bcd_adder_arch;









	
