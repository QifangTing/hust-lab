# Nexys4 Pin Assignments
############################
# On-board Slide Switches  #
############################
# CP, M, LD_n, CLR_n, D[3:0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CP_IBUF]
set_property PACKAGE_PIN F15 [get_ports CP]
set_property IOSTANDARD LVCMOS33 [get_ports CP]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets M_IBUF]
set_property PACKAGE_PIN U9 [get_ports M]
set_property IOSTANDARD LVCMOS33 [get_ports M]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets LD_n_IBUF]
set_property PACKAGE_PIN U8 [get_ports LD_n]
set_property IOSTANDARD LVCMOS33 [get_ports LD_n]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLR_n_IBUF]
set_property PACKAGE_PIN R7 [get_ports CLR_n]
set_property IOSTANDARD LVCMOS33 [get_ports CLR_n]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets D[0]_IBUF]
set_property PACKAGE_PIN R6 [get_ports D[0]]
set_property IOSTANDARD LVCMOS33 [get_ports D[0]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets D[1]_IBUF]
set_property PACKAGE_PIN R5 [get_ports D[1]]
set_property IOSTANDARD LVCMOS33 [get_ports D[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets D[2]_IBUF]
set_property PACKAGE_PIN V7 [get_ports D[2]]
set_property IOSTANDARD LVCMOS33 [get_ports D[2]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets D[3]_IBUF]
set_property PACKAGE_PIN V6 [get_ports D[3]]
set_property IOSTANDARD LVCMOS33 [get_ports D[3]]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swt[7]]
#set_property PACKAGE_PIN V5 [get_ports swt[7]]
#set_property IOSTANDARD LVCMOS33 [get_ports swt[7]]

############################
# On-board led             #
############################
# Q[3:0], Qcc_n
set_property PACKAGE_PIN T8 [get_ports Q[0]]
set_property IOSTANDARD LVCMOS33 [get_ports Q[0]]
set_property PACKAGE_PIN V9 [get_ports Q[1]]
set_property IOSTANDARD LVCMOS33 [get_ports Q[1]]
set_property PACKAGE_PIN R8 [get_ports Q[2]]
set_property IOSTANDARD LVCMOS33 [get_ports Q[2]]
set_property PACKAGE_PIN T6 [get_ports Q[3]]
set_property IOSTANDARD LVCMOS33 [get_ports Q[3]]
set_property PACKAGE_PIN T5 [get_ports Qcc_n]
set_property IOSTANDARD LVCMOS33 [get_ports Qcc_n]
#set_property PACKAGE_PIN T4 [get_ports led[5]]
#set_property IOSTANDARD LVCMOS33 [get_ports led[5]]
#set_property PACKAGE_PIN U7 [get_ports led[6]]
#set_property IOSTANDARD LVCMOS33 [get_ports led[6]]
#set_property PACKAGE_PIN U6 [get_ports led[7]]
#set_property IOSTANDARD LVCMOS33 [get_ports led[7]]