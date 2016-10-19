onerror {resume}
radix define States {
    "11'b0001" "WAIT" -color "orange",
    "11'b0010" "ATTACK" -color "red",
    "11'b0100" "HEAL" -color "blue",
    "11'b1000" "FLEA" -color "yellow",
    -default hexadecimal
    -defaultcolor white
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /state_machine_tb/uut/clk
add wave -noupdate /state_machine_tb/uut/reset
add wave -noupdate /state_machine_tb/uut/nearby_opponent
add wave -noupdate /state_machine_tb/uut/friend_wounded
add wave -noupdate /state_machine_tb/uut/me_wounded
add wave -noupdate /state_machine_tb/uut/fighting
add wave -noupdate -radix States -expand /state_machine_tb/uut/state_reg
add wave -noupdate -radix States -expand /state_machine_tb/uut/state_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {357 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 307
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
WaveRestoreZoom {150 ns} {1975 ns}
