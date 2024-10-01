`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:55 07/28/2024 
// Design Name: 
// Module Name:    timer 
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
module timer 
(
    input  wire clk_50m,
    input  wire reset_n,
    input  wire reset_timer,

    output reg  one_sec_timer,
    output reg  five_sec_timer
);

//`define SIM
`ifdef SIM
    localparam FREQ = 50;               //1 us delay  @50 MHz clock
`else
    localparam FREQ = 50 * 1000 * 1000; //1 sec delay @50 MHz clock
`endif


//conversion
localparam SEC_TO_5SEC  = 5;


localparam SEC_WIDTH    = 3;

reg [25:0]                  count;                    // count to manage timing
reg [SEC_WIDTH - 1 : 0]     sec_count;

always @(posedge clk_50m or negedge reset_n or negedge reset_timer) 
begin
    if (!reset_n) 
        begin
            count           <= 26'd0;
            sec_count       <= {(SEC_WIDTH-1){1'b0}};
				one_sec_timer <= 1'b0;
				five_sec_timer <= 1'b0;
        end 
    else begin
                
        if (reset_timer == 0) begin
            count           <= 26'd0;
          sec_count       <= {(SEC_WIDTH-1){1'b0}};
			 one_sec_timer <= 1'b0;
			 five_sec_timer <= 1'b0;
        end

            //1 sec timer
      else if (count == FREQ * 1) 
		begin                          //one sec counter
			count          <= 0;
         one_sec_timer  <= 1'b1;
         five_sec_timer  <= 1'b0;
            
            
            //5 sec timer
        if(sec_count == SEC_TO_5SEC)
        	begin                  //60 sec count
			sec_count   <= {(SEC_WIDTH-1){1'b0}};
            five_sec_timer <=1'b1;
               
        	end
                
        else 
          begin
            
				 sec_count       <= sec_count + 1'b1;
                five_sec_timer   <= 1'b0;
          end
        end 

        else begin  
			   count <= count +1'b1;
            one_sec_timer <= 1'b0;
        	   five_sec_timer <=1'b0;
            
        end   
		  
    end
end
endmodule
