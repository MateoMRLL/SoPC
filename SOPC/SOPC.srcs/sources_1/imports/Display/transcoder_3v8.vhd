-- Fichier : transcoder_3v8.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity transcoder_3v8 is
    Port ( A : in STD_LOGIC_VECTOR(2 downto 0);
           O : out STD_LOGIC_VECTOR(7 downto 0));
end transcoder_3v8;

architecture Behavioral of transcoder_3v8 is
begin
        -- Utilisation de when else pour la conversion
        O <= "00000001" when A = "000" else
             "00000010" when A = "001" else
             "00000100" when A = "010" else
             "00001000" when A = "011" else
             "00010000" when A = "100" else
             "00100000" when A = "101" else
             "01000000" when A = "110" else
             "10000000";  -- Cas pour A = "111"
end Behavioral;