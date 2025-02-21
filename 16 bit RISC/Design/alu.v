
// TimeScale
`timescale 1ns/1ps

//Module Definition
module alu(
    // Inputs
	input I_clk,
	input I_en,
	input [4:0] I_aluop,
	input [15:0] I_dataA,
	input [15:0] I_dataB,
	input [7:0] I_imm,
	// Outputs
	output [15:0] O_dataResult,
	output reg O_shldBranch
);

    //Reg/Wire Declaration
	reg [17:0] int_result;
	wire op_lsb;
	wire [3:0] opcode;
	
	// Parameter Declaration
	localparam Add     = 0,
	           Sub     = 1,
			   OR      = 2,
			   AND     = 3,
			   XOR     = 4,
	           NOT     = 5, 
			   Load    = 8,
			   Cmp     = 9,
			   SHL     = 10,
			   SHR     = 11,
			   JMPA    = 12,
			   JMPR    = 13;
			   
			   
	// Initial Block
	initial begin
	    int_result <= 0;
	end
	
	//Assigning Values
	assign op_lsb = I_aluop[0];
	assign opcode = I_aluop[4:1];
	assign O_dataResult = int_result[15:0];
	
	//ALU Operations
	always@(negedge I_clk) begin
	
	    if(I_en) begin
	        case(opcode)
			
	            Add : begin
				        int_result <= (op_lsb ? ($signed(I_dataA) + $signed(I_dataB)) : ( I_dataA + I_dataB));
						O_shldBranch <= 0;
					end
					
				Sub : begin
				        int_result <= (op_lsb ? ($signed(I_dataA) + $signed(I_dataB)) : ( I_dataA + I_dataB));
						O_shldBranch <= 0;
					end
					
				OR :begin
				        int_result <= I_dataA | I_dataB;
						O_shldBranch <= 0;
				   end
				   
				AND :begin
				        int_result <= I_dataA & I_dataB;
						O_shldBranch <= 0;
				    end
					
				XOR :begin
				        int_result <= I_dataA ^ I_dataB;
						O_shldBranch <= 0;
				    end	
					
				NOT :begin
				        int_result <= ~I_dataA;
						O_shldBranch <= 0;
				    end	
					
				Load : begin
                        int_result <= (op_lsb ? ({I_imm, 8'h00}) : ({8'h00, I_imm}));
						O_shldBranch <= 0;
					end 
					
				Cmp : begin
                        if(op_lsb) begin
                         	int_result[0] <= ($signed(I_dataA) == $signed(I_dataB)) ? 1 : 0;	
							int_result[1] <= ($signed(I_dataA) == 0) ? 1 : 0;	
							int_result[2] <= ($signed(I_dataB) == 0) ? 1 : 0;
							int_result[3] <= ($signed(I_dataA) > $signed(I_dataB)) ? 1 : 0;
							int_result[4] <= ($signed(I_dataA) < $signed(I_dataB)) ? 1 : 0;
							end 
						else  begin
							int_result[0] <= (I_dataA == I_dataB) ? 1 : 0;	
							int_result[1] <= (I_dataA == 0) ? 1 : 0;	
							int_result[2] <= (I_dataB == 0) ? 1 : 0;
							int_result[3] <= (I_dataA > I_dataB) ? 1 : 0;
							int_result[4] <= (I_dataA < I_dataB) ? 1 : 0;    
                        end
							O_shldBranch <= 0;
                    end
					
                SHL : begin
                    int_result <= I_dataA << (I_dataB[3:0]);
					O_shldBranch <= 0;
                    end
				
				SHR : begin
                    int_result <= I_dataA >> (I_dataB[3:0]);
					O_shldBranch <= 0;
                    end
				
				JMPA : begin
				    int_result <= (op_lsb ? I_dataA : I_imm);
					O_shldBranch <= 1;
				    end
				
				JMPR : begin
				    int_result <= I_dataA;
					O_shldBranch <= I_dataB[{op_lsb , I_imm[1:0]}];
				    end
			endcase	
		    end
	end
endmodule
