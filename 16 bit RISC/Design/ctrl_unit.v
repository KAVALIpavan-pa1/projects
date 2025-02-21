//TimeScale
`timescale 1ns / 1ps

//Module Definition
module ctrl_unit(
    // Inputs
	input I_clk,
	input I_reset,
	// Outputs
	output O_enfetch,
	output O_endec,
	output O_enrgrd,
	output O_enalu,
	output O_enrgwr,
	output O_enmem
);
    // Reg Declaration
    reg [5:0] state;
	
    // Initial	Block
	initial begin
	    state <= 6'b000001;
	end
	
	//State Select Block
    always@(posedge  I_clk) begin
	    if(I_reset)
		    state  <= 6'b000001;
		else begin	
            case(state)
                6'b000001 : state <= 6'b000010;
				6'b000010 : state <= 6'b000100;
				6'b000100 : state <= 6'b001000;
				6'b001000 : state <= 6'b010000;
				6'b010000 : state <= 6'b100000;
				default : state <= 6'b000001;
			endcase			    
        end
   end
	
    //Assignment Enable Signals
	assign O_enfetch = state[0];
	assign O_endec = state[1];
	assign O_enrgrd = state[2] | state[4];
	assign O_enalu = state[3];
	assign O_enrgwr = state[4];
	assign O_enmem = state[5];
	
endmodule
