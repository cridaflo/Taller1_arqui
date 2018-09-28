transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/WB_SYSTEM.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/uDataPath.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/SC_RegPSR.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/SC_RegIR.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/SC_RegGENERAL.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/SC_RegFIXED.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/ROM.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/programMem.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/MIR.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/CSAI.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/CS_address_MUX.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/CC_MUX_REG.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/CC_MUX.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/CC_DECODER.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/CC_BUS.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/CC_ALU.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/CBL.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/rtl/C_BUS_MUX.v}
vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1 {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/BB_SYSTEM.v}

vlog -vlog01compat -work work +incdir+D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/simulation/modelsim {D:/tareas/arquitectura/proyecto1/Taller1_arqui/PRJ0_uDataPath_1/simulation/modelsim/SC_uDatapath.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  test

add wave *
view structure
view signals
run -all
