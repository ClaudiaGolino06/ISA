library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity read_input is
  port(
    CLK    	 : in std_logic;
    RST_n  	 : in std_logic;
    VOUT   	 : out std_logic_vector(2 downto 0);
    DOUT_1   : out std_logic_vector(13 downto 0);
	DOUT_2   : out std_logic_vector(13 downto 0);
	DOUT_3   : out std_logic_vector(13 downto 0);
    B0     	 : out std_logic_vector(13 downto 0);
    B1     	 : out std_logic_vector(13 downto 0);
    B2     	 : out std_logic_vector(13 downto 0);
    B3     	 : out std_logic_vector(13 downto 0);
    B4     	 : out std_logic_vector(13 downto 0));
end read_input;

architecture beh of read_input is

begin 
  B0 <= conv_std_logic_vector(-51, 14);
  B1 <= conv_std_logic_vector(-112, 14);
  B2 <= conv_std_logic_vector(419, 14);
  B3 <= conv_std_logic_vector(2176, 14);
  B4 <= conv_std_logic_vector(3323, 14);

  process(CLK, RST_n)
    file fp_in : text open READ_MODE is "./sim/samples.txt";
    variable line_in_1,line_in_2,line_in_3 : line;
    variable x_1, x_2,x_3 : integer;
  begin
    if RST_n = '0' then
      DOUT_1 <= (others => '0') after 1 ns;
	  DOUT_2 <= (others => '0') after 1 ns;
	  DOUT_3 <= (others => '0') after 1 ns;
      VOUT(0) <= '0' after 1 ns;
	  VOUT(1) <= '0' after 1 ns;
	  VOUT(2) <= '0' after 1 ns;
    elsif CLK'event and CLK = '1' then 
      if not endfile(fp_in) then
        readline(fp_in, line_in_1);
        read(line_in_1, x_1);
        DOUT_1 <= conv_std_logic_vector(x_1, 14) after 1 ns;
		VOUT(0) <= '1' after 1 ns;
		if not endfile(fp_in) then
        	readline(fp_in, line_in_2);
        	read(line_in_2, x_2);
        	DOUT_2 <= conv_std_logic_vector(x_2, 14) after 1 ns;
			VOUT(1) <= '1' after 1 ns; 
		
			if not endfile(fp_in) then
        		readline(fp_in, line_in_3);
        		read(line_in_3, x_3);
        		DOUT_3 <= conv_std_logic_vector(x_3, 14) after 1 ns;
				VOUT(2) <= '1' after 1 ns;  
			else 
				VOUT(2) <= '0' after 1 ns;
			end if;
		else 
			VOUT(1) <= '0' after 1 ns; 
			VOUT(2) <= '0' after 1 ns;
		end if;      
	  else
        VOUT(0) <= '0' after 1 ns;
	  	VOUT(1) <= '0' after 1 ns; 
	  	VOUT(2) <= '0' after 1 ns;
      end if;
    end if;
  end process;

end beh;

