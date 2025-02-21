//Timescale
`timescale 1ns / 1ps

//Module Definition
module decoder_unittests();
	//Variable Declaration
	//Regs
	reg I_Clk;
	reg I_En;
	reg [15:0] I_Inst;
	//Wires
	wire [4:0] O_Aluop;
	wire [2:0] O_SelA;
	wire [2:0] O_SelB;
	wire [2:0] O_SelD;
	wire [15:0] O_Imm;
	wire O_Regwe;

inst_dec inst_unit(
    // Inputs
	 I_Clk,
	 I_En,
	 I_Inst,
	// Outputs
	O_Aluop,
    O_SelA,
    O_SelB,
    O_SelD,
    O_Imm,
	O_Regwe
);

	initial begin
	//Time = 0
		I_Clk <= 0;
		I_En  <= 0;
		I_Inst <= 0;
	//Time = 10
		#10;
		I_Inst = 16'b0001011100000100;
	//TIme = 20
		#10;
		I_En = 1;
	end
	
	always begin
		#5;
		I_Clk = ~I_Clk;
	end
endmodule
