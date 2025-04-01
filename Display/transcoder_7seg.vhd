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
        O <= "0000001" when A = "0000" else  -- "0"
             "1001111" when A = "0001" else  -- "1"
             "0010010" when A = "0010" else  -- "2"
             "0000110" when A = "0011" else  -- "3"
             "1001100" when A = "0100" else  -- "4"
             "0100100" when A = "0101" else  -- "5"
             "0100000" when A = "0110" else  -- "6"
             "0001111" when A = "0111" else  -- "7"
             "0000000" when A = "1000" else  -- "8"
             "0000100" when A = "1001" else  -- "9"
             "1111111"; -- Valeur par défaut en cas d'erreur ou valeur invalide
end Behavioral;