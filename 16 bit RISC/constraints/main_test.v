 // Timescale
`timescale 1ns / 1ps

// Module Definition
module main_test();
    // variable declaration
	//Regs
	reg clk;
	reg reset;
	reg reg_we = 0;
	reg [15:0] dataI = 0;
	//wire
	wire [2:0] selA;
	wire [2:0] selB;
	wire [2:0] selD;
	wire [15:0] dataA;
    wire [15:0] dataB;
    wire [15:0] dataD;
    wire [4:0] aluop;
	wire [7:0] imm;
	wire [15:0] dataO;
	wire [1:0] opcode;
    wire [15:0] pcO;

	wire shldBranch;
	wire enfetch;
	wire enalu;
	wire endec;
	wire enmem;
	wire enrgrd;
	wire enrgwr;
	wire regwe;
	wire update;
	
	//Assignments;
	assign enrgwr = regwe & update;
	assign opcode = (reset) ? 2'b11 : ((shldBranch) ? 2'b10 : ((enmem) ? 2'b01 : 2'b00));
	
	//instatiation
reg_file main_reg(
    // Inputs
	clk,
	enrgrd,
	enrgwr,
	selA,
	selB,
	selD,
	dataD,
	// Outputs
	dataA,
	dataB
);

inst_dec main_inst(
     // Inputs
	 clk,
	 endec,
	 dataO,
	 // outputs
	 aluop,
	 selA,
	 selB,
	 selD,
	 imm,
	 regwe
);

alu main_alu(
    // Inputs
	clk,
	enalu,
	aluop,
	dataA,
	dataB,
	imm,
	// Outputs
	dataD,
	shldBranch
);
	
ctrl_unit main_ctrl(
     // Inputs
	 clk,
	 reset,
	 // Outputs
	 enfetch,
	 endec,
	 enrgrd,
	 enalu,
	 update,
	 enmem
);

pc_unit pc_main(
    // Inputs
	clk,
	opcode,
	dataD,
	// Outputs
	pcO
);

fake_ram main_ram (
     // Inputs
	 clk,
	 reg_we,
	 pcO,
	 dataI,
    // Outputs
	dataO
);
	
    initial begin
	
         clk = 0;
        reset = 1;
        #20
        reset = 0;
		
	end 
	
	//Clock generation
	always begin
	   #5;
	   clk = ~clk;
	end
	 
	
endmodule
	
	
	
    
	
