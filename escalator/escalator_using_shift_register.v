`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:25:46 07/26/2024 
// Design Name: 
// Module Name:    escalator_using_shift_register 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module escalator_using_shift_register(clk,rst_n,requested_floor,required_floor);
input [3:0] requested_floor;
input clk,rst_n;
output [3:0]required_floor;
reg [3:0] current_floor;

reg [25:0] count;//counter for 1 sec delay
always@(posedge clk or negedge rst_n)
begin
if(~rst_n)count<=26'd0;
else count<=count+1'b1;
end

always@(negedge count[25] or negedge rst_n ) //used count[25] so that the counter waits to count till 
begin
if(~rst_n)current_floor <= 4'b0001;
else if(requested_floor == current_floor || requested_floor == 4'b0000)current_floor <= current_floor;
else if(requested_floor > current_floor)current_floor <= current_floor << 1;
else if(requested_floor < current_floor)current_floor <= current_floor >> 1;
end
assign required_floor = current_floor;
endmodule
