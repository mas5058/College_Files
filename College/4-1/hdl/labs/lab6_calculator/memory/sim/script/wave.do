onerror {resume}
radix define States {
    "11'b001" "idle" -color "orange",
    "11'b010" "write" -color "blue",
    "11'b100" "read" -color "yellow",
    -default hexadecimal
    -defaultcolor white
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_tb/clk
add wave -noupdate -radix decimal /memory_tb/reset
add wave -noupdate -radix decimal /memory_tb/we
add wave -noupdate -radix decimal /memory_tb/addr
add wave -noupdate -radix decimal /memory_tb/din
add wave -noupdate -radix States /memory_tb/state_reg
add wave -noupdate -radix States /memory_tb/state_next
add wave -noupdate -radix decimal /memory_tb/dout
add wave -noupdate -expand -group uut /memory_tb/uut/clk
add wave -noupdate -expand -group uut /memory_tb/uut/we
add wave -noupdate -expand -group uut -radix decimal /memory_tb/uut/addr
add wave -noupdate -expand -group uut -radix decimal /memory_tb/uut/din
add wave -noupdate -expand -group uut -radix decimal /memory_tb/uut/dout
add wave -noupdate -expand -group uut -radix decimal -childformat {{/memory_tb/uut/RAM(3) -radix decimal} {/memory_tb/uut/RAM(2) -radix decimal} {/memory_tb/uut/RAM(1) -radix decimal} {/memory_tb/uut/RAM(0) -radix decimal}} -expand -subitemconfig {/memory_tb/uut/RAM(3) {-height 18 -radix decimal} /memory_tb/uut/RAM(2) {-height 18 -radix decimal} /memory_tb/uut/RAM(1) {-height 18 -radix decimal} /memory_tb/uut/RAM(0) {-height 18 -radix decimal}} /memory_tb/uut/RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {210 ns}
