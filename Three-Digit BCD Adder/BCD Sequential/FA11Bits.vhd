library ieee;
use ieee.std_logic_1164.all;

entity FA12bits is
port(
	A: in std_logic_vector(11 downto 0);
	B: in std_logic_vector(11 downto 0);
	C0: in std_logic;
	S13: out std_logic_vector(12 downto 0);
	C13: out std_logic);
end FA12bits;

architecture FA12bits of FA12bits
 is
component FA
	port( X1: in std_logic; Y1: in std_logic; CIN1: in std_logic;
		S1: out std_logic; COUT1: out std_logic );
end component;

signal C: std_logic_vector(0 to 13);

begin
C(0)<=C0;
--repeated this 12 times manually 
--because of an unresolved compiling error for 'generate'
U1: FA port map (X1=>A(0), Y1=>B(0), CIN1=> C(0), S1=>S13(0),COUT1=>C(1));
U2: FA port map (X1=>A(1), Y1=>B(1), CIN1=> C(1), S1=>S13(1),COUT1=>C(2));
U3: FA port map (X1=>A(2), Y1=>B(2), CIN1=> C(2), S1=>S13(2),COUT1=>C(3));
U4: FA port map (X1=>A(3), Y1=>B(3), CIN1=> C(3), S1=>S13(3),COUT1=>C(4));
U5: FA port map (X1=>A(4), Y1=>B(4), CIN1=> C(4), S1=>S13(4),COUT1=>C(5));
U6: FA port map (X1=>A(5), Y1=>B(5), CIN1=> C(5), S1=>S13(5),COUT1=>C(6));
U7: FA port map (X1=>A(6), Y1=>B(6), CIN1=> C(6), S1=>S13(6),COUT1=>C(7));
U8: FA port map (X1=>A(7), Y1=>B(7), CIN1=> C(7), S1=>S13(7),COUT1=>C(8));
U9: FA port map (X1=>A(8), Y1=>B(8), CIN1=> C(8), S1=>S13(8),COUT1=>C(9));
U10: FA port map (X1=>A(9), Y1=>B(9), CIN1=> C(9), S1=>S13(9),COUT1=>C(10));
U11: FA port map (X1=>A(10), Y1=>B(10), CIN1=> C(10), S1=>S13(10),COUT1=>C(11));
U12: FA port map (X1=>A(11), Y1=>B(11), CIN1=> C(11), S1=>S13(11),COUT1=>C(12));
U13: FA port map (X1=>'0', Y1=>'1', CIN1=> C(12), S1=>S13(12),COUT1=>C(13));

C13<=C(13);


end FA12bits;
