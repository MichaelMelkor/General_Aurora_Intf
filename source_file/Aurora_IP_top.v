// **************************************************************        
// COPYRIGHT(c)2019, Xidian University
// All rights reserved.
//
// IP LIB INDEX : 
// IP Name      : 
//                
// File name     : Aurora_IP_top.v
// Module name  :  AURORA_IP_TOP
// Full name     : 
//
// Author        :  Zhang-Zhongyu 
// Email         :  zhangzhongyu1202@126.com
// Data          :   
// Version        :  V 1.0 
// 
//Abstract        :
// Called by       :  Father Module
// 
// This File is  Created on 2019/October/26  Saturday.
// Modification history
// ---------------------------------------------------------------------------------
// Log
//  V1.0  
// *********************************************************************

// *******************
// TIMESCALE
// ******************* 
`timescale 1ns/1ps 

//*******************
//DEFINE(s)
//*******************
//`define UDLY 1    //Unit delay, for non-blocking assignments in sequential logic

//*******************
//DEFINE MODULE PORT
//*******************
module AURORA_IP_TOP(
                   //Global
                  input      RESET         ,   

                  // Status
                  output CHANNEL_UP ,

                  // System Interface
                  input System_CLK_P,
                  input System_CLK_N,

                  // GT Reference Clock Interface
                  input GT_REF_CLK_P,
                  input GT_REF_CLK_N,

                  //TX Interface
                    input      [0:63]     txdata_i      ,
                    input                 txdata_sop_n_i,
                    input                 txdata_eop_n_i,
                    input       [0:2]     txdata_mod_i  ,
                    input                 tx_src_rdy_n_i,
                    output                tx_dst_rdy_n_o,
                  //RX Interface
                    output      [0:63]     rxdata_o      ,
                    output                 rxdata_sop_n_o,
                    output                 rxdata_eop_n_o,
                    output     [0:2]       rxdata_mod_o  ,
                    output                 rx_src_rdy_n_o,

                  //User Clock
                    output                 user_clk_o,

                  // GTX Serial I/O
                    input              RXP,
                    input              RXN,
                  
                    output             TXP,
                    output             TXN
                        );

//*******************
//DEFINE PARAMETER
//*******************
//Parameter(s) 


//*********************
//INNER SIGNAL DECLARATION
//*********************
//REGs

//WIREs
wire INIT_CLK; 
wire DRP_CLK; 

//*********************
//INSTANTCE MODULE
//*********************
clk_wiz_0 INIT_DRP_CLK_gen
 (
  // Clock out ports
  .INIT_CLK(INIT_CLK),     // output INIT_CLK
  .DRP_CLK(DRP_CLK),     // output DRP_CLK
  // Status and control signals
  .reset(RESET), // input reset
  .locked(),       // output locked
 // Clock in ports
  .clk_in1_p(System_CLK_P),    // input clk_in1_p
  .clk_in1_n(System_CLK_N));    // input clk_in1_n


aurora_64b66b_m_0_exdes aurora_master_0
 (
     // User IO
     .RESET(RESET),
     // Error signals from Aurora    
     .HARD_ERR			(),
     .SOFT_ERR			(),
 
     // Status Signals
     .LANE_UP(),
     .CHANNEL_UP		(CHANNEL_UP),
 
 
     .INIT_CLK_IN		(INIT_CLK),
     .PMA_INIT			(1'b0),
     .DRP_CLK_IN		(DRP_CLK),
 
     // Clock Signals
     .GTHQ1_P		(GT_REF_CLK_P),
     .GTHQ1_N		(GT_REF_CLK_N),

     //User Interface
     .txdata_i       (txdata_i      ),
     .txdata_sop_n_i (txdata_sop_n_i),
     .txdata_eop_n_i (txdata_eop_n_i),
     .txdata_mod_i   (txdata_mod_i  ),
     .tx_src_rdy_n_i (tx_src_rdy_n_i),
     .tx_dst_rdy_n_o (tx_dst_rdy_n_o),

     .rxdata_o       (rxdata_o      ),
     .rxdata_sop_n_o (rxdata_sop_n_o),
     .rxdata_eop_n_o (rxdata_eop_n_o),
     .rxdata_mod_o   (rxdata_mod_o  ),
     .rx_src_rdy_n_o (rx_src_rdy_n_o),

     .user_clk_o     (user_clk_o),
 
     // GT I/O
     .RXP			(RXP),
     .RXN			(RXN),
 
     .TXP			(TXP),
     .TXN			(TXN)

 );

//*********************
//MAIN CORE
//*********************



//*********************
endmodule