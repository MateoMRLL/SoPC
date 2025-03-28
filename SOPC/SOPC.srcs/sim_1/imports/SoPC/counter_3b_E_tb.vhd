LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY counter_3b_E_tb IS
END counter_3b_E_tb;

ARCHITECTURE behavior OF counter_3b_E_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT counter_3b_E
    PORT(
         CLK : IN  std_logic;
         CE  : IN  std_logic;
         O   : OUT std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    
    -- Signals for simulation
    SIGNAL CLK : std_logic := '0';
    SIGNAL CE  : std_logic := '0';
    SIGNAL O   : std_logic_vector(2 downto 0);
    
    -- Clock period definition
    CONSTANT CLK_PERIOD : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: counter_3b_E PORT MAP (
          CLK => CLK,
          CE  => CE,
          O   => O
        );

    -- Clock process definitions
    clk_process :process
    begin
        while now < 200 ns loop  -- Run for 200 ns
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin	    
        -- Hold reset state for a few clock cycles
        wait for 20 ns;
        
        -- Enable counting
        CE <= '1';
        wait for 80 ns;
        
        -- Disable counting
        CE <= '0';
        wait for 40 ns;
        
        -- Enable counting again
        CE <= '1';
        wait for 60 ns;
        
        -- Stop simulation
        wait;
    end process;

END behavior;