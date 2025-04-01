 -- Fichier : CPT_DEC_CHRONO.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPT_DEC_CHRONO is
port (
    CLK : in std_logic;
    R   : in std_logic;
    CE  : in std_logic; 
    TC  : out std_logic;
    S   : out std_logic_vector(3 downto 0)
  );
end CPT_DEC_CHRONO;


architecture Behavioral of CPT_DEC_CHRONO is
    signal count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(CLK, R)
    begin
      if R = '1' then
        count <= '0000'; 
        elsif rising_edge(CLK) then
            if CE = '1' then
              if count = '0101' then 
                count <= '0000'; 
              else 
                count <= count + 1;  -- Incrémentation du compteur
            end if;
          end if; 
        end if;
    end process;
    S <= count;  -- Sortie du compteur
    TC <= '1' when count = "0101" else '0';
end Behavioral;