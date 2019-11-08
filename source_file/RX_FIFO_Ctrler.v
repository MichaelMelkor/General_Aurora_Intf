// **************************************************************        
// COPYRIGHT(c)2019, Xidian University
// All rights reserved.
//
// IP LIB INDEX : 
// IP Name      : 
//                
// File name     : RX_FIFO_Ctrler.v
// Module name  :  RX_FIFO_CTRLER
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
module RX_FIFO_CTRLER(
                   //Global
                  input      rst_n         , 
                  //User Side Interface  
                  input            rdclk,
                  output   [63:0]   rxdata_o,          
                  output            rxdata_sop_o,          
                  output            rxdata_eop_o,          
                  output    reg     rxdata_valid_o,          
                  output   [2:0]    rxdata_mod_o,          
                  input            rx_fifo_rden,          
                  output           fifo_empty,  

                  //Aurora IP Side Interface 
                  input               wrclk,
                  input      [63:0]  rxdata_i      ,
                  input              rxdata_sop_n_i,
                  input              rxdata_eop_n_i,
                  input     [2:0]    rxdata_mod_i  ,
                  input              rx_src_rdy_n_i,
                  output             fifo_full 


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
wire        rd_en;
wire [69:0] fifo_data_out;
wire        rxdata_valid_i;
wire        empty;
wire        almost_empty;

//-----Aurora IP read logic

wire        wr_en; 
wire [69:0] fifo_data_in;
wire        full;
wire        almost_full;

//*********************
//INSTANTCE MODULE
//*********************
Wid70_Dep512_FIFO RX_FIFO (
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

//========================================================================// 
//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ Aurora IP Write Logic start  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
//========================================================================// 
assign wr_en = ~rx_src_rdy_n_i ; //input wr_en from Aurora IP

assign fifo_data_in = {rxdata_mod_i,~rxdata_sop_n_i,~rxdata_eop_n_i,~rx_src_rdy_n_i,rxdata_i} ;//{3',1',1',1',64'}

assign fifo_full = full | almost_full ;


//========================================================================//
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ Aurora IP Write Logic finish ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
//========================================================================//

//===================================================================// 
//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ User Read Logic start  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
//===================================================================// 
assign rd_en = rx_fifo_rden & (~fifo_empty) ; // avoid read after fifo full
assign fifo_empty = empty /* | almost_empty */ ;


assign rxdata_o       = fifo_data_out[63:0] ; //split the output
assign rxdata_mod_o   = fifo_data_out[69:67] ;
assign rxdata_sop_o = fifo_data_out[66] ;
assign rxdata_eop_o = fifo_data_out[65] ;

/* always @(posedge rdclk or negedge rst_n) 
begin
    if (rst_n == 1'b0) begin
        rxdata_valid_o <= 1'b0;
    end
    else if(empty==1'b1 && rx_fifo_rden==1'b1) begin //当读空后继续读，就输出valid=0的信息
        rxdata_valid_o <= 1'b0;
    end
    else if(empty==1'b0 && rx_fifo_rden==1'b1) begin
        rxdata_valid_o <= fifo_data_out[64];
    end 
    else begin
        rxdata_valid_o <= rxdata_valid_o;
    end
end */

always @(*) 
begin
    rxdata_valid_o <= fifo_data_out[64];
end

//====================================================================//
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ User Read Logic finish  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
//====================================================================//



//*********************
endmodule