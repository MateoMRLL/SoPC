library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_1b_E is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        E     : in  std_logic;
        D     : in  std_logic;
        Q     : out std_logic
    );
end register_1b_E;

architecture Behavioral of register_1b_E is
    signal q_reg : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                q_reg <= '0';
            elsif E = '1' then
                q_reg <= D;
            end if;
        end if;
    end process;

    Q <= q_reg;
end Behavioral;
