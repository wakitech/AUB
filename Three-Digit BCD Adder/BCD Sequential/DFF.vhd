library IEEE;
use ieee.std_logic_1164.all;

entity DFF is
	port (CLK, CLR, D: in std_logic;
		Q, QN: out std_logic;
		S:in std_logic_vector(1 to 3));
end DFF;

architecture DFF_arch of DFF is

begin

process (CLK, CLR, S)

begin

if CLR ='1' then
	Q <= '0' ; QN <= '1';

elsif CLK'event AND CLK = '1' then
	if S="001" then Q<='0'; QN<='1'; else Q <= D; QN <= NOT D; 
	end if;

end if;
end process;

end DFF_arch;
