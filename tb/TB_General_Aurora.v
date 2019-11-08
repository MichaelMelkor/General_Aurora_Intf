// **************************************************************        
// COPYRIGHT(c)2019, Xidian University
// All rights reserved.
//
// IP LIB INDEX : 
// IP Name      : 
//                
// File name     : TB_General_Aurora.v
// Module name  :  TB_GENERAL_AURORA
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
// This File is  Created on 2019/October/29  Tuesday.
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
module TB_GENERAL_AURORA();

//*******************
//DEFINE PARAMETER
//*******************
//Parameter(s) 
//************************CLK Para******************************
parameter       TIME_UNIT  = 1; // Do not modify this parameter. 
parameter       SysCLK_PERIOD_200 = 5.000	*TIME_UNIT; 
parameter       RefCLK_PERIOD_15625 = 6.400	*TIME_UNIT;
parameter       UsrCLK_PERIOD_125 = 8.000	*TIME_UNIT;


//*********************
//INNER SIGNAL DECLARATION
//*********************
//REGs
reg rst_n;
reg System_CLK_N;
reg GT_REF_CLK_N;

//WIREs
wire m0_CHANNEL_UP;
wire System_CLK_P;
wire GT_REF_CLK_P;
//wire m0_RXP;
//wire m0_RXN;
wire m0_TXP;
wire m0_TXN;

reg            m0_usr_wrclk     ;
reg  [63:0]   m0_txdata_i      ;
reg           m0_txdata_sop_i  ;
reg           m0_txdata_eop_i  ;
reg           m0_txdata_valid_i;
reg  [2:0]    m0_txdata_mod_i  ;
reg           m0_tx_fifo_wren  ;
wire           m0_fifo_full     ;

reg            m0_usr_rdclk     ;
wire  [63:0]   m0_rxdata_o      ;
wire           m0_rxdata_sop_o  ;
wire           m0_rxdata_eop_o  ;
wire           m0_rxdata_valid_o;
wire  [2:0]    m0_rxdata_mod_o  ;
reg           m0_rx_fifo_rden  ;
wire           m0_fifo_empty    ;

//*********************
//INSTANTCE MODULE
//*********************
GENERAL_AURORA_TOP DUT(
 //Global
   /* input */      .rst_n         (rst_n) ,   
 // Aurora IP interface
     //---Status
   /* output */     .m0_CHANNEL_UP (m0_CHANNEL_UP) ,
     //---System Interface
   /* input */      .System_CLK_P  (System_CLK_P) ,
   /* input */      .System_CLK_N  (System_CLK_N) ,
     //---GT Reference Clock Interface
   /* input */      .GT_REF_CLK_P  (GT_REF_CLK_P) ,
   /* input */      .GT_REF_CLK_N  (GT_REF_CLK_N) ,
     //---GT Serial I/O
   /* input  */     .m0_RXP        (m0_TXP) ,
   /* input  */     .m0_RXN        (m0_TXN) ,
   /* output */     .m0_TXP        (m0_TXP) ,
   /* output */     .m0_TXN        (m0_TXN) ,
 
 //User Interface for Master core, m0 means master0
     //---TX 
   /* input          */   .m0_usr_wrclk      (m0_usr_wrclk     )  ,
   /* input   [63:0] */   .m0_txdata_i       (m0_txdata_i      )  ,          
   /* input          */   .m0_txdata_sop_i   (m0_txdata_sop_i  )  ,          
   /* input          */   .m0_txdata_eop_i   (m0_txdata_eop_i  )  ,          
   /* input          */   .m0_txdata_valid_i (m0_txdata_valid_i)  ,          
   /* input   [2:0]  */   .m0_txdata_mod_i   (m0_txdata_mod_i  )  ,          
   /* input          */   .m0_tx_fifo_wren   (m0_tx_fifo_wren  )  ,          
   /* output         */   .m0_fifo_full      (m0_fifo_full     )  ,  
     //---RX
   /* input           */  .m0_usr_rdclk      (m0_usr_rdclk     )  ,
   /* output   [63:0] */  .m0_rxdata_o       (m0_rxdata_o      )  ,          
   /* output          */  .m0_rxdata_sop_o   (m0_rxdata_sop_o  )  ,          
   /* output          */  .m0_rxdata_eop_o   (m0_rxdata_eop_o  )  ,          
   /* output          */  .m0_rxdata_valid_o (m0_rxdata_valid_o)  ,          
   /* output   [2:0]  */  .m0_rxdata_mod_o   (m0_rxdata_mod_o  )  ,          
   /* input           */  .m0_rx_fifo_rden   (m0_rx_fifo_rden  )  ,          
   /* output          */  .m0_fifo_empty     (m0_fifo_empty    )    
);


