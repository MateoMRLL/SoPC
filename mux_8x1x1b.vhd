 -- Fichier : mux_8x1x4b.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8x1x1b is
    Port ( A, B, C, D, E, F, G, H : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR(2 downto 0);
           O : out STD_LOGIC);
end mux_8x1x1b;

architecture Behavioral of mux_8x1x1b is
begin
    process(sel, A, B, C, D, E, F, G, H)
    begin
        -- Utilisation de when else pour la sélection de l'entrée en fonction de S
        O <= A when sel = "000" else
             B when sel = "001" else
             C when sel = "010" else
             D when sel = "011" else
             E when sel = "100" else
             F when sel = "101" else
             G when sel = "110" else
             H;  -- S = "111" et donc H est choisi par défaut
    end process;
end Behavioral;