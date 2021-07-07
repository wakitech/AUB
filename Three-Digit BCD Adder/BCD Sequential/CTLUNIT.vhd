library ieee;
use ieee.std_logic_1164.all;
                                                       --this unit is the brain of the bcd adder_subs.
entity CTLUNIT is
	port(
		d1: in integer;					
		d2: in integer;
		OP: out std_logic;
		bcd_first: out std_logic_vector(11 downto 0);
		bcd_second: out std_logic_vector (11 downto 0);	
		M : out std_logic_vector (1 to 3);  --store if each digit is bigger/smaller than the other digit in the operation
		diff: out std_logic_vector (0 to 1);--diff="00" for addition of two +, diff=01 for addition of two (-) ,diff=10 for addition of != signs numbers
		b:out std_logic                     -- b='0' is bcd_first<bcd_second
);
end CTLUNIT;

architecture CTLUNIT_arch of CTLUNIT is
component decimal3_to_bcd4 is
	port (
		dc : in integer;
		s: out std_logic;
		bcd: out std_logic_vector(11 downto 0)
);
end component;
component FA5bits is 
	port (
		A: in std_logic_vector(4 downto 0);
		B: in std_logic_vector(4 downto 0);
		C0: in std_logic;
		S5: out std_logic_vector(4 downto 0);
		C5: out std_logic);
end component;
component FA12bits is
port(
	A: in std_logic_vector(11 downto 0);
	B: in std_logic_vector(11 downto 0);
	C0: in std_logic;
	S13: out std_logic_vector(12 downto 0);
	C13: out std_logic);
end component;

signal s_1,s_2,bx,x,x1: std_logic;               --x and x1 are couts, s_1 and s_2 for the signs of the two operands
signal invert:std_logic;                         --if bcd_first<bcd_second it is a substraction->invert the operands and flip the sign at the end
signal diffx: std_logic_vector(0 to 1);         --diff points out the operation being perfomed ( (+) + (+) ) or ( (-) + (-) ) or ( (+) + (-) / (-) + (+) )
signal bcd_first1, bcd_second1, B_not1: std_logic_vector(11 downto 0);
signal sum12: std_logic_vector(12 downto 0);
signal sum1,sum2,sum3: std_logic_vector(4 downto 0);
signal B_not: std_logic_vector(14 downto 0);	--used to compare each digit in binary adding a '0' at the start of each 4 bit  binary digit for two's comp.
signal M_t1,M_t2: std_logic_vector(1 to 3);     --used as temporary signals to store if each digit is bigger/smaller than the other digit in the operation
signal newsignal1, newsignal2: std_logic_vector(14 downto 0); --used in comparing each digit with an additional '0' for two's comp


begin
	
	u0: decimal3_to_bcd4 port map(dc=>d1, s=>s_1, bcd=>bcd_first1);
	u1: decimal3_to_bcd4 port map(dc=>d2, s=>s_2, bcd=>bcd_second1);

	newsignal1( 3 downto 0) <= bcd_first1( 3 downto 0 );
	newsignal1( 8 downto 5 ) <= bcd_first1( 7 downto 4 );
	newsignal1( 13 downto 10 ) <= bcd_first1( 11 downto 8 );
	newsignal1(4) <= '0'; newsignal1(9) <= '0'; newsignal1(14) <= '0';   --"0xxxx0xxxx0xxxx"

	newsignal2( 3 downto 0 ) <= bcd_second1( 3 downto 0 );
	newsignal2( 8 downto 5 ) <= bcd_second1( 7 downto 4 );
	newsignal2( 13 downto 10 ) <= bcd_second1( 11 downto 8 );
	newsignal2(4) <= '0' ; newsignal2(9) <= '0'; newsignal2(14) <= '0';
	
	B_not<=not newsignal2;

	--substracting using two's comp ( need of 5bits adder )
	--to compare each two digits
	u2: FA5bits port map (A=>newsignal1(4 downto 0),B=>B_not(4 downto 0),C0=>'1',S5=>sum1,C5=>x);
	u3: FA5bits port map (A=>newsignal1(9 downto 5),B=>B_not(9 downto 5),C0=>'1',S5=>sum2,C5=>x);
	u4: FA5bits port map (A=>newsignal1(14 downto 10),B=>B_not(14 downto 10),C0=>'1',S5=>sum3,C5=>x);

	--if sum(4)='1' then (digit1A-digit1B) < 0 -> digit1A<digit1B
	M_t1(1)<=not sum1(4);
	M_t1(2)<=not sum2(4);
	M_t1(3)<=not sum3(4);

	B_not1<=not bcd_second1; --complement bcd_second

	--to compare the two numbers; if x1='1' then bcd_first1>bcd_second1

	u5: FA12Bits port map(A=>bcd_first1,B=>B_not1,C0=>'1', S13=>sum12, C13=>x1);

	bx<=not sum12(12); --if bx='1' bcd_first1>bcd_second1 else '0'

process(s_1, s_2) --check the operation
begin
	if (s_1=s_2) then OP<='0'; else OP<='1';end if;
	if (s_1='0' and s_2='0') then diffx<="00"; else if (s_1='0' and s_2='1') then diffx<="10";
	else if (s_1='1' and s_2='0') then diffx<="11"; else diffx<="01";end if;
							end if;
	end if;
end process;

	invert<='1' when bx='0' and (diffx="10" or diffx="11") else '0'; --will use invert to swap the two operand to substract the smaller number
							 -- from the greater in a substraction

	bcd_first<=bcd_second1 when invert='1' else bcd_first1;
	bcd_second<=bcd_first1 when invert='1' else bcd_second1;

	process(invert, bcd_first1,bcd_second1, M_t1)
	begin
		if invert='1' then         --when invertion, change for each pair of digits who is bigger or smaller than the other.
			if bcd_first1(3 downto 0)=bcd_second1(3 downto 0) then M_t2(1)<='1'; else M_t2(1)<=not M_t1(1);end if;
			if bcd_first1(7 downto 4)=bcd_second1(7 downto 4) then M_t2(2)<='1'; else M_t2(2)<=not M_t1(2);end if;
			if bcd_first1(11 downto 8)=bcd_second1(11 downto 8) then M_t2(3)<='1'; else M_t2(3)<=not M_t1(3);end if;
		else M_t2<=M_t1; --don't invert everything is normal
		end if;
	end process;

	M<=M_t2;
	b<=bx;
	diff<=diffx;	



end CTLUNIT_arch;