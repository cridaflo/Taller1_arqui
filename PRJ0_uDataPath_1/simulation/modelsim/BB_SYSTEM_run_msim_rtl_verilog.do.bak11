transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl/uDataPath.v}
vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl/SC_RegGENERAL.v}
vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl/SC_RegFIXED.v}
vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl/CC_MUXX.v}
vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl/CC_DECODER.v}
vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl/CC_ALU.v}
vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1 {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/BB_SYSTEM.v}
vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl/WB_SYSTEM.v}
vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/rtl/SC_RegIR.v}

vlog -vlog01compat -work work +incdir+E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/simulation/modelsim {E:/ArquiDig/Taller1_arqui/PRJ0_uDataPath_1/simulation/modelsim/CC_ALU.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  CC_ALU

add wave *
view structure
view signals
run -all
