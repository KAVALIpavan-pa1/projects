//Timescale
`timescale 1ns / 1ps

//Module Definition
module regfile_unittest();
	//Variable Declaration
	//Regs
	reg I_clk;
	reg [15:0] I_dataD;
	reg I_en;
	reg [2:0] I_selA;
	reg [2:0] I_selB;
	reg [2:0] I_selD;
	reg I_we;
	//Wires
	wire O_dataA;
	wire O_dataB;
	
reg_file reg_test(
	//Inputs
	I_clk,
	I_en,
	I_we,
	I_selA,
	I_selB,
	I_selD,
	I_dataD,
	//Outputs
	O_dataA,
	O_dataB
);

	initial begin
		//Reset all Inputs
		I_clk = 1'b0;
		I_dataD = 0;
		I_en = 0;
		I_selA = 0;
		I_selB = 0;
		I_selD = 0;
		I_we = 0;
		
		//Start Test
		//Time = 7
		#7
		I_en = 1'b1;
		
		I_selA = 3'b000;
		I_selB = 3'b001;
		I_selD = 3'b000;
		
		I_dataD = 16'hFFFF;
		I_we = 1'b1;
		
		//Time = 17
		I_we = 1'b0;
		I_selD = 3'b010;
		I_dataD = 16'h2222;
		
		//Time = 27
		#10;
		I_we = 1;
		
		//Time = 37
		#10;
		I_dataD = 16'h3333;
		
		//Time = 47
		#10;
		I_we = 0;
		I_selD = 3'b000;
		I_dataD = 16'hFEED;
		
		//Time = 57
		#10;
		I_selD = 3'b100;
		I_dataD = 16'h4444;
		
		//Time = 67
		#10;
		I_we = 1;
		
		//Time = 117
		#50;
		I_selA = 3'b100;
		I_selB = 3'b100;
		#20;
		$finish;
		
	end

	//Clock generation
	always begin
		#5;
		I_clk = ~I_clk;
	end

endmodule
