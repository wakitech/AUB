library ieee;
use ieee.std_logic_1164.all;

entity DIGITADD is
	port(
		bcdA: in std_logic_vector(3 downto 0);
		bcdB: in std_logic_vector (3 downto 0);
		Cin: in std_logic;
		Flag, M: in std_logic;
		Sum: out std_logic_vector(3 downto 0);
		Cout: out std_logic
);
end DIGITADD;

architecture DIGITADD of DIGITADD is

component FA4bits is

	port( 
		A: in std_logic_vector (3 downto 0); 
		B: in std_logic_vector (3 downto 0);
		C0: in std_logic; 
		S4: out std_logic_vector (3 downto 0);
		C4: out STD_LOGIC
);
end component;


component two_compl is						-- this component takes X as bcdB and F as Flag, if Flag = '1', then bcdB
	port(							-- is complemented, otherwise it remains the same.
		X: in std_logic_vector (3 downto 0);
		F: in std_logic;
		Y: out std_logic_vector (3 downto 0)
);
end component;						


signal bcdA2,bcdA3,bcdA4, bcdB2, B1: std_logic_vector(3 downto 0); 		-- bcdA2 : bcdA - borrow in case of a borrow | bcdB2 : 2's complement of B
signal sADD, sSUB1, sSUB2: std_logic_vector (3 downto 0);	-- sADD : when adding | sSUB1 : when subtracting with bcdA > bcdB | sSUB2: when subtracting with bcdA < bcdB
signal V, V2: std_logic_vector (3 downto 0);			-- V : +0110, when addition presents an overflow | V2: +1010, when the subtrahend is bigger than the minuend
signal corr, Cout2, Cout3, Cout4, NB, cout5, bigger : std_logic;		-- NB and Cout3 are ignored.
signal borrow, carry, carry1 : std_logic;
signal corrBorrow: std_logic;		

BEGIN


process (Cin, borrow, carry, Flag)
begin
	if ( Flag = '0') then 
		carry <= Cin; 
		borrow <= '0';

	elsif (Flag = '1') then 
		carry <= '0'; 
		borrow <= Cin;

	end if;
end process;

	
	corrBorrow<='1' when (((bcdA=bcdB and borrow='1') or (bcdA="0000" and borrow='1')) and flag='1') else '0';
	--if corrBorrow='1' will do a correction resulting from the borrowing if two
	--digits are equal.
						
	B1<="1111" when borrow='1' else "0000";	     --adding "1111" results in a substraction of 1 if there is borrowing
	U0: FA4bits port map( A=>bcdA, B=>B1, C0=>'0', S4=>bcdA3, C4=>NB);
	
	U1 : two_compl port map (X => bcdB, F => Flag, Y => bcdB2) ; -- complementing B if Flag = '1' (substraction)

	bcdA2<="1001" when (bcdA="0000" and borrow='1') else bcdA3; --when we borrow from 0, 0 will go to 9. (10-1)

	U3 : FA4bits port map ( A => bcdA2, B => bcdB2, C0 => carry, S4 => sSUB1, C4 => Cout2); 	-- adding A + B

corr <= (sSUB1(3) AND sSUB1(2)) OR (sSUB1(3) AND sSUB1(1)) OR (Cout2);  		-- since we have bcd digits, overflow occurs when we have                  
										-- "1d1d", "11dd" or cout = 1 ( d: don't care). corr = '1' when we have overflow
	V <= "0110" when corr = '1' else "0000";						-- and '0' if not.
	U4 : FA4bits port map ( A => V, B => sSUB1, C0 => '0', S4 => sADD, C4 => Cout3);	-- adding correction value of 0110 for addition

	V2 <= "1010" when m='0' or corrBorrow='1' else "0000";	 --adding correction value for 1010 for substraction
	U5 : FA4bits port map ( A => V2 , B => sSUB1, C0 => '0', S4 => sSUB2, C4 => Cout4);


process (Flag, M, sSUB1, sSUB2, sADD)	-- choosing needed value for the final sum according to inputs
begin				

if (Flag = '0') then 

	Sum <= sADD; 
	Cout <= corr;

else if (Flag = '1') then 

	if (M = '1' and corrBorrow/='1') then 
		Sum <= sSUB1;
		cout<='0';
	else
		Sum <= sSUB2;
		cout<='1';
	end if;

end if;
end if;
end process;


end DIGITADD;












