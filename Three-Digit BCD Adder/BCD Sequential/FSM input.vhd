
library IEEE;
use ieee.std_logic_1164.all;

entity INPUT is
	port (CLK: in std_logic;
		load,clear: in std_logic;
		S: out std_logic_vector(1 to 3));
end INPUT;


architecture INPUT_arch of INPUT is

signal S_t: std_logic_vector(1 to 3);
signal count: integer:=0;
begin

process (CLK, load, clear)
begin

if CLK'event AND CLK = '1' then
	if clear='1' then S<="000"; --suspend everything
	else
		if load='1' then S_t<="000";count<=count+1;                      --just before loading

		else if count=2 or count=3 then S_t<="001";count<=count+1;       --loading

		else count<=count+1;S_t<="010";  --shifting 

			 if count>6 then count<=0;S_t<="000";end if;             --shifting at most 3 times then stop
			end if;
		end if;
	end if;
	S<=S_t;
end if;
end process;

end INPUT_arch;