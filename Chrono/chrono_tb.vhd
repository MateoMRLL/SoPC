library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_chronometer is
end tb_chronometer;

architecture behavior of tb_chronometer is

    -- Déclaration du composant CHRONOMETER
    component CHRONOMETER
      port (
        CE_1s    : in std_logic;
        CLK      : in std_logic;
        WAIT_t   : in std_logic;
        START    : in std_logic;
        RESET    : in std_logic;
        sec_unit : out std_logic_vector (3 downto 0);
        sec_dec  : out std_logic_vector (3 downto 0);
        min_unit : out std_logic_vector (3 downto 0);
        min_dec  : out std_logic_vector (3 downto 0)
      );
    end component;

    -- Signaux
    signal CE_1s    : std_logic := '0';
    signal CLK      : std_logic := '0';
    signal WAIT_t   : std_logic := '0';
    signal START    : std_logic := '0';
    signal RESET    : std_logic := '0';
    signal sec_unit : std_logic_vector(3 downto 0);
    signal sec_dec  : std_logic_vector(3 downto 0);
    signal min_unit : std_logic_vector(3 downto 0);
    signal min_dec  : std_logic_vector(3 downto 0);

    -- Période d'horloge
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instanciation du CHRONOMETER (DUT = Device Under Test)
    uut: CHRONOMETER
      port map (
        CE_1s    => CE_1s,
        CLK      => CLK,
        WAIT_t   => WAIT_t,
        START    => START,
        RESET    => RESET,
        sec_unit => sec_unit,
        sec_dec  => sec_dec,
        min_unit => min_unit,
        min_dec  => min_dec
      );

    -- Génération du signal d'horloge (CLK)
    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Génération du signal CE_1s (1 impulsion simulant 1 seconde)
    ce_1s_process : process
    begin
        while true loop
            CE_1s <= '0';
            wait for 950 ns; -- état bas pendant ~95% du temps
            CE_1s <= '1';
            wait for 50 ns;  -- impulsion haute courte
        end loop;
    end process;

    -- Stimulus principal
    stim_proc: process
    begin
        -- Phase de RESET initial
        RESET <= '1';
        START <= '0';
        WAIT_t <= '0';
        wait for 100 ns;

        -- Libération du RESET
        RESET <= '0';
        wait for 100 ns;

        -- Activation du START
        START <= '1';
        wait for 100 ns;
        START <= '0'; -- START est capté par la bascule, donc on peut relâcher rapidement

        -- Laisser le chronomètre tourner pendant 45 minutes simulées
        wait for 600 us; 

        -- Envoyer un RESET après 45 minutes
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';

        -- Attendre un peu pour voir que tout repart correctement
        wait for 50 us;

        -- Fin de simulation
        wait;
    end process;

end behavior;

