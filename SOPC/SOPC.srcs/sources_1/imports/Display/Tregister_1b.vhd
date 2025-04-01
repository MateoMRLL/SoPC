-- Fichier : Tregister_1b.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tregister_1b is
    Port ( CLK : in STD_LOGIC;
           T : in STD_LOGIC;
           O : out STD_LOGIC);
end Tregister_1b;

architecture Behavioral of Tregister_1b is
    signal Q : STD_LOGIC := '0';
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if T = '1' then
                Q <= not Q;  -- Inversion de l'état
            end if;
        end if;
    end process;

    O <= Q;
end Behavioral;
