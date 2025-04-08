-- Fichier : transcoder_7seg.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity transcoder_7seg is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           O : out STD_LOGIC_VECTOR(6 downto 0));  -- 7 segments
end transcoder_7seg;

architecture Behavioral of transcoder_7seg is
begin

        O <=  "1000000" when A = "0000" else -- NOT 0111111 → "1000000"
      "1111001" when A = "0001" else -- NOT 0000110 → "1111001"
      "0100100" when A = "0010" else -- NOT 1011011 → "0100100"
      "0110000" when A = "0011" else -- NOT 1001111 → "0110000"
      "0011001" when A = "0100" else -- NOT 1100110 → "0011001"
      "0010010" when A = "0101" else -- NOT 1101101 → "0010010"
      "0000010" when A = "0110" else -- NOT 1111100 → "0000011"
      "1111000" when A = "0111" else -- NOT 1000111 → "0111000"
      "0000000" when A = "1000" else -- NOT 1101111 → "0010000"
      "0010000" when A = "1001" else -- NOT 1111001 → "0000110"
      "0000110";                     -- Valeur d'erreur (NOT 1111001)

end Behavioral;