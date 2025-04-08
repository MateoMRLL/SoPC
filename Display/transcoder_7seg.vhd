-- Fichier : transcoder_7seg.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity transcoder_7seg is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           O : out STD_LOGIC_VECTOR(6 downto 0));  -- 7 segments
end transcoder_7seg;

architecture Behavioral of transcoder_7seg is
begin

        -- Utilisation de when else pour les différentes valeurs possibles
       O <= "1111110" when A = "0000" else  -- "0" => not "0000001"
     "0110000" when A = "0001" else  -- "1" => not "1001111"
     "1101101" when A = "0010" else  -- "2"
     "1111001" when A = "0011" else  -- "3"
     "0110011" when A = "0100" else  -- "4"
     "1011011" when A = "0101" else  -- "5"
     "1011111" when A = "0110" else  -- "6"
     "1110000" when A = "0111" else  -- "7"
     "1111111" when A = "1000" else  -- "8"
     "1111011" when A = "1001" else  -- "9"
     "0000000"; -- défaut inversé de "1111111"

end Behavioral;