library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

ENTITY CHRONOMETRE  IS 

  PORT(

  CE_1s : IN std_logic; 
  CLK : IN std_logic; 
  WAIT_t : IN std_logic; 
  START : IN std_logic; 
  RESET : IN std_logic; 
  sec_unit : OUT std_logic_vector(3 downto 0);
  sec_dec : OUT std_logic_vector(3 downto 0); 
  min_unit : OUT std_logic_vector(3 downto 0); 
  min_dec : OUT std_logic_vector(3 downto 0)
  ); 
END CHRONOMETRE; 

architecture behavior of CHRONOMETRE is 

signal out_comp, out_bascule, in_d_bascule, ce_sec_unit, ce_sec_dec , ce_min_unit, ce_min_unit: std_logic; 
signal min_unit_int, min_dec_int : std_logic_vector(3 downto 0); 

component BASCULE_CHRONO
port (
CLK : in std_logic;
R : in std_logic;
D : in std_logic; 
Q : out std_logic
);
end component BASCULE_CHRONO;

component CPT_SU_CHRONO
port (
CLK : in std_logic;
R : in std_logic;
CE : in std_logic; 
TC : out std_logic;
S :out std_logic_vector(3 downto 0)
);
end component CPT_SU_CHRONO;


component CPT_SD_CHRONO
port (
CLK : in std_logic;
R : in std_logic;
CE : in std_logic; 
TC : out std_logic;
S :out std_logic_vector(3 downto 0)
);
end component CPT_SD_CHRONO;


component CPT_MU_CHRONO
port (
CLK : in std_logic;
R : in std_logic;
CE : in std_logic; 
TC : out std_logic;
S :out std_logic_vector(3 downto 0) 
);
end component CPT_MU_CHRONO;

component CPT_MD_CHRONO
port (
CLK : in std_logic;
R : in std_logic;
CE : in std_logic; 
TC : out std_logic;
S :out std_logic_vector(3 downto 0)
);
end component CPT_MD_CHRONO;


component COMP_CHRONO
port (
in1 : in std_logic_vector(3 downto 0);
in2 : in std_logic_vector(3 downto 0);
S : out std_logic
);
end component COMP_CHRONO;

end behavior;
