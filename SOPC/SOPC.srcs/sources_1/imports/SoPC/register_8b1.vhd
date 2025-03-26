-- Fichier : register_8b1.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8b1 is
    Port ( CLK : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(7 downto 0);
           O : out STD_LOGIC_VECTOR(7 downto 0));
end register_8b1;

architecture Behavioral of register_8b1 is
    signal Q : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            Q <= D;  -- Chargement de D dans le registre
        end if;
    end process;

    O <= Q;
end Behavioral;
