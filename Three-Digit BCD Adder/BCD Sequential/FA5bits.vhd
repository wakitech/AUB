library ieee;
use ieee.std_logic_1164.all;

entity FA5bits is
port(
	A: in std_logic_vector(4 downto 0);
	B: in std_logic_vector(4 downto 0);
	C0: in std_logic;
	S5: out std_logic_vector(4 downto 0);
	C5: out std_logic);
end FA5bits;

architecture FA5bits of FA5bits
 is
component FA
	port( X1: in std_logic; Y1: in std_logic; CIN1: in std_logic;
		S1: out std_logic; COUT1: out std_logic );
end component;

signal C: std_logic_vector(1 to 4);

begin

U1: FA port map (X1=>A(0), Y1=>B(0), CIN1=>C0, S1=>S5(0), COUT1=>C(1));
U2: FA port map (X1=>A(1), Y1=>B(1), CIN1=>C(1), S1=>S5(1), COUT1=>C(2));
U3: FA port map (X1=>A(2), Y1=>B(2), CIN1=>C(2), S1=>S5(2), COUT1=>C(3));
U4: FA port map (X1=>A(3), Y1=>B(3), CIN1=>C(3), S1=>S5(3), COUT1=>C(4));
U5: FA port map (X1=>A(4), Y1=>B(4), CIN1=>C(4), S1=>S5(4), COUT1=>C5);

end FA5bits;
