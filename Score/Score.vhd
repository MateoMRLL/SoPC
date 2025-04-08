library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY SCORE IS
  PORT(
    CE_1ms   : IN std_logic;
    CLK     : IN std_logic;
    BPL  : IN std_logic;
    BPreset   : IN std_logic;
    BPV   : IN std_logic;
    Loc_unit : OUT std_logic_vector(3 downto 0);
    Loc_dec : OUT std_logic_vector(3 downto 0);
    Vis_unit : OUT std_logic_vector(3 downto 0);
    Vis_dec : OUT std_logic_vector(3 downto 0)
  );
END SCORE;

architecture behavior of SCORE is

signal u0_out,u1_out,u2_out,u3_out,CE_U10,TC_U11 : STD_LOGIC;

signal u5_out,u6_out,u7_out,u8_out,CE_U12,TC_U13 : STD_LOGIC;


component counterDec_4b_RE is
port (
    CLK : in std_logic;
    R   : in std_logic;
    CE  : in std_logic; 
    TC  : out std_logic;
    S   : out std_logic_vector(3 downto 0)
  );
end component;

component register_1b_E is
    Port (
        clk   : in  std_logic;
        E     : in  std_logic;
        D     : in  std_logic;
        Q     : out std_logic
    );
end component;

component register_1b is
    Port (
        clk   : in  std_logic;
        D     : in  std_logic;
        Q     : out std_logic
    );
end component;

component XOR_2b is
    Port (
        A : in  std_logic;
        B : in  std_logic;
        Y : out std_logic
    );
end component;

begin
  U0 :register_1b_E
   port map(
      clk => clk,
      E => CE_1ms,
      D => BPL,
      Q => u0_out
  );
    
  U1 :register_1b_E
   port map(
      clk => clk,
      E => CE_1ms,
      D => u0_out,
      Q => u1_out
  );
  U2 :register_1b
   port map(
      clk => clk,
      D => u1_out,
      Q => u2_out
  );
  U3 :XOR_2b
   port map(
      A => u2_out,
      B => u1_out,
      Y => u3_out
  );
  U10 : counterDec_4b_RE
   port map(
      CLK => CLK,
      R => BPreset,
      CE => CE_U10,
      TC => TC_U11,
      S => Loc_unit
  );
    U11 : counterDec_4b_RE
   port map(
      CLK => CLK,
      R => BPreset,
      CE => TC_U11,
      TC => open,
      S => Loc_dec
  );

  U5 :register_1b_E
   port map(
      clk => clk,
      E => CE_1ms,
      D => BPL,
      Q => u5_out
  );
    
  U6 :register_1b_E
   port map(
      clk => clk,
      E => CE_1ms,
      D => u5_out,
      Q => u6_out
  );
  U7 :register_1b
   port map(
      clk => clk,
      D => u6_out,
      Q => u7_out
  );
  U8 :XOR_2b
   port map(
      A => u7_out,
      B => u6_out,
      Y => u8_out
  );
  U12 : counterDec_4b_RE
   port map(
      CLK => CLK,
      R => BPreset,
      CE => CE_U12,
      TC => TC_U13,
      S => Vis_unit
  );
    U13 : counterDec_4b_RE
   port map(
      CLK => CLK,
      R => BPreset,
      CE => TC_U13,
      TC => open,
      S => Vis_dec
  );


  CE_U10 <= u3_out AND u1_out;
  CE_U12 <= u6_out AND u8_out;
end behavior;
