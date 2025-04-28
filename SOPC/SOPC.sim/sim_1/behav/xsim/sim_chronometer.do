# Nettoyer toute simulation en cours
quit -sim

# Créer et mapper la bibliothèque de travail
vlib work
vmap work work

# Compiler les fichiers VHDL
vcom -2008 CHRONOMETER.vhd
vcom -2008 tb_chronometer.vhd

# Lancer la simulation du testbench
vsim work.tb_chronometer

# Ajouter les signaux à la fenêtre des signaux
add wave -divider "Entrées"
add wave CE_1s
add wave CLK
add wave WAIT_t
add wave START
add wave RESET

add wave -divider "Sorties"
add wave sec_unit
add wave sec_dec
add wave min_unit
add wave min_dec

# Exécuter la simulation pendant 3000 ms (45 minutes simulées)
run 3000 ms

# Zoomer pour afficher tous les signaux
wave zoom full

