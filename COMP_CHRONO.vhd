library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity COMP_CHRONO is
  port (
    in1 : in std_logic_vector(3 downto 0);
    in2 : in std_logic_vector(3 downto 0);
    S   : out std_logic
  );
end entity COMP_CHRONO;

architecture Behavioral of COMP_CHRONO is 
  signal result : std_logic : '0'; 
begin 
  if in1 = "0101" and in2 = "0100" then 
    S <= '1'; 
  else 
  S <= '0'; 
  end if; 
end architecture Behavioral; 