LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY transcoder_3v8_tb IS
END transcoder_3v8_tb;

ARCHITECTURE behavior OF transcoder_3v8_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT transcoder_3v8
    PORT(
         A : IN  std_logic_vector(2 downto 0);
         O : OUT std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
    -- Signals for simulation
    SIGNAL A : std_logic_vector(2 downto 0) := "000";
    SIGNAL O : std_logic_vector(7 downto 0);
    
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: transcoder_3v8 PORT MAP (
          A => A,
          O => O
        );

    -- Stimulus process
    stim_proc: process
    begin	    
        -- Test all possible values of A
        A <= "000"; wait for 10 ns;
        A <= "001"; wait for 10 ns;
        A <= "010"; wait for 10 ns;
        A <= "011"; wait for 10 ns;
        A <= "100"; wait for 10 ns;
        A <= "101"; wait for 10 ns;
        A <= "110"; wait for 10 ns;
        A <= "111"; wait for 10 ns;
        
        -- Stop simulation
        wait;
    end process;

END behavior;
