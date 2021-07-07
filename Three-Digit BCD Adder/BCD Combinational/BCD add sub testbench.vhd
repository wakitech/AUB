library ieee;
use ieee.std_logic_1164.all;

entity a_BCD_test is
end a_BCD_test;

architecture test_arch of a_BCD_test is
component bcd_adder is
port (
		d1,d2 : in integer;
		overflow: out std_logic;
		dout : out integer
		
);
end component;
	signal d1,d2: integer;
	signal overflow: std_logic;
	signal dout: integer;
	
begin
uut: bcd_adder
port map(d1=>d1, d2=>d2, overflow=>overflow, dout=>dout);

process
begin

d1<=0; 
d2<=0; wait for 10 ns;
d1<=1; wait for 10 ns;

d1<=123; d2<=345; wait for 10 ns;

d1<=234; d2<=567; wait for 10 ns;
d1<=789; d2<=777; wait for 10 ns;
d1<=999; d2<=999; wait for 10 ns;

d1<=0; d2<=-0; wait for 10 ns;
d1<=0; d2<=-1; wait for 10 ns;
d1<=345; d2<=-123; wait for 10 ns;
d1<=567; d2<=-234; wait for 10 ns;
d1<=394; d2<=-452; wait for 10 ns;
d1<=-1; d2<=-1; wait for 10 ns;
d1<=777; d2<=-789; wait for 10 ns;
d1<=999; d2<=-999; wait for 10 ns;
d1<=-123; d2<=-432; wait for 10 ns;
d1<=102; d2<=-432; wait for 10 ns;
d1<=100; d2<=-179; wait for 10 ns;
d1<=-453; d2<=119; wait for 10 ns;
d1<=342; d2<=-798; wait for 10 ns;
d1<=199; d2<=-298; wait for 10 ns;
wait;
end process;

end test_arch;

