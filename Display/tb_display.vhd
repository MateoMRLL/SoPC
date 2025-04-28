library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_display is
end tb_display;

architecture behavior of tb_display is

    -- Déclaration du composant sous test
    component DISPLAY
        port(
            CE_1ms        : in std_logic;
            CE_1s         : in std_logic;
            CLK           : in std_logic;
            data_disp1_L0 : in std_logic_vector(3 downto 0);
            data_disp1_L1 : in std_logic_vector(3 downto 0);
            data_disp1_R0 : in std_logic_vector(3 downto 0);
            data_disp1_R1 : in std_logic_vector(3 downto 0);
            data_disp2_L0 : in std_logic_vector(3 downto 0);
            data_disp2_L1 : in std_logic_vector(3 downto 0);
            data_disp2_R0 : in std_logic_vector(3 downto 0);
            data_disp2_R1 : in std_logic_vector(3 downto 0);
            AN            : out std_logic_vector(7 downto 0);
            LEDS          : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signaux
    signal CE_1ms        : std_logic := '0';
    signal CE_1s         : std_logic := '0';
    signal CLK           : std_logic := '0';
    signal data_disp1_L0 : std_logic_vector(3 downto 0) := "0000"; -- 0
    signal data_disp1_L1 : std_logic_vector(3 downto 0) := "0001"; -- 1
    signal data_disp1_R0 : std_logic_vector(3 downto 0) := "0010"; -- 2
    signal data_disp1_R1 : std_logic_vector(3 downto 0) := "0011"; -- 3
    signal data_disp2_L0 : std_logic_vector(3 downto 0) := "0100"; -- 4
    signal data_disp2_L1 : std_logic_vector(3 downto 0) := "0101"; -- 5
    signal data_disp2_R0 : std_logic_vector(3 downto 0) := "0110"; -- 6
    signal data_disp2_R1 : std_logic_vector(3 downto 0) := "0111"; -- 7
    signal AN            : std_logic_vector(7 downto 0);
    signal LEDS          : std_logic_vector(7 downto 0);

    -- Constante de période d'horloge
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instanciation du composant DISPLAY
    uut: DISPLAY
        port map (
            CE_1ms        => CE_1ms,
            CE_1s         => CE_1s,
            CLK           => CLK,
            data_disp1_L0 => data_disp1_L0,
            data_disp1_L1 => data_disp1_L1,
            data_disp1_R0 => data_disp1_R0,
            data_disp1_R1 => data_disp1_R1,
            data_disp2_L0 => data_disp2_L0,
            data_disp2_L1 => data_disp2_L1,
            data_disp2_R0 => data_disp2_R0,
            data_disp2_R1 => data_disp2_R1,
            AN            => AN,
            LEDS          => LEDS
        );

    -- Génération de l'horloge principale
    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    -- Génération du CE_1ms (tic toutes les 1 ms)
    ce_1ms_process : process
    begin
        while true loop
            CE_1ms <= '0';
            wait for 950 ns;
            CE_1ms <= '1';
            wait for 50 ns;
        end loop;
    end process;

    -- Génération du CE_1s (tic toutes les 1 seconde simulée)
    ce_1s_process : process
    begin
        while true loop
            CE_1s <= '0';
            wait for 950000 ns; -- Presque 1 ms * 1000
            CE_1s <= '1';
            wait for 50000 ns; -- petite impulsion haute
        end loop;
    end process;

    -- Stimulus sur les entrées
    stim_proc : process
    begin
        wait for 10 ms; -- Attendre un peu

        -- Modifier quelques entrées pour vérifier que les LEDS changent
        data_disp1_L0 <= "1000"; -- 8
        data_disp1_L1 <= "1001"; -- 9
        data_disp1_R0 <= "1010"; -- A (en hexadécimal, 10)
        data_disp1_R1 <= "1011"; -- B (11)
        data_disp2_L0 <= "1100"; -- C (12)
        data_disp2_L1 <= "1101"; -- D (13)
        data_disp2_R0 <= "1110"; -- E (14)
        data_disp2_R1 <= "1111"; -- F (15)

        wait for 10 ms;

        -- Fin de la simulation
        wait;
    end process;

end behavior;

