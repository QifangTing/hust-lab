# Nexys4 Pin Assignments
##########################################
# On-board Slide Switches/Button/Signal  #
##########################################
set_property PACKAGE_PIN E3 [get_ports clk_src]
set_property IOSTANDARD LVCMOS33 [get_ports clk_src]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets switch_power_IBUF]
set_property PACKAGE_PIN U9 [get_ports switch_power]
set_property IOSTANDARD LVCMOS33 [get_ports switch_power]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets switch_en_IBUF]
set_property PACKAGE_PIN U8 [get_ports switch_en]
set_property IOSTANDARD LVCMOS33 [get_ports switch_en]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets max_water_level_IBUF]
set_property PACKAGE_PIN R7 [get_ports max_water_level]
set_property IOSTANDARD LVCMOS33 [get_ports max_water_level]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets inwater_flag_IBUF]
set_property PACKAGE_PIN R6 [get_ports inwater_flag]
set_property IOSTANDARD LVCMOS33 [get_ports inwater_flag]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets outwater_flag_IBUF]
set_property PACKAGE_PIN R5 [get_ports outwater_flag]
set_property IOSTANDARD LVCMOS33 [get_ports outwater_flag]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_sel[4]_IBUF]
#set_property PACKAGE_PIN V7 [get_ports clk_sel[4]]
#set_property IOSTANDARD LVCMOS33 [get_ports clk_sel[4]]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets D[3]_IBUF]
#set_property PACKAGE_PIN V6 [get_ports D[3]]
#set_property IOSTANDARD LVCMOS33 [get_ports D[3]]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swt[7]]
#set_property PACKAGE_PIN V5 [get_ports swt[7]]
#set_property IOSTANDARD LVCMOS33 [get_ports swt[7]]

############################
# Output                   #
############################
#set_property PACKAGE_PIN N6 [get_ports seg_control[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_control[0]]
#set_property PACKAGE_PIN M6 [get_ports seg_control[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_control[1]]
#set_property PACKAGE_PIN M3 [get_ports seg_control[2]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_control[2]]
#set_property PACKAGE_PIN N5 [get_ports seg_control[3]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_control[3]]
#set_property PACKAGE_PIN N2 [get_ports seg_control[4]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_control[4]]
#set_property PACKAGE_PIN N4 [get_ports seg_control[5]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_control[5]]
#set_property PACKAGE_PIN L1 [get_ports seg_control[6]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_control[6]]
#set_property PACKAGE_PIN M1 [get_ports seg_control[7]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_control[7]]

#set_property PACKAGE_PIN L3 [get_ports seg_time[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_time[0]]
#set_property PACKAGE_PIN N1 [get_ports seg_time[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_time[1]]
#set_property PACKAGE_PIN L5 [get_ports seg_time[2]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_time[2]]
#set_property PACKAGE_PIN L4 [get_ports seg_time[3]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_time[3]]
#set_property PACKAGE_PIN K3 [get_ports seg_time[4]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_time[4]]
#set_property PACKAGE_PIN M2 [get_ports seg_time[5]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_time[5]]
#set_property PACKAGE_PIN L6 [get_ports seg_time[6]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_time[6]]
#set_property PACKAGE_PIN M4 [get_ports seg_time[7]]
#set_property IOSTANDARD LVCMOS33 [get_ports seg_time[7]]

set_property PACKAGE_PIN T8 [get_ports water_level[0]]
set_property IOSTANDARD LVCMOS33 [get_ports water_level[0]]

set_property PACKAGE_PIN V9 [get_ports water_level[1]]
set_property IOSTANDARD LVCMOS33 [get_ports water_level[1]]

set_property PACKAGE_PIN R8 [get_ports water_level[2]]
set_property IOSTANDARD LVCMOS33 [get_ports water_level[2]]

#set_property PACKAGE_PIN T6 [get_ports state[3]]
#set_property IOSTANDARD LVCMOS33 [get_ports state[3]]

#set_property PACKAGE_PIN T5 [get_ports Qcc_n]
#set_property IOSTANDARD LVCMOS33 [get_ports Qcc_n]

#set_property PACKAGE_PIN T4 [get_ports led[5]]
#set_property IOSTANDARD LVCMOS33 [get_ports led[5]]

#set_property PACKAGE_PIN U7 [get_ports led[6]]
#set_property IOSTANDARD LVCMOS33 [get_ports led[6]]

#set_property PACKAGE_PIN U6 [get_ports led[7]]
#set_property IOSTANDARD LVCMOS33 [get_ports led[7]]
