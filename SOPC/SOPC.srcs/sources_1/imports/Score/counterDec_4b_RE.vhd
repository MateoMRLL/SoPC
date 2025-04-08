library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counterDec_4b_RE is
    port (
        CLK : in  std_logic;
        R   : in  std_logic;
        CE  : in  std_logic;
        TC  : out std_logic;
        S   : out std_logic_vector(3 downto 0)
    );
end counterDec_4b_RE;

architecture Behavioral of counterDec_4b_RE is
    signal count : std_logic_vector(3 downto 0) := "0000";
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if R = '1' then
                count <= "1111";  -- reset : compteur à 15
            elsif CE = '1' then
                if count /= "0000" then
                    count <= count - 1;
                end if;
            end if;
        end if;
    end process;

    S  <= count;
    TC <= '1' when count = "0000" else '0';

end Behavioral;
