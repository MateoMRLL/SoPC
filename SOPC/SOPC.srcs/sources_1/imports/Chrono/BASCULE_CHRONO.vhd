library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BASCULE_CHRONO is
    port (
        CLK : in std_logic;
        R   : in std_logic;
        D   : in std_logic;
        Q   : out std_logic
    );
end entity BASCULE_CHRONO;

architecture Behavioral of BASCULE_CHRONO is
begin
    process (CLK, R)
    begin
        if R = '1' then  -- Asynchronous reset
            Q <= '0';
        elsif rising_edge(CLK) then
            Q <= D;
        end if;
    end process;
end architecture Behavioral;
