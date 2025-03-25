 -- Fichier : mux_8x1x4b.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8x1x4b is
    Port ( A, B, C, D, E, F, G, H : in  STD_LOGIC_VECTOR(3 downto 0);
           S : in  STD_LOGIC_VECTOR(2 downto 0);
           O : out STD_LOGIC_VECTOR(3 downto 0));
end mux_8x1x4b;

architecture Behavioral of mux_8x1x4b is
begin
    process(S, A, B, C, D, E, F, G, H)
    begin
        -- Utilisation de when else pour la sélection de l'entrée en fonction de S
        O <= A when S = "000" else
             B when S = "001" else
             C when S = "010" else
             D when S = "011" else
             E when S = "100" else
             F when S = "101" else
             G when S = "110" else
             H;  -- S = "111" et donc H est choisi par défaut
    end process;
end Behavioral;