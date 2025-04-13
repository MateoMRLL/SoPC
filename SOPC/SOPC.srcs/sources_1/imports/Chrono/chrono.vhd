library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY CHRONOMETER IS
  PORT(
    CE_1s   : IN std_logic;
    CLK     : IN std_logic;
    WAIT_t  : IN std_logic;
    START   : IN std_logic;
    RESET   : IN std_logic;
    sec_unit  : out std_logic_vector (3 downto 0);
    sec_dec   : out std_logic_vector (3 downto 0);
    min_unit  : out std_logic_vector (3 downto 0);
    min_dec   : out std_logic_vector (3 downto 0)
  );
END CHRONOMETER;

architecture behavior of CHRONOMETER is

  signal out_comp, out_bascule, in_d_bascule, ce_sec_unit, ce_sec_dec, ce_min_unit, ce_min_dec,TC_CPT_SEC_UNIT_CHRONO,TC_CPT_SEC_DEC_CHRONO,TC_CPT_MIN_UNIT_CHRONO : std_logic;
  signal min_unit_int, min_dec_int : std_logic_vector(3 downto 0);

  component BASCULE_CHRONO
  port (
    CLK : in std_logic;
    R   : in std_logic;
    D   : in std_logic; 
    Q   : out std_logic
  );
  end component;



  component CPT_DEC_CHRONO
  port (
    CLK : in std_logic;
    R   : in std_logic;
    CE  : in std_logic; 
    TC  : out std_logic;
    S   : out std_logic_vector(3 downto 0)
  );
  end component;


  component CPT_UNIT_CHRONO
  port (
    CLK : in std_logic;
    R   : in std_logic;
    CE  : in std_logic; 
    TC  : out std_logic;
    S   : out std_logic_vector(3 downto 0)
  );
  end component;

  component COMP_CHRONO
  port (
    in1 : in std_logic_vector(3 downto 0);
    in2 : in std_logic_vector(3 downto 0);
    S   : out std_logic
  );
  end component;

begin
  -- Flip-Flop for START signal
  B1 : BASCULE_CHRONO
    port map (
      CLK => CLK,
      R   => RESET,
      D   => in_d_bascule,
      Q   => out_bascule
    );

  -- Comparator
  COMP1 : COMP_CHRONO
    port map (
      in1 => min_unit_int,
      in2 => min_dec_int,
      S   => out_comp
    );

  -- Seconds unit counter
  C1 : CPT_UNIT_CHRONO
    port map (
      CLK => CLK,
      R   => RESET,
      CE  => ce_sec_unit,
      TC  => TC_CPT_SEC_UNIT_CHRONO,
      S   => sec_unit
    );

  -- Seconds tens counter
  C2 : CPT_DEC_CHRONO
    port map (
      CLK => CLK,
      R   => RESET,
      CE  => ce_sec_dec,
      TC  => TC_CPT_SEC_DEC_CHRONO,
      S   => sec_dec
    );

  -- Minutes unit counter
  C3 : CPT_UNIT_CHRONO
    port map (
      CLK => CLK,
      R   => RESET,
      CE  => ce_min_unit,
      TC  => TC_CPT_MIN_UNIT_CHRONO,
      S   => min_unit_int
    );

  -- Minutes tens counter
  C4 : CPT_DEC_CHRONO
    port map (
      CLK => CLK,
      R   => RESET,
      CE  => ce_min_dec,
      TC  => open,
      S   => min_dec_int
    );

  -- Output assignments
  min_unit <= min_unit_int;
  min_dec  <= min_dec_int;
    
  in_d_bascule <= START or out_bascule;
  ce_sec_unit <= out_bascule and CE_1s and NOT(WAIT_t) and NOT(out_comp);
  ce_sec_dec <= TC_CPT_SEC_UNIT_CHRONO and CE_1s;
  ce_min_unit <= TC_CPT_SEC_UNIT_CHRONO and TC_CPT_SEC_DEC_CHRONO and CE_1s;
  ce_min_dec <= TC_CPT_MIN_UNIT_CHRONO and CE_1s and ce_min_unit;

end behavior;
