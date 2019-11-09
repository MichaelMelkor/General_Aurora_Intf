# General_Aurora_Intf

| 版本 | 修改描述 | 修改日期 | 作者 |
|-----|---------|---------|-----|
|1.0|初版General Aurora Intf，仅可通过tcl生成一个固定的示例Vivado工程|2019-11-08|Michael|
| | | | |

## Get Start 
> 1. Clone this Repo and you will get a folder named <kbd>General_Aurora_Intf</kbd> 
> 2. Put folder <kbd>General_Aurora_Intf</kbd> into a directory you want, for emample **/home/michael**
> 3. Open terminal and run the following commands in order: 
````shell
        $ cd /home/michael/General_Aurora_Intf
        $ vivado -mode batch -source Aurora_gen.tcl 
````
> 4. After the command is finished, a new folder named <kbd>Aurora_test</kbd> has been created. Also,<kbd>Aurora_test</kbd> is in the same directory as <kbd>General_Aurora_Intf</kbd>, that means, you have both **/home/michael/General_Aurora_Intf** and **/home/michael/Aurora_test** now.
> 5. The folder <kbd>Aurora_test</kbd> contains General_Aurora_intf 's Vivado project.
> MENTION