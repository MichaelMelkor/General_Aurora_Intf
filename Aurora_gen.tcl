#-----------------------------------------------------------
# Vivado v2017.2 (64-bit)
# SW Build 1909853 on Thu Jun 15 18:39:10 MDT 2017
# IP Build 1909766 on Thu Jun 15 19:58:00 MDT 2017
# Start of session at: Sat Nov  2 10:44:34 2019
# Process ID: 5096
# Current directory: /home/isn/vivado_proj/General_Aurora/General_Aurora_Intf
# Command line: vivado
# Log file: /home/isn/vivado_proj/General_Aurora/General_Aurora_Intf/vivado.log
# Journal file: /home/isn/vivado_proj/General_Aurora/General_Aurora_Intf/vivado.jou
#-----------------------------------------------------------
#start_gui
create_project Aurora_test ../Aurora_test -part xc7vx690tffg1761-2
create_ip -name aurora_64b66b -vendor xilinx.com -library ip -version 11.2 -module_name aurora_64b66b_m_0

set_property -dict [list CONFIG.C_LINE_RATE {2.5} CONFIG.SINGLEEND_INITCLK {true} CONFIG.SupportLevel {1}] [get_ips aurora_64b66b_m_0]
generate_target {instantiation_template} [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.xci]
update_compile_order -fileset sources_1
generate_target all [get_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.xci]
export_ip_user_files -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.xci]
launch_runs -jobs 12 aurora_64b66b_m_0_synth_1
export_simulation -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.xci] -directory ../Aurora_test/Aurora_test.ip_user_files/sim_scripts -ip_user_files_dir ../Aurora_test/Aurora_test.ip_user_files -ipstatic_source_dir ../Aurora_test/Aurora_test.ip_user_files/ipstatic -lib_map_path [list {modelsim=../Aurora_test/Aurora_test.cache/compile_simlib/modelsim} {questa=../Aurora_test/Aurora_test.cache/compile_simlib/questa} {ies=../Aurora_test/Aurora_test.cache/compile_simlib/ies} {vcs=../Aurora_test/Aurora_test.cache/compile_simlib/vcs} {riviera=../Aurora_test/Aurora_test.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet

#remove_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.v
file delete -force ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.v
file copy -force ./source_file/aurora_64b66b_m_0.v ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.v

#remove_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0/src/aurora_64b66b_m_0_support.v
file delete -force ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0/src/aurora_64b66b_m_0_support.v
file copy -force ./source_file/aurora_64b66b_m_0_support.v ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0/src/aurora_64b66b_m_0_support.v

create_ip -name clk_wiz -vendor xilinx.com -library ip -version 5.4 -module_name clk_wiz_0
set_property -dict [list CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} CONFIG.PRIM_IN_FREQ {200.000} CONFIG.CLKOUT2_USED {true} CONFIG.CLK_OUT1_PORT {INIT_CLK} CONFIG.CLK_OUT2_PORT {DRP_CLK} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {50.000} CONFIG.CLKIN1_JITTER_PS {50.0} CONFIG.MMCM_DIVCLK_DIVIDE {1} CONFIG.MMCM_CLKFBOUT_MULT_F {5.000} CONFIG.MMCM_CLKIN1_PERIOD {5.000} CONFIG.MMCM_CLKIN2_PERIOD {10.0} CONFIG.MMCM_CLKOUT0_DIVIDE_F {20.000} CONFIG.MMCM_CLKOUT1_DIVIDE {10} CONFIG.NUM_OUT_CLKS {2} CONFIG.CLKOUT1_JITTER {129.198} CONFIG.CLKOUT1_PHASE_ERROR {89.971} CONFIG.CLKOUT2_JITTER {112.316} CONFIG.CLKOUT2_PHASE_ERROR {89.971}] [get_ips clk_wiz_0]
generate_target {instantiation_template} [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
generate_target all [get_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
catch { config_ip_cache -export [get_ips -all clk_wiz_0] }
export_ip_user_files -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ../Aurora_test/Aurora_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
launch_runs -jobs 12 clk_wiz_0_synth_1
export_simulation -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci] -directory ../Aurora_test/Aurora_test.ip_user_files/sim_scripts -ip_user_files_dir ../Aurora_test/Aurora_test.ip_user_files -ipstatic_source_dir ../Aurora_test/Aurora_test.ip_user_files/ipstatic -lib_map_path [list {modelsim=../Aurora_test/Aurora_test.cache/compile_simlib/modelsim} {questa=../Aurora_test/Aurora_test.cache/compile_simlib/questa} {ies=../Aurora_test/Aurora_test.cache/compile_simlib/ies} {vcs=../Aurora_test/Aurora_test.cache/compile_simlib/vcs} {riviera=../Aurora_test/Aurora_test.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.1 -module_name Wid70_Dep512_FIFO
set_property -dict [list CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM} CONFIG.Input_Data_Width {70} CONFIG.Input_Depth {512} CONFIG.Almost_Full_Flag {true} CONFIG.Almost_Empty_Flag {true} CONFIG.Output_Data_Width {70} CONFIG.Output_Depth {512} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.Full_Flags_Reset_Value {1} CONFIG.Data_Count_Width {9} CONFIG.Write_Data_Count_Width {9} CONFIG.Read_Data_Count_Width {9} CONFIG.Full_Threshold_Assert_Value {509} CONFIG.Full_Threshold_Negate_Value {508}] [get_ips Wid70_Dep512_FIFO]
generate_target {instantiation_template} [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/Wid70_Dep512_FIFO/Wid70_Dep512_FIFO.xci]
generate_target all [get_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/Wid70_Dep512_FIFO/Wid70_Dep512_FIFO.xci]
catch { config_ip_cache -export [get_ips -all Wid70_Dep512_FIFO] }
export_ip_user_files -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/Wid70_Dep512_FIFO/Wid70_Dep512_FIFO.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ../Aurora_test/Aurora_test.srcs/sources_1/ip/Wid70_Dep512_FIFO/Wid70_Dep512_FIFO.xci]
launch_runs -jobs 12 Wid70_Dep512_FIFO_synth_1
export_simulation -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/Wid70_Dep512_FIFO/Wid70_Dep512_FIFO.xci] -directory ../Aurora_test/Aurora_test.ip_user_files/sim_scripts -ip_user_files_dir ../Aurora_test/Aurora_test.ip_user_files -ipstatic_source_dir ../Aurora_test/Aurora_test.ip_user_files/ipstatic -lib_map_path [list {modelsim=../Aurora_test/Aurora_test.cache/compile_simlib/modelsim} {questa=../Aurora_test/Aurora_test.cache/compile_simlib/questa} {ies=../Aurora_test/Aurora_test.cache/compile_simlib/ies} {vcs=../Aurora_test/Aurora_test.cache/compile_simlib/vcs} {riviera=../Aurora_test/Aurora_test.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name aurora_64b66b_m_0_reg_slice_0
set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1}] [get_ips aurora_64b66b_m_0_reg_slice_0]
generate_target {instantiation_template} [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_0/aurora_64b66b_m_0_reg_slice_0.xci]
generate_target all [get_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_0/aurora_64b66b_m_0_reg_slice_0.xci]
catch { config_ip_cache -export [get_ips -all aurora_64b66b_m_0_reg_slice_0] }
export_ip_user_files -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_0/aurora_64b66b_m_0_reg_slice_0.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_0/aurora_64b66b_m_0_reg_slice_0.xci]
launch_runs -jobs 12 aurora_64b66b_m_0_reg_slice_0_synth_1
export_simulation -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_0/aurora_64b66b_m_0_reg_slice_0.xci] -directory ../Aurora_test/Aurora_test.ip_user_files/sim_scripts -ip_user_files_dir ../Aurora_test/Aurora_test.ip_user_files -ipstatic_source_dir ../Aurora_test/Aurora_test.ip_user_files/ipstatic -lib_map_path [list {modelsim=../Aurora_test/Aurora_test.cache/compile_simlib/modelsim} {questa=../Aurora_test/Aurora_test.cache/compile_simlib/questa} {ies=../Aurora_test/Aurora_test.cache/compile_simlib/ies} {vcs=../Aurora_test/Aurora_test.cache/compile_simlib/vcs} {riviera=../Aurora_test/Aurora_test.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name aurora_64b66b_m_0_reg_slice_2
set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.TUSER_WIDTH {5}] [get_ips aurora_64b66b_m_0_reg_slice_2]
generate_target {instantiation_template} [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_2/aurora_64b66b_m_0_reg_slice_2.xci]
generate_target all [get_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_2/aurora_64b66b_m_0_reg_slice_2.xci]
catch { config_ip_cache -export [get_ips -all aurora_64b66b_m_0_reg_slice_2] }
export_ip_user_files -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_2/aurora_64b66b_m_0_reg_slice_2.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_2/aurora_64b66b_m_0_reg_slice_2.xci]
launch_runs -jobs 12 aurora_64b66b_m_0_reg_slice_2_synth_1
export_simulation -of_objects [get_files ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0_reg_slice_2/aurora_64b66b_m_0_reg_slice_2.xci] -directory ../Aurora_test/Aurora_test.ip_user_files/sim_scripts -ip_user_files_dir ../Aurora_test/Aurora_test.ip_user_files -ipstatic_source_dir ../Aurora_test/Aurora_test.ip_user_files/ipstatic -lib_map_path [list {modelsim=../Aurora_test/Aurora_test.cache/compile_simlib/modelsim} {questa=../Aurora_test/Aurora_test.cache/compile_simlib/questa} {ies=../Aurora_test/Aurora_test.cache/compile_simlib/ies} {vcs=../Aurora_test/Aurora_test.cache/compile_simlib/vcs} {riviera=../Aurora_test/Aurora_test.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
set_property SOURCE_SET sources_1 [get_filesets sim_1]

import_files {./source_file/General_Aurora_TOP.v ./source_file/RX_FIFO_Ctrler.v ./source_file/aurora_64b66b_m_0_exdes.v ./source_file/aurora_64b66b_m_0_example_ll_to_axi.v ./source_file/TX_FIFO_Ctrler.v ./source_file/aurora_64b66b_m_0_cdc_sync_exdes.v ./source_file/Aurora_IP_top.v ./source_file/aurora_64b66b_m_0_example_axi_to_ll.v }
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1
import_files -fileset sim_1 ./tb/TB_General_Aurora.v
update_compile_order -fileset sim_1
# Disabling source management mode.  This is to allow the top design properties to be set without GUI intervention.
set_property source_mgmt_mode None [current_project]
set_property top TB_GENERAL_AURORA [get_filesets sim_1]
# Re-enabling previously disabled source management mode.
set_property source_mgmt_mode All [current_project]
update_compile_order -fileset sim_1

#remove_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.v
#file delete -force ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0.v

#remove_files  ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0/src/aurora_64b66b_m_0_support.v
#file delete -force ../Aurora_test/Aurora_test.srcs/sources_1/ip/aurora_64b66b_m_0/aurora_64b66b_m_0/src/aurora_64b66b_m_0_support.v
#./source_file/aurora_64b66b_m_0.v ./source_file/aurora_64b66b_m_0_support.v 