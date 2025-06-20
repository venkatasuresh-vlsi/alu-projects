vlib work
vdel -all
vlib work

vlog 32bit_alu.v 
vlog 32bit_alu_tb.v 
vsim work.tb
add wave -r *
run -all