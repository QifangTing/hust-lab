# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/sabertazimi/gitrepo/hust-lab/verilog/lab2/lab2_2_2_2/lab2_2_2_2.cache/wt [current_project]
set_property parent.project_path /home/sabertazimi/gitrepo/hust-lab/verilog/lab2/lab2_2_2_2/lab2_2_2_2.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib /home/sabertazimi/gitrepo/hust-lab/verilog/lab2/lab2_2_2_2/lab2_2_2_2.srcs/sources_1/new/lab2_2_2_2.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}

synth_design -top lab2_2_2_2 -part xc7a100tcsg324-1


write_checkpoint -force -noxdef lab2_2_2_2.dcp

catch { report_utilization -file lab2_2_2_2_utilization_synth.rpt -pb lab2_2_2_2_utilization_synth.pb }
