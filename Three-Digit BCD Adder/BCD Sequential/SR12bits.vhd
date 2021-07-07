library IEEE;
use IEEE.std_logic_1164.all;
entity shiftreg is
 port (
 CLK, CLR: in STD_LOGIC;
 RIN: in std_logic_vector(3 downto 0);
 LIN: in std_logic_vector(3 downto 0);
 S: in std_logic_vector(1 to 3);
 D: in STD_LOGIC_VECTOR (11 downto 0);
 Q: out STD_LOGIC_VECTOR (11 downto 0);
 Q4: out std_logic_vector(3 downto 0)
 );
end shiftreg ;

architecture shiftreg of shiftreg is
	signal IQ: std_logic_vector(11 downto 0);
begin
 	process (CLK, CLR, IQ)
 	begin
		Q4<=IQ(3 downto 0);
		if CLR='1' then IQ<=(others =>'0');
 		elsif (CLK'event and CLK = '1') then
 		case S is
 			when "000" => null;
 			when "001" => IQ <= D;
			when "010" => IQ <= RIN & IQ(11 downto 4);
			when "011" => IQ <= IQ(7 downto 0) & LIN;
 			when "100" => IQ <= IQ(0) & IQ(11 downto 1);
 			when "101" => IQ <= IQ(10 downto 0) & IQ(11);
 			When "110" => IQ <= IQ(11) & IQ(11 downto 1);
 			when "111" => IQ <= IQ(10 downto 0) & '0';
 			when others => null;
 		end case;
 		end if;
 	Q <= IQ;
 	end process;
end shiftreg;