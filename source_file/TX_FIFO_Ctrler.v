// **************************************************************        
// COPYRIGHT(c)2019, Xidian University
// All rights reserved.
//
// IP LIB INDEX : 
// IP Name      : 
//                
// File name     : TX_FIFO_Ctrler.v
// Module name  :  TX_FIFO_CTRLER
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
module TX_FIFO_CTRLER(
                   //Global
                  input      rst_n         , 
                  //User Side Interface  
                  input            wrclk,
                  input   [63:0]   txdata_i,          
                  input            txdata_sop_i,          
                  input            txdata_eop_i,          
                  input            txdata_valid_i,          
                  input   [2:0]    txdata_mod_i,          
                  input            tx_fifo_wren,          
                  output           fifo_full,  

                  //Aurora IP Side Interface 
                  input               rdclk,
                  output      [63:0]  txdata_o      ,
                  output              txdata_sop_n_o,
                  output              txdata_eop_n_o,
                  output     [2:0]    txdata_mod_o  ,
                  output  reg         tx_src_rdy_n_o,
                  input               tx_dst_rdy_n_i      


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
//-----User write logic
wire        wr_en; 
wire [69:0] fifo_data_in;
wire        full;
wire        almost_full;

//-----Aurora IP read logic
wire        rd_en;
wire [69:0] fifo_data_out;
wire        txdata_valid_o;
wire        empty;
wire        almost_empty;

//*********************
//INSTANTCE MODULE
//*********************
Wid70_Dep512_FIFO TX_FIFO (
  .rst(~rst_n),                    // input wire rst
  .wr_clk(wrclk),              // input wire wr_clk
  .rd_clk(rdclk),              // input wire rd_clk
  .din(fifo_data_in),                    // input wire [69 : 0] din
  .wr_en(wr_en),                // input wire wr_en
  .rd_en(rd_en),                // input wire rd_en
  .dout(fifo_data_out),                  // output wire [69 : 0] dout
  .full(full),                  // output wire full
  .almost_full(almost_full),    // output wire almost_full
  .empty(empty),                // output wire empty
  .almost_empty(almost_empty)  // output wire almost_empty
);


//*********************
//MAIN CORE
//*********************
//===================================================================// 
//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ User Write Logic start  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
//===================================================================// 
assign wr_en = tx_fifo_wren ; //input wr_en from user

assign fifo_data_in = {txdata_mod_i,txdata_sop_i,txdata_eop_i,txdata_valid_i,txdata_i} ;//{3',1',1',1',64'}

assign fifo_full = full | almost_full ;
//====================================================================//
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ User Write Logic finish  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
//====================================================================//

//========================================================================// 
//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ Aurora IP Read Logic start  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
//========================================================================// 
assign rd_en = ~tx_dst_rdy_n_i & ~empty ;//use ~dsr_rdy as rd_en

assign txdata_o       = fifo_data_out[63:0] ; //split the output
assign txdata_mod_o   = fifo_data_out[69:67] ;
assign txdata_sop_n_o = ~fifo_data_out[66] ;
assign txdata_eop_n_o = ~fifo_data_out[65] ;
assign txdata_valid_o =  fifo_data_out[64] ;

/* always @(posedge rdclk or negedge rst_n) 
begin
    if (rst_n == 1'b0) begin
        tx_src_rdy_n_o <= 1'b1;
    end
    else if(empty==1'b1 && rd_en==1'b1) begin //avoid tx_src_rdy_n_o still keep 0 when fifo is empty
        tx_src_rdy_n_o <= 1'b1;
    end
    else if(empty==1'b1 && rd_en==1'b0) begin
        tx_src_rdy_n_o <= ~txdata_valid_o;
    end
    else if(rd_en==1'b1) begin
        tx_src_rdy_n_o <= ~txdata_valid_o;
    end
    else begin
        tx_src_rdy_n_o <= tx_src_rdy_n_o;
    end
end */

always @(*) 
begin  
    tx_src_rdy_n_o <= ~txdata_valid_o;
end
//========================================================================//
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ Aurora IP Read Logic finish ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
//========================================================================//




//*********************
endmodule