library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
    signal count : unsigned(3 downto 0) := "0000";
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if R = '1' then
                count <= "0000";  -- Reset to 0
            elsif CE = '1' then
                if count = "1001" then
                    count <= "0000";  -- Reset to 0 after reaching 9
                else
                    count <= count + 1;  -- Increment count
                end if;
            end if;
        end if;
    end process;

    S  <= std_logic_vector(count);            -- Output the count
    TC <= '1' when count = "1001" else '0';   -- Terminal count when count = 9

end Behavioral;
