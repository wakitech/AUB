library ieee;
use ieee.std_logic_1164.all;

entity a_BCD_test_seq is
end a_BCD_test_seq;

architecture test_arch of a_BCD_test_seq is
component bcd_adder is
port (
		d1,d2 : in integer;
		clk: in std_logic;
		overflow: out std_logic;
		load,clear: in std_logic;
		dout : out integer
		
);
end component;
	signal d1,d2: integer;
	signal overflow: std_logic;
	signal clk,clear,load: std_logic;
	signal dout: integer;
	
begin
uut: bcd_adder
port map(d1=>d1, d2=>d2,clk=>clk, overflow=>overflow, dout=>dout,load=>load,clear=>clear);

process
begin
clear<='0';
load<='1';
clk<='1'; 
d1<=789; d2<=777; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;


load<='1';
clk<='1'; 
d1<=789; d2<=-777; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=0; d2<=0; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=102; d2<=-298; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=-342; d2<=211; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=-564; d2<=6; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=187; d2<=-921; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;



load<='1';
clk<='1'; 
d1<=123; d2<=321; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=-432; d2<=-223; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=455; d2<=-450; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=999; d2<=-999; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=999; d2<=999; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=1; d2<=1; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=789; d2<=777; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;

load<='1';
clk<='1'; 
d1<=-1; d2<=-1; 
wait for 50 ns;
load<='0';
clk<='0';wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
clk<=not clk;wait for 50 ns;
wait;
end process;

end test_arch;

