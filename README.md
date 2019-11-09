# General_Aurora_Intf

| 版本 | 修改日期 | 修改描述 | 作者 |
|-----|---------|---------|-----|
|1.0|2019-11-08|初版General Aurora Intf，仅可通过tcl生成一个固定的示例Vivado工程|Michael张仲禹|
| | | | |
----------------------
General_Aurora_Intf is a simple example for using Xilinx Aurora 64B66B IP core.
````
Directory Structure
|--General_Aurora_Intf        // General_Aurora_Intf get from github
  |--source_file              // Verilog source file
  |--tb                       // Testbench
  |--Aurora_gen.tcl           // A Tcl file that use to create General_Aurora_Intf's Vivado project
  |--LICENSE             
  |--README.md                
````



## Get Start 
 1. Clone this Repo and you will get a folder named <kbd>General_Aurora_Intf</kbd> 
 2. Put folder <kbd>General_Aurora_Intf</kbd> into a directory you want, for emample **/home/michael**
 3. Open terminal and run the following commands in order: 
````shell
        $ cd /home/michael/General_Aurora_Intf
        $ vivado -mode batch -source Aurora_gen.tcl 
````
 4. After the command is finished, a new folder named <kbd>Aurora_test</kbd> has been created. Also,<kbd>Aurora_test</kbd> is in the same directory as <kbd>General_Aurora_Intf</kbd>, that means, you have both **/home/michael/General_Aurora_Intf** and **/home/michael/Aurora_test** now.
 5. The folder <kbd>Aurora_test</kbd> contains General_Aurora_intf 's Vivado project.
> ***MENTION***:The Vivado release version must support the IP cores in this project.  
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Vivado 2017.2 is recommended for this project.