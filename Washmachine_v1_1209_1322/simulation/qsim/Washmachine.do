onerror {exit -code 1}
vlib work
vlog -work work Washmachine.vo
vlog -work work testsegdecode.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.SegDecode_vlg_vec_tst -voptargs="+acc"
vcd file -direction Washmachine.msim.vcd
vcd add -internal SegDecode_vlg_vec_tst/*
vcd add -internal SegDecode_vlg_vec_tst/i1/*
run -all
quit -f
