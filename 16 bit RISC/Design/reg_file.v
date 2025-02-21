// TimeScale
`timescale 1ns / 1ps

//Module Definition
module reg_file(
    // Inputs
	input I_clk,
	input I_en,
	input I_we,
	input [2:0] I_selA,
	input [2:0] I_selB,
	input [2:0] I_selD,
	input [15:0] I_dataD,
	// Outputs
	output reg [15:0] O_dataA,
	output reg [15:0] O_dataB 
);

    // Internal register declaration
	reg [15:0] regs [7:0];
	
	// Loop Variable
	integer count;
	  
	// Initialize register 
	initial begin 
	    O_dataA = 0;
		O_dataB = 0;
		
		for(count = 0; count  < 8; count = count + 1) begin 
		    regs[count] = 0;
    end 
    end
	
	// Assigning correct values to Op regs 
    always@(negedge I_clk) begin 
	    if(I_en) begin 
		    if(I_we) 
			    regs[I_selD] <= I_dataD;
				
			O_dataA <= regs[I_selA];
			O_dataB <= regs[I_selB];
			end
	end
	
endmodule
