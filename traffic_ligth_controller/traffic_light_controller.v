`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:27 07/21/2024 
// Design Name: 
// Module Name:    trafficlightcontroller 
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
module traffic_light_controller(clk,rst,reset_timer,light_west,light_east,light_north,light_south);
  input clk,rst,reset_timer;
  wire one_sec_timer,five_sec_timer;
  output reg [1:0] light_west,light_east,light_north,light_south;
  parameter idle=4'b0000,s0=4'b0001,s1=4'b0010,s2=4'b0011,s3=4'b0100,s4=4'b0101,s5=4'b0110,s6=4'b0111,s7=4'b1000;
  parameter R=2'b00,Y=2'b01,G=2'b10;
  reg [3:0] current_state,next_state;
  
  
timer t0(
      .clk_50m(clk),
      .reset_n(rst),
      .reset_timer(reset_timer),

     .one_sec_timer(one_sec_timer),
    .five_sec_timer(five_sec_timer)
);

  always@(posedge clk or negedge rst or negedge reset_timer)
    begin
      if(!rst || !reset_timer)
        begin
        current_state<=idle;
        end
      else
        begin
        current_state<=next_state;
		 end
    end
  always@(current_state or one_sec_timer or five_sec_timer )
    begin
      case(current_state)
        idle:
          begin
				 light_west= Y;
				 light_east= Y;
				 light_north= Y;
				 light_south= Y;
				  if(one_sec_timer)next_state=s0;
					else next_state=idle;
           end
        s0:
			begin
				light_west= G;
				light_east= R;
				light_north= R;
				light_south= R;
            if(five_sec_timer)next_state=s1;
			   else next_state=s0;
          end
        s1:
          begin
				light_west= Y;
				light_east= Y;
				light_north= R;
				light_south= R;
            if(one_sec_timer)next_state=s2;
			   else next_state=s1;
           
          end
        s2:
          begin
				light_west= R;
				light_east= G;
				light_north= R;
				light_south= R;
            if(five_sec_timer)next_state=s3;
			   else next_state=s2;
            
          end
        s3:
          begin
				light_west= R;
				light_east= Y;
				light_north= Y;
				light_south= R;
            if(one_sec_timer)next_state=s4;
			   else next_state=s3;
            
          end
        s4:
          begin
				light_west= R;
				light_east= R;
				light_north= G;
				light_south= R;
            if(five_sec_timer)next_state=s5;
			   else next_state=s4;
           
          end
        s5:
          begin
				light_west= R;
				light_east= R;
				light_north= Y;
				light_south= Y;
            if(five_sec_timer)next_state=s6;
			   else next_state=s5;
           
          end
        s6:
          begin
				light_west= R;
				light_east= R;
				light_north= R;
				light_south= G;
            if(five_sec_timer)next_state=s7;
			   else next_state=s6;
           
          end
        s7:
          begin
				light_west= Y;
				light_east= R;
				light_north= R;
				light_south= Y;
            if(five_sec_timer)next_state=s0;
			   else next_state=s7;
           
          end
        
      default:
          begin
			   light_west= Y;
				 light_east= Y;
				 light_north= Y;
				 light_south= Y;
            next_state = idle;
			 end
      endcase
    end
endmodule
