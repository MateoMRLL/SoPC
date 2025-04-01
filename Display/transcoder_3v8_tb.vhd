--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Esteban Aussant, Rémi de Pretto
--
-- Create Date:   08:41:30 02/16/2024
-- Design Name:   
-- Module Name:   C:/CPE_USERS/TPELEC_3ETI/GR_B/Equipe_1/chronoscore_phase1/transcoder_3v8_tb.vhd
-- Project Name:  chronoscore_phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: transcoder_3v8
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY transcoder_3v8_tb IS
END transcoder_3v8_tb;
 
ARCHITECTURE behavior OF transcoder_3v8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT transcoder_3v8
    PORT(
         A : IN  std_logic_vector(2 downto 0);
         O : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: transcoder_3v8 PORT MAP (
          A => A,
          O => O
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		A<="000";
		wait for 20 ns;	
		A<="001";
		wait for 20 ns;	
		A<="010";
		wait for 20 ns;	
		A<="011";
		wait for 20 ns;	
		A<="100";
		wait for 20 ns;	
		A<="101";
		wait for 20 ns;	
		A<="110";
		wait for 20 ns;	
		A<="111";
		
		
--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
