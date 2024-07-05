onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ALU_tb/u_ALU/N
add wave -noupdate /ALU_tb/u_ALU/R
add wave -noupdate /ALU_tb/u_ALU/O
add wave -noupdate /ALU_tb/u_ALU/clk
add wave -noupdate /ALU_tb/u_ALU/rstn
add wave -noupdate /ALU_tb/u_ALU/Instruction
add wave -noupdate /ALU_tb/u_ALU/ProgramCounter
add wave -noupdate /ALU_tb/u_ALU/GPR_a
add wave -noupdate /ALU_tb/u_ALU/GPR_b
add wave -noupdate /ALU_tb/u_ALU/GPR_c
add wave -noupdate /ALU_tb/u_ALU/SPR_h
add wave -noupdate /ALU_tb/u_ALU/SPR_l
add wave -noupdate -divider GPR_a
add wave -noupdate /ALU_tb/u_ALU/GPR_a_dat
add wave -noupdate /ALU_tb/u_ALU/GPR_a_val
add wave -noupdate /ALU_tb/u_ALU/AddSub_GPR_a_val
add wave -noupdate /ALU_tb/u_ALU/AddSub_GPR_a_dat
add wave -noupdate -divider GPR_b
add wave -noupdate /ALU_tb/u_ALU/GPR_b_val
add wave -noupdate /ALU_tb/u_ALU/GPR_b_dat
add wave -noupdate /ALU_tb/u_ALU/AddSub_GPR_b_dat
add wave -noupdate /ALU_tb/u_ALU/AddSub_GPR_b_val
add wave -noupdate -divider GPR_c
add wave -noupdate /ALU_tb/u_ALU/GPR_c_val
add wave -noupdate /ALU_tb/u_ALU/GPR_c_dat
add wave -noupdate /ALU_tb/u_ALU/AddSub_GPR_c_val
add wave -noupdate /ALU_tb/u_ALU/AddSub_GPR_c_dat
add wave -noupdate -divider GPR_h
add wave -noupdate /ALU_tb/u_ALU/SPR_h_val
add wave -noupdate /ALU_tb/u_ALU/SPR_h_dat
add wave -noupdate /ALU_tb/u_ALU/AddSub_SPR_h_dat
add wave -noupdate /ALU_tb/u_ALU/AddSub_SPR_h_val
add wave -noupdate -divider SPR_l
add wave -noupdate /ALU_tb/u_ALU/SPR_l_val
add wave -noupdate /ALU_tb/u_ALU/SPR_l_dat
add wave -noupdate /ALU_tb/u_ALU/AddSub_SPR_l_val
add wave -noupdate /ALU_tb/u_ALU/AddSub_SPR_l_dat
add wave -noupdate -divider OverFlow/Zero
add wave -noupdate /ALU_tb/u_ALU/SPR_o_val
add wave -noupdate /ALU_tb/u_ALU/AddSub_SPR_o_val
add wave -noupdate /ALU_tb/u_ALU/SPR_z_val
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70282833 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 291
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {142467649 ns}
