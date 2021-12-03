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
add wave -noupdate /hardware_tst/i1/mm_instance/cpu_addr
add wave -noupdate /hardware_tst/i1/mm_instance/cpu_wrdata
add wave -noupdate /hardware_tst/i1/mm_instance/cpu_rddata
add wave -noupdate /hardware_tst/i1/mm_instance/cpu_memop
add wave -noupdate /hardware_tst/i1/mm_instance/cpu_we
add wave -noupdate /hardware_tst/i1/mm_instance/vga_extra_line_cnt
add wave -noupdate /hardware_tst/i1/mm_instance/vga_cursor_x
add wave -noupdate /hardware_tst/i1/mm_instance/vga_cursor_y
add wave -noupdate /hardware_tst/i1/mm_instance/dram_dataout
add wave -noupdate /hardware_tst/i1/mm_instance/kb_info_dataout
add wave -noupdate /hardware_tst/i1/mm_instance/tmp_stack_dataout
add wave -noupdate /hardware_tst/i1/mm_instance/dram_we
add wave -noupdate /hardware_tst/i1/mm_instance/vga_we
add wave -noupdate /hardware_tst/i1/mm_instance/char_we
add wave -noupdate /hardware_tst/i1/mm_instance/color_we
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10423539 ps} 0}
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
WaveRestoreZoom {137685023 ps} {138437631 ps}
