library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR_2b is
    Port (
        A : in  std_logic;
        B : in  std_logic;
        Y : out std_logic
    );
end XOR_2b;

architecture Behavioral of XOR_2b is
begin
    Y <= A xor B;
end Behavioral;
