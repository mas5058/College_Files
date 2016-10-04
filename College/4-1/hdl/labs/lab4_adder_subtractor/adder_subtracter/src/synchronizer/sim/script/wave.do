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
add wave -noupdate /synchronizer_tb/clk
add wave -noupdate /synchronizer_tb/reset
add wave -noupdate /synchronizer_tb/async_in
add wave -noupdate /synchronizer_tb/sync_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {357 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 163
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
WaveRestoreZoom {904 ns} {1056 ns}
