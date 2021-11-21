library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_unsigned.all;
use WORK.constants.all;
use WORK.my_data_types.all; 

ENTITY reg IS
   GENERIC (Nb : INTEGER := Numbit;
			s  : INTEGER := shift);
   PORT
   (
      d : 				IN  STD_LOGIC_VECTOR (Nb-1-s downto 0); 
	  clk, en, clr : 	IN  STD_LOGIC;
      Q : 				OUT STD_LOGIC_vector (Nb-1-s downto 0)
   );
END reg;

ARCHITECTURE behavior OF reg IS
BEGIN
   PROCESS (clk,clr,en)		--asynchronous reset
   BEGIN		
		IF clr = '0' THEN
			Q <=(others => '0');
		ELSIF ( clk'EVENT and clk='1' and en = '1') THEN
			Q <= d;
		END IF; 
	END PROCESS;
END ARCHITECTURE;

