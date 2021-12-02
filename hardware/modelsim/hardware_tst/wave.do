onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hardware_tst/CLOCK_50
add wave -noupdate /hardware_tst/cycle
add wave -noupdate /hardware_tst/i1/global_int_en
add wave -noupdate /hardware_tst/i1/timer_irq
add wave -noupdate /hardware_tst/i1/cpu/client_instance/int_addr
add wave -noupdate /hardware_tst/i1/cpu/client_instance/int_flag
add wave -noupdate /hardware_tst/i1/cpu/pc
add wave -noupdate /hardware_tst/i1/cpu/instr
add wave -noupdate /hardware_tst/i1/mm_instance/kb_info_instance/data
add wave -noupdate /hardware_tst/i1/mm_instance/vga_info_instance/extra_line_cnt
add wave -noupdate /hardware_tst/i1/mm_instance/vga_info_instance/cursor_x
add wave -noupdate /hardware_tst/i1/mm_instance/vga_info_instance/cursor_y
add wave -noupdate /hardware_tst/i1/cpu/ID_instance/myregfile/regs
add wave -noupdate /hardware_tst/i1/cpu/csrs/mcause
add wave -noupdate /hardware_tst/i1/cpu/ID_instance/myregfile/rw
add wave -noupdate /hardware_tst/i1/cpu/ID_instance/myregfile/busW
add wave -noupdate /hardware_tst/i1/cpu/ID_instance/myregfile/wren
add wave -noupdate /hardware_tst/i1/cpu/ID_instance/contr_gen_instance/instr
add wave -noupdate /hardware_tst/i1/cpu/ID_instance/contr_gen_instance/csr_alu_ctr
add wave -noupdate /hardware_tst/i1/cpu/ID_instance/contr_gen_instance/csr_we
add wave -noupdate /hardware_tst/i1/cpu/ID_instance/contr_gen_instance/csr2reg
add wave -noupdate /hardware_tst/i1/cpu/EX_instance/csr_alu_instance/csr
add wave -noupdate /hardware_tst/i1/cpu/EX_instance/csr_alu_instance/rs1
add wave -noupdate /hardware_tst/i1/cpu/EX_instance/csr_alu_instance/zimm
add wave -noupdate -radix binary /hardware_tst/i1/cpu/EX_instance/csr_alu_instance/ALUctr
add wave -noupdate /hardware_tst/i1/cpu/EX_instance/csr_alu_instance/aluresult
add wave -noupdate /hardware_tst/i1/cpu/csrs/raddr_ex
add wave -noupdate /hardware_tst/i1/cpu/csrs/data_out_ex
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10540000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 379
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {10328358 ps} {11080966 ps}
