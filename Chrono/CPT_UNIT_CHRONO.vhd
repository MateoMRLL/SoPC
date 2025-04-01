 -- Fichier : CPT_UNIT_CHRONO.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPT_UNIT_CHRONO is
port (
    CLK : in std_logic;
    R   : in std_logic;
    CE  : in std_logic; 
    TC  : out std_logic;
    S   : out std_logic_vector(3 downto 0)
  );
end CPT_UNIT_CHRONO;


architecture Behavioral of CPT_UNIT_CHRONO is
    signal count : std_logic_vector(3 downto 0) := "0000";
begin
    process (CLK, R)
    begin
        if R = '1' then  -- Asynchronous reset
            count <= "0000";
        elsif rising_edge(CLK) then
            if CE = '1' then
                if count = "1001" then  -- If count reaches 9, reset to 0
                    count <= "0000";
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;
    
    S  <= count;
    TC <= '1' when count = "1001" else '0';
end architecture Behavioral;