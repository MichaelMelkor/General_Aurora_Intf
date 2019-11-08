// **************************************************************        
// COPYRIGHT(c)2019, Xidian University
// All rights reserved.
//
// IP LIB INDEX : 
// IP Name      : 
//                
// File name     : General_Aurora_TOP.v
// Module name  :  GENERAL_AURORA_TOP
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
// This File is  Created on 2019/October/28  Monday.
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
module GENERAL_AURORA_TOP(
                //Global
                  input      rst_n         ,   

                // Aurora IP interface
                    //---Status
                  output m0_CHANNEL_UP ,
                    //---System Interface
                  input System_CLK_P,
                  input System_CLK_N,
                    //---GT Reference Clock Interface
                  input GT_REF_CLK_P,
                  input GT_REF_CLK_N,
                    //---GT Serial I/O
                  input    m0_RXP,
                  input    m0_RXN,
                  output   m0_TXP,
                  output   m0_TXN,
                
                //User Interface for Master core, m0 means master0
                    //---TX 
                  input            m0_usr_wrclk        ,
                  input   [63:0]   m0_txdata_i         ,          
                  input            m0_txdata_sop_i     ,          
                  input            m0_txdata_eop_i     ,          
                  input            m0_txdata_valid_i   ,          
                  input   [2:0]    m0_txdata_mod_i     ,          
                  input            m0_tx_fifo_wren     ,          
                  output           m0_fifo_full        ,  
                    //---RX
                  input            m0_usr_rdclk        ,
                  output   [63:0]  m0_rxdata_o         ,          
                  output           m0_rxdata_sop_o     ,          
                  output           m0_rxdata_eop_o     ,          
                  output           m0_rxdata_valid_o   ,          
                  output   [2:0]   m0_rxdata_mod_o     ,          
                  input            m0_rx_fifo_rden     ,          
                  output           m0_fifo_empty         



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
//-----Aurora master core   A2U means 'Aurora to User'
wire          m0_usr_clk          ; 

wire  [63:0]  m0_rxdata_A2U       ;
wire          m0_rxdata_sop_n_A2U ;
wire          m0_rxdata_eop_n_A2U ;
wire  [2:0]   m0_rxdata_mod_A2U   ;
wire          m0_rx_src_rdy_n_A2U ;
wire          m0_rx_dst_rdy_n_U2A ;

//wire              m0_usr_clk         ;

wire      [63:0]  m0_txdata_U2A      ;
wire              m0_txdata_sop_n_U2A;
wire              m0_txdata_eop_n_U2A;
wire     [2:0]    m0_txdata_mod_U2A  ;
wire              m0_tx_src_rdy_n_U2A;
wire              m0_tx_dst_rdy_n_A2U;



//*********************
//INSTANTCE MODULE
//*********************
 AURORA_IP_TOP U_AURORA_IP_TOP(
     //Global
    /* input */  .RESET (~rst_n)         ,   

    // Status
    /* output */ .CHANNEL_UP (m0_CHANNEL_UP)    ,

    // System Interface
    /* input */  .System_CLK_P (System_CLK_P)  ,
    /* input */  .System_CLK_N (System_CLK_N)  ,

    // GT Reference Clock Interface
    /* input */  .GT_REF_CLK_P (GT_REF_CLK_P)  ,
    /* input */  .GT_REF_CLK_N (GT_REF_CLK_N)  ,

    //TX Interface
      /* input  [0:63] */     .txdata_i       (m0_txdata_U2A      ) ,
      /* input         */     .txdata_sop_n_i (m0_txdata_sop_n_U2A) ,
      /* input         */     .txdata_eop_n_i (m0_txdata_eop_n_U2A) ,
      /* input   [0:2] */     .txdata_mod_i   (m0_txdata_mod_U2A  ) ,
      /* input         */     .tx_src_rdy_n_i (m0_tx_src_rdy_n_U2A) ,
      /* output        */     .tx_dst_rdy_n_o (m0_tx_dst_rdy_n_A2U) ,
    //RX Interface
      /* output   [0:63] */   .rxdata_o       (m0_rxdata_A2U      ) ,
      /* output          */   .rxdata_sop_n_o (m0_rxdata_sop_n_A2U) ,
      /* output          */   .rxdata_eop_n_o (m0_rxdata_eop_n_A2U) ,
      /* output  [0:2]   */   .rxdata_mod_o   (m0_rxdata_mod_A2U  ) ,
      /* output          */   .rx_src_rdy_n_o (m0_rx_src_rdy_n_A2U) ,

    //User Clock
      /* output */            .user_clk_o (m0_usr_clk) ,

    // GTX Serial I/O
      /* input  */             .RXP (m0_RXP) ,
      /* input  */             .RXN (m0_RXN) ,
    
      /* output */             .TXP (m0_TXP) ,
      /* output */             .TXN (m0_TXN) 
                        );

TX_FIFO_CTRLER U_TX_FIFO_CTRLER_m0(
     //Global
    /* input */      .rst_n (rst_n)         , 
    //User Side Interface  
    /* input          */   .wrclk          (m0_usr_wrclk     )  ,
    /* input   [63:0] */   .txdata_i       (m0_txdata_i      )  ,          
    /* input          */   .txdata_sop_i   (m0_txdata_sop_i  )  ,          
    /* input          */   .txdata_eop_i   (m0_txdata_eop_i  )  ,          
    /* input          */   .txdata_valid_i (m0_txdata_valid_i)  ,          
    /* input   [2:0]  */   .txdata_mod_i   (m0_txdata_mod_i  )  ,          
    /* input          */   .tx_fifo_wren   (m0_tx_fifo_wren  )  ,          
    /* output         */   .fifo_full      (m0_fifo_full     )  ,  
    //Aurora IP Side Interface 
    /* input              */  .rdclk          (m0_usr_clk         ) ,
    /* output      [63:0] */  .txdata_o       (m0_txdata_U2A      ) ,
    /* output             */  .txdata_sop_n_o (m0_txdata_sop_n_U2A) ,
    /* output             */  .txdata_eop_n_o (m0_txdata_eop_n_U2A) ,
    /* output     [2:0]   */  .txdata_mod_o   (m0_txdata_mod_U2A  ) ,
    /* output  reg        */  .tx_src_rdy_n_o (m0_tx_src_rdy_n_U2A) ,
    /* input              */  .tx_dst_rdy_n_i (m0_tx_dst_rdy_n_A2U)     
          );

RX_FIFO_CTRLER U_RX_FIFO_CTRLER_m0(
     //Global
    /* input */            .rst_n (rst_n)        , 
    //User Side Interface 
    /* input           */  .rdclk          (m0_usr_rdclk     ) ,
    /* output   [63:0] */  .rxdata_o       (m0_rxdata_o      ) ,          
    /* output          */  .rxdata_sop_o   (m0_rxdata_sop_o  ) ,          
    /* output          */  .rxdata_eop_o   (m0_rxdata_eop_o  ) ,          
    /* output    reg   */  .rxdata_valid_o (m0_rxdata_valid_o) ,          
    /* output   [2:0]  */  .rxdata_mod_o   (m0_rxdata_mod_o  ) ,          
    /* input           */  .rx_fifo_rden   (m0_rx_fifo_rden  ) ,          
    /* output          */  .fifo_empty     (m0_fifo_empty    ) ,  
    //Aurora IP Side Interface 
    /* input             */  .wrclk           (m0_usr_clk) ,
    /* input      [63:0] */  .rxdata_i        (m0_rxdata_A2U      ) ,
    /* input             */  .rxdata_sop_n_i  (m0_rxdata_sop_n_A2U) ,
    /* input             */  .rxdata_eop_n_i  (m0_rxdata_eop_n_A2U) ,
    /* input     [2:0]   */  .rxdata_mod_i    (m0_rxdata_mod_A2U  ) ,
    /* input             */  .rx_src_rdy_n_i  (m0_rx_src_rdy_n_A2U) ,
    /* output            */  .fifo_full       () 
          );
//*********************
//MAIN CORE
//*********************



//*********************
endmodule