transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu/regfile.v}
vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu/immgen.v}
vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu/define.v}
vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu/cpu_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu/contrgen.v}
vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu/branch_cond.v}
vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu/alu.v}
vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/cpu/pipeline.v}

vlog -vlog01compat -work work +incdir+D:/HomeWork/ShuDianShiYan/12/exp12/hardware/modelsim/cpu_singlestep {D:/HomeWork/ShuDianShiYan/12/exp12/hardware/modelsim/cpu_singlestep/cpu_step.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  cpu_single_vlg_tst

add wave *
view structure
view signals
run -all