//*********************
//MAIN CORE
//*********************
//*******************************Clock Generate***********************************
initial GT_REF_CLK_N = 1'b0;
always #(RefCLK_PERIOD_15625 / 2) GT_REF_CLK_N = !GT_REF_CLK_N;
assign GT_REF_CLK_P = !GT_REF_CLK_N;

initial System_CLK_N = 1'b0;
always #(SysCLK_PERIOD_200 / 2) System_CLK_N = !System_CLK_N;
assign System_CLK_P = !System_CLK_N;

initial m0_usr_wrclk = 1'b0;
always #(UsrCLK_PERIOD_125 / 2) m0_usr_wrclk = !m0_usr_wrclk;

initial m0_usr_rdclk = 1'b0;
always #(UsrCLK_PERIOD_125 / 2) m0_usr_rdclk = !m0_usr_rdclk;

 
//********************************Basic Task Define*******************************
task User_TX_TransData;
input [3:0] frame_NO;
input [9:0] num_8Byte; //2~1023
input [7:0] key1;
input [7:0] key2;
reg   [31:0] feature_frameNO;
reg   [15:0] feature_cnt;
reg   [7:0] feature1;
reg   [7:0] feature2;
begin
    feature_frameNO = {frame_NO,frame_NO,frame_NO,frame_NO,frame_NO,frame_NO,frame_NO,frame_NO};
    feature_cnt = 16'h0001;
    feature1 = key1;//8'h0E;
    feature2 = key2;//8'hAC;

    m0_txdata_i       = 64'b0;
    m0_txdata_sop_i   = 1'b0;
    m0_txdata_eop_i   = 1'b0;
    m0_txdata_valid_i = 1'b0;
    m0_txdata_mod_i   = 3'b0;
    m0_tx_fifo_wren   = 1'b0;
    #100
    $display("\n### Driver Ready! TB_General_Aurora: @Time : %0t Driver Ready! Frame NO. %d\n",$time,frame_NO);
    
    wait(m0_CHANNEL_UP==1'b1);
    #100
    @(posedge m0_usr_wrclk) // Generate SOP
    m0_txdata_i       = {feature_frameNO,feature_frameNO};
    m0_txdata_sop_i   = 1'b1;
    m0_txdata_eop_i   = 1'b0;
    m0_txdata_valid_i = 1'b1;
    m0_txdata_mod_i   = 3'b0;
    m0_tx_fifo_wren   = 1'b1;
    $display("\n### TB_General_Aurora: @Time : %0t Start to Generate TX DATA\n",$time);
    $display("### TB_General_Aurora: @Time : %0t The Frame Now is NO. %d\n",$time,frame_NO);

    repeat(num_8Byte-2) begin
        @(posedge m0_usr_wrclk)
        m0_txdata_i       = {feature_frameNO,feature2,feature1,feature_cnt};
        m0_txdata_sop_i   = 1'b0;
        m0_txdata_eop_i   = 1'b0;
        m0_txdata_valid_i = 1'b1;
        m0_txdata_mod_i   = 3'b0;
        m0_tx_fifo_wren   = 1'b1;

        feature_cnt = feature_cnt +16'h1;
        feature1 = feature1 +8'h1;
        feature2 = feature2 +8'h1;

    end

    @(posedge m0_usr_wrclk) // Generate EOP
    m0_txdata_i       = {feature_frameNO,32'hffff_ffff};
    m0_txdata_sop_i   = 1'b0;
    m0_txdata_eop_i   = 1'b1;
    m0_txdata_valid_i = 1'b1;
    m0_txdata_mod_i   = 3'b0;
    m0_tx_fifo_wren   = 1'b1;

    feature_cnt = feature_cnt +16'h1;
    feature1 = feature1 +8'h1;
    feature2 = feature2 +8'h1;
    $display("\n### TB_General_Aurora: @Time : %0t Finish Generate TX DATA\n",$time);
    $display("### TB_General_Aurora: @Time : %0t The Frame Now is NO. %d\n",$time,frame_NO);
    $display("### TB_General_Aurora: @Time : %0t The 8Byte Counter Now is %d\n",$time,feature_cnt);

    repeat(3) begin
        @(posedge m0_usr_wrclk)//填充间隔
        m0_txdata_i       = 64'h0;
        m0_txdata_sop_i   = 1'b0;
        m0_txdata_eop_i   = 1'b0;
        m0_txdata_valid_i = 1'b0;
        m0_txdata_mod_i   = 3'b0;
        m0_tx_fifo_wren   = 1'b1;
    end

    @(posedge m0_usr_wrclk)
    m0_txdata_i       = 64'h0;
    m0_txdata_sop_i   = 1'b0;
    m0_txdata_eop_i   = 1'b0;
    m0_txdata_valid_i = 1'b0;
    m0_txdata_mod_i   = 3'b0;
    m0_tx_fifo_wren   = 1'b0;
end
endtask


task User_RX_CheckData;
input [3:0] frame_NO;
input [9:0] num_8Byte; //2~1023
input [7:0] key1;
input [7:0] key2;

reg   [9:0] cnt_8Byte;
reg   [63:0] expect_data;
reg   [31:0] feature_frameNO;
reg   [15:0] feature_cnt;
reg   [7:0] feature1;
reg   [7:0] feature2;

begin
    cnt_8Byte = 10'd0;
    feature_cnt = 16'h0001;
    feature_frameNO = {frame_NO,frame_NO,frame_NO,frame_NO,frame_NO,frame_NO,frame_NO,frame_NO};
    feature1 = key1;//8'h0E;
    feature2 = key2;//8'hAC;
    m0_rx_fifo_rden=1'b0;
    #100
    $display("\n### Checker Ready! TB_General_Aurora: @Time : %0t Checker Ready! Frame NO. %d\n",$time,frame_NO);
    while (cnt_8Byte!=num_8Byte) begin
        if (m0_fifo_empty==1'b0) begin
            if (m0_rx_fifo_rden==1'b0) begin
                m0_rx_fifo_rden=1'b1;
                @(posedge m0_usr_rdclk);
            end
            else begin
                m0_rx_fifo_rden=1'b1;
            end
            #1 //delay for sample
            if(m0_rxdata_valid_o==1'b1) begin
                if (m0_rxdata_sop_o==1'b1) begin
                    expect_data = {feature_frameNO,feature_frameNO};
                    if (m0_rxdata_o == expect_data) begin
                        cnt_8Byte= cnt_8Byte+10'd1;
                        $display("\n### Starting! TB_General_Aurora: @Time : %0t Check Start! Frame NO. %d\n",$time,frame_NO);
                        $display("\n    Expect Data = %h ,Also Real Data = %h  8Byte Counter = %d\n",expect_data,m0_rxdata_o,cnt_8Byte);
    
                    end
                    else begin
                        $display("\n### ERROR! TB_General_Aurora: @Time : %0t Check Fail! Frame NO. %d",$time,frame_NO);
                        $display("\n    Expect Data = %h ,but Real Data = %h \n",expect_data,m0_rxdata_o);                    
                        $stop;
                    end
                end
                else if (m0_rxdata_eop_o==1'b1) begin
                    expect_data =  {feature_frameNO,32'hffff_ffff}; 
                    if (m0_rxdata_o == expect_data) begin
                        cnt_8Byte= cnt_8Byte+10'd1;
                        m0_rx_fifo_rden=1'b0;
                        $display("\n### Success! TB_General_Aurora: @Time : %0t Check Sucessfully! Frame NO. %d",$time,frame_NO);
                        $display("\n    Expect Data = %h ,Also Real Data = %h  8Byte Counter = %d\n",expect_data,m0_rxdata_o,cnt_8Byte);
                        #1000 $stop;
                    end
                    else begin
                        $display("\n### ERROR! TB_General_Aurora: @Time : %0t Check Fail! Frame NO. %d",$time,frame_NO);
                        $display("\n    Expect Data = %h ,but Real Data = %h \n",expect_data,m0_rxdata_o);
                        $stop;    
                    end
                end    
                else begin
                    expect_data = {feature_frameNO,feature2,feature1,feature_cnt};
                    if (m0_rxdata_o == expect_data) begin
                        $display("\n    Expect Data = %h ,Also Real Data = %h  8Byte Counter = %d\n",expect_data,m0_rxdata_o,cnt_8Byte);
                        cnt_8Byte= cnt_8Byte+10'd1;
                        feature_cnt = feature_cnt +16'h1;
                        feature1 = feature1 +8'h1;
                        feature2 = feature2 +8'h1;
                    end
                    else begin
                        $display("\n### ERROR! TB_General_Aurora: @Time : %0t Check Fail! Frame NO. %d",$time,frame_NO);
                        $display("\n    Expect Data = %h ,but Real Data = %h \n",expect_data,m0_rxdata_o);
                        $stop;    
                    end
                end
                @(posedge m0_usr_rdclk);
            end
        end 
        else begin
            m0_rx_fifo_rden=1'b0;
            @(posedge m0_usr_rdclk);
        end
    end
    //@(posedge m0_usr_rdclk)
    //$display("\n### Finish! TB_General_Aurora: @Time : %0t Check Finish! Frame NO. %d\n",$time,frame_NO);
    #100;
end
endtask

//*******************Stimulus Generate***************
initial begin
    rst_n = 1'b1;
    #100
    rst_n = 1'b0;
    #100
    rst_n = 1'b1;
end

/* initial begin
    User_TX_TransData(4'd1,10'd512,8'h0E,8'hAC);
    //User_RX_CheckData(4'd1,10'd512,8'h0E,8'hAC);
end

initial begin
    //User_TX_TransData(4'd1,10'd512,8'h0E,8'hAC);
    //#53000
    User_RX_CheckData(4'd1,10'd512,8'h0E,8'hAC);
end */
initial begin
    User_TX_TransData(4'd1,10'd512,8'h0E,8'hAC);
    User_RX_CheckData(4'd1,10'd512,8'h0E,8'hAC);
    User_TX_TransData(4'd2,10'd388,8'h4C,8'h81);
    User_RX_CheckData(4'd2,10'd388,8'h4C,8'h81);
    User_TX_TransData(4'd3,10'd123,8'hAA,8'h77);
    User_RX_CheckData(4'd3,10'd123,8'hAA,8'h77);
end




initial begin
    @(negedge m0_fifo_empty)
    $display("\n*** RX_FIFO Has Data NOW! TB_General_Aurora: @Time : %0t RX_FIFO Has Data NOW!\n",$time);
end
initial begin
    @(posedge m0_CHANNEL_UP)
    $display("\n*** Channel UP! TB_General_Aurora: @Time : %0t Channel UP!\n",$time);
end

//*********************
endmodule