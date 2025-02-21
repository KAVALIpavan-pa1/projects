// TimeScale
`timescale 1ns / 1ps

//Module Definition
module pc_unit(
    // Inputs
	input I_clk,
	input [1:0] I_opcode,
	input [15:0] I_pc,
	// Outputs
	output reg [15:0] O_pc
);

    // Initial Block
	initial begin
	    O_pc <= 0;
	end

    // Program Counter State
	always@(negedge I_clk) begin
	    case(I_opcode)
		    2'b00 : O_pc <= O_pc;
			2'b01 : O_pc <= O_pc + 1;
			2'b10 : O_pc <= I_pc;
			2'b11 : O_pc <= 0;
		endcase
	end	
	
endmodule
