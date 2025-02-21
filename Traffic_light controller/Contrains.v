`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2024 13:25:13
// Design Name: 
// Module Name: traffic_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_tb;

//Internal wires/regs
wire [4:0] i_NS_Count   ;
wire [3:0] i_EW_Count   ;
wire [1:0] yellow_count ;
reg         CLK         ;

//INPUTS
reg         NS_vehicle_detect   ;
reg         EW_vehicle_detect   ;

//OUTPUTS
wire        NS_red      ;
wire        NS_yellow   ;
wire        NS_green    ;
wire        EW_red      ;
wire        EW_yellow   ;
wire        EW_green    ;


//Initial Block
initial begin

    CLK                 = 1'b0  ;
    NS_vehicle_detect   = 1'b1  ;
    EW_vehicle_detect   = 1'b0  ;
    
    $display("  NS      |       EW  ");
    $display("  R   Y   G   R   Y   G   ");
    $monitor(" %h  %h  %h  %h  %h  %h ",NS_red, NS_yellow, NS_green, EW_red, EW_yellow, EW_green);
    
    #1000 $finish;
    
end

//Clock Generator
always
    #5 CLK          = ~CLK  ;
 
 //Test case 2   
//always@(CLK) begin
//    if($time % 21 == 0) begin
//      NS_vehicle_detect = ~NS_vehicle_detect;
//      EW_vehicle_detect = ~EW_vehicle_detect;
//  end
//end
 
 //end of test case 2

//Test case 2   
always@(CLK) begin
    if($time % 6 == 0) 
        NS_vehicle_detect = ~NS_vehicle_detect;
    if($time % 15 == 0) 
        EW_vehicle_detect = ~EW_vehicle_detect;
 end
 
 //end of test case 3
//Instantiations

//TRAFFIC CORE
traffic_light_ctrl_eng CORE(
//inputs
.i_NS_Count             (i_NS_Count),
.i_EW_Count             (i_EW_Count),
.yellow_count           (yellow_count),
.NS_vehicle_detect      (NS_vehicle_detect),
.EW_vehicle_detect      (EW_vehicle_detect),
//outputs
.NS_red                 (NS_red),
.NS_yellow              (NS_yellow),
.NS_green               (NS_green),
.EW_red                 (EW_red),
.EW_yellow              (EW_yellow),
.EW_green               (EW_green)
) ;

//NORTH SOUTH COUNTER
NS_Count i_NS_Count_0 (
.i_clk                  (CLK),
.o_count                (i_NS_Count)
) ;

//EAST WEST COUNTER
EW_Count i_EW_Count_0 (
.i_clk                  (CLK),
.o_count                (i_EW_Count)
) ;

//YELLOW LIGHT COUNTER
yellow_count i_yellow_count_0 (
.i_clk                  (CLK),
.o_count                (yellow_count)
) ;
endmodule
