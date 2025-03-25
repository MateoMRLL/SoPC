library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all

ENTITY DISPLAY  IS 

  PORT(

  CE_1ms : IN std_logic; 
  CE_1s : IN std_logic; 
  CLK IN std_logic; 
  data_disp1_L0 IN std_logic_vector(3 downto 0);
  data_disp1_L1 IN std_logic_vector(3 downto 0);
  data_disp1_R0 IN std_logic_vector(3 downto 0);
  data_disp1_R1 IN std_logic_vector(3 downto 0);
  data_disp2_L0 IN std_logic_vector(3 downto 0);
  data_disp2_L1 IN std_logic_vector(3 downto 0);
  data_disp2_R0 IN std_logic_vector(3 downto 0);
  data_disp2_R1 IN std_logic_vector(3 downto 0);
  AN : OUT std_logic_vector(7 downto 0);
  LEDS : OUT std_logic_vector(7 downto 0);
  ); 
END DISPLAY; 

architecture behavior of DISPLAY is 

signal : tregister_sig, mux_1b_sig std_logic; 
signal : mux_4b_sig std_logic_vector(3 downto 0 ); 
signal : out_counter_3b_sig std_logic_vector( 2 downto 0 ); 
signal : out_trans_3v8_sig std_logic_vector(7 downto 0); 
signal : out_trans_7seg_sig std_logic_vector(6 downto 0); 


component counter_3b_E
port (
CLK : in std_logic;
CE : in std_logic;
O : out std_logic_vector(3 downto 0);
);
end component counter_3b_E;

component Tregister_1b 
port (
CLK : in std_logic;
T : in std_logic;
O : out std_logic;
);
end component Tregister_1b;

component register_8b1 
port (
CLK : in std_logic;
D : in std_logic_vector(7 downto 0);
O : out std_logic_vector(7 downto 0);
);
end component register_8b1;

component register_8b2 
port (
CLK : in std_logic;
D : in std_logic_vector(7 downto 0);
O : out std_logic_vector(7 downto 0);
);
end component register_8b2;


component mux_8x1x4b 
port (
A : in std_logic_vector(3 downto 0); 
B : in std_logic_vector(3 downto 0); 
C : in std_logic_vector(3 downto 0); 
D : in std_logic_vector(3 downto 0); 
E : in std_logic_vector(3 downto 0); 
F : in std_logic_vector(3 downto 0);
G : in std_logic_vector(3 downto 0);  
H : in std_logic_vector(3 downto 0); 
S : in std_logic_vector(2 downto 0); 

O : out std_logic_vector(3 downto 0); 
);
end component mux_8x1x4b;


component mux_8x1x1b 
port (
A : in std_logic; 
B : in std_logic; 
C : in std_logic; 
D : in std_logic; 
E : in std_logic; 
F : in std_logic;
G : in std_logic;  
H : in std_logic; 
sel : in std_logic_vector(2 downto 0); 
O : out std_logic; 


);
end component mux_8x1x1b;

component transcoder_3v8 
port (
A : in std_logic_vector(2 downto 0); 
O : out std_logic_vector(7 downto 0); 
);
end component transcoder_3v8;


component transcoder_7seg
port (
A : in std_logic_vector(3 downto 0); 
O : out std_logic_vector(6 downto 0); 

);
end component transcoder_7seg;

begin 

U0 :  counter_3b_E
  port map (
    CE => CE_1ms, 
    CLK => CLK,
    O => out_counter_3b_sig
  ); 

U1 : transcoder_3v8
  port map(
    A => out_counter_3b_sig,
    O => out_trans_3v8_sig
  ); 

U2 : register_8b1
  port map(
    CLK => CLK, 
    D => out_trans_3v8_sig, 
    O => AN
  ); 

U3 : Tregister_1b
  port map(
    CLK => CLK, 
    T => CE_1s, 
    O => tregister_sig
  ); 

U4 : mux_8x1x1b
  port map(
    A => 1,  
    B => 1, 
    C => tregister_sig, 
    D => 1, 
    E =>1, 
    F => 1, 
    G =>1, 
    H=>1, 
    sel => out_counter_3b_sig, 
    O => mux_1b_sig
  ); 

U5 : mux_8x1x4b
  port map(
    A => data_disp1_R0,  
    B => data_disp1_R1, 
    C => data_disp1_L0, 
    D => data_disp1_L1, 
    E => data_disp2_R0, 
    F => data_disp2_R1, 
    G => data_disp2_L0, 
    H=>  data_disp2_L1, 
    S => out_counter_3b_sig, 
    O => mux_4b_sig
  ); 

U6 : transcoder_7seg
  port map(
    A => mux_4b_sig, 
    O => out_trans_7seg_sig
  ); 

U7 : register_8b2
  port map(
    CLK => CLK, 
    D => out_trans_7seg_sig & mux_1b_sig
    O => LEDS
  );

end behavior; 
