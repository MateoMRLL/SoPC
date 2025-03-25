 -- Fichier : counter_3b_E.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter_3b_E is
    Port ( CLK : in  STD_LOGIC;
           CE  : in  STD_LOGIC;
           O   : out STD_LOGIC_VECTOR(3 downto 0));
end counter_3b_E;

architecture Behavioral of counter_3b_E is
    signal count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if CE = '1' then
                count <= count + 1;  -- Incrémentation du compteur
            end if;
        end if;
    end process;
    O <= count;  -- Sortie du compteur
end Behavioral;