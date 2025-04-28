library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_score is
end tb_score;

architecture behavior of tb_score is

    -- Déclaration du composant sous test
    component SCORE
        port(
            CE_1ms   : in std_logic;
            CLK      : in std_logic;
            BPL      : in std_logic;
            BPreset  : in std_logic;
            BPV      : in std_logic;
            Loc_unit : out std_logic_vector(3 downto 0);
            Loc_dec  : out std_logic_vector(3 downto 0);
            Vis_unit : out std_logic_vector(3 downto 0);
            Vis_dec  : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Déclaration des signaux
    signal CE_1ms   : std_logic := '0';
    signal CLK      : std_logic := '0';
    signal BPL      : std_logic := '0';
    signal BPreset  : std_logic := '0';
    signal BPV      : std_logic := '0';
    signal Loc_unit : std_logic_vector(3 downto 0);
    signal Loc_dec  : std_logic_vector(3 downto 0);
    signal Vis_unit : std_logic_vector(3 downto 0);
    signal Vis_dec  : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instanciation du composant SCORE
    uut: SCORE
    port map(
        CE_1ms   => CE_1ms,
        CLK      => CLK,
        BPL      => BPL,
        BPreset  => BPreset,
        BPV      => BPV,
        Loc_unit => Loc_unit,
        Loc_dec  => Loc_dec,
        Vis_unit => Vis_unit,
        Vis_dec  => Vis_dec
    );

    -- Processus pour générer l'horloge principale
    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    -- Processus pour générer CE_1ms (un tic toutes les 1ms simulées)
    ce_1ms_process : process
    begin
        while true loop
            CE_1ms <= '0';
            wait for 950 ns;
            CE_1ms <= '1';
            wait for 50 ns;
        end loop;
    end process;

    -- Stimulus principal
    stim_proc: process
    begin
        -- Initialisation
        BPreset <= '1';
        BPL <= '0';
        BPV <= '0';
        wait for 100 ns;

        -- Relâcher le RESET
        BPreset <= '0';
        wait for 1 ms;

        -- Simuler une pression sur BPL (augmenter score local)
        BPL <= '1';
        wait for 2 ms;
        BPL <= '0';
        wait for 5 ms;

        -- Simuler une pression sur BPV (augmenter score visiteur)
        BPV <= '1';
        wait for 2 ms;
        BPV <= '0';
        wait for 5 ms;

        -- Encore un clic local
        BPL <= '1';
        wait for 2 ms;
        BPL <= '0';
        wait for 5 ms;

        -- Encore un clic visiteur
        BPV <= '1';
        wait for 2 ms;
        BPV <= '0';
        wait for 5 ms;

        -- Appuyer sur RESET pour remettre à 0
        BPreset <= '1';
        wait for 1 ms;
        BPreset <= '0';

        -- Continuer un peu
        wait for 5 ms;

        -- Fin de simulation
        wait;
    end process;

end behavior;

