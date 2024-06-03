vlib work 
vlog  -f list.list -mfcu
vsim -voptargs=+acc work.FIFO_top -classdebug -uvmcontrol=all
add wave /FIFO_top/FIFO_if/*
coverage save FIFO_top.ucdb -onexit
vcover report FIFO_top.ucdb -details -all -annotate -output report.txt
run -all


