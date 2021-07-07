
library IEEE;
use IEEE.std_logic_1164.all;
entity M_shiftreg is
 port (
 CLK, CLR: in STD_LOGIC;
 S: in std_logic_vector(1 to 3);
 D: in STD_LOGIC_VECTOR (1 to 3);
 Q: out STD_LOGIC_VECTOR (1 to 3);
 M: out std_logic
 );
end M_shiftreg ;

architecture M_shiftreg of M_shiftreg is
	signal IQ: std_logic_vector(1 to 3);
begin
 	process (CLK, CLR, IQ)
 	begin
		M<=IQ(1);
 		if CLR = '1' then IQ<=(others=>'0');
 		elsif (CLK'event and CLK = '1') then
 		case S is
 			when "000" => null;
 			when "001" => IQ <= D;
			when "010" => IQ <= IQ(2 to 3)&'1';
 			when others => null;
 		end case;
 		end if;
 	Q <= IQ;
 	end process;
end M_shiftreg;