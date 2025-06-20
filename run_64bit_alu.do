vlib work
vdel -all
vlib work

vlog 64bit_alu.v 
vlog 64bit_alu_tb.v 
vsim work.tb
add wave -r *
run -all