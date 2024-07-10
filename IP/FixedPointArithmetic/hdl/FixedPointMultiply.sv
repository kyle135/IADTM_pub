//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
module FixedPointMultiply
#(  //------------------------------//-----------------------------------------
    // Parameters                   // Description(s)
    //------------------------------//-----------------------------------------
    parameter integer N = 32        //
)  (//------------------------------//-----------------------------------------
    //                              //
    //------------------------------//-----------------------------------------
    input  wire [ N-1:0] a,         //
    input  wire [ N-1:0] b,         //
    //------------------------------//-----------------------------------------
    //                              // Description(s)
    //------------------------------//-----------------------------------------
    output wire [2*N-1:0] c         //
);


    assign c = a * b;

endmodule : FixedPointMultiply
    
//module alu_mul
//	#(parameter WORD_WIDTH = 32)
//    (input  wire [     WORD_WIDTH  - 1:0] a,
//	  input  wire [     WORD_WIDTH  - 1:0] b,
//	  output wire [(2 * WORD_WIDTH) - 1:0] mul);
//
//`ifdef BOOTH
//	reg [WORD_WIDTH - 1:0] M = a;
//	reg [WORD_WIDTH - 1:0] M_b;
//	reg [2 * WORD_WIDTH - 1:0] P = 0;
//	reg [2 * WORD_WIDTH - 1:0] A = 0;
//	reg [2 * WORD_WIDTH - 1:0] S = 0;
//	
//	// Get the two's complement of the multiplicand into M_b
//	alu_add complement (
//		.a(~M),
//		.b(1),
//		.cout(),
//		.sum(M_b));
//	
//	A = {  M, (WORD_WIDTH)'b0}; // A is an extended multiplicand
//	S = {M_b, (WORD_WIDTH)'b0}; // S is an extended two's complement of the multiplicand
//	P = {(WORD_WIDTH - 1)'b0, b}; // P is the product register that we will be repetitively adding to
//	
//	repeat (WORD_WIDTH) begin
//		case({P[WORD_WIDTH], P[WORD_WIDTH - 1]})
//			00: // do nothing
//			01: begin //add multiplicand to product reg
//				alu_add
//					add (
//						.a(A),
//						.b(P),
//						.cout(),
//						.sum(P));
//			end
//			10: begin // subtract multiplicand from product reg
//				alu_add
//					subtract (
//						.a(S),
//						.b(P),
//						.cout(),
//						.sum(P));
//			end
//			11: // do nothing
//		endcase
//		P  = P >> 1;
//	end
//	
//	mul = P[(2 * WORD_WIDTH) - 1:1]; // The output is the P register minus the least significant digit
//
//`elsif WALLACE
//
//
//`else
//	assign mul = a * b;
//`endif	
//
//endmodule
//
//module booth_mul(
//	input wire [31:0] a,
//	input wire [31:0] b,
//	output wire [63:0] mul);
//	
//	/*wire [31:0] A, M, Q;
//	wire Q_1;
//	wire [1:0] path_select;
//	
//	assign Q_1 = 1'b0;
//	assign A = 32'b0;
//	assign M = a;
//	assign Q = b;
//	
//	//genvar i;
//	
//	//generate
//	//for (i=0; i<32; i=i+1) begin: booth_loop
//		assign path_select[1] = (Q[0] > Q_1); //2'b10
//		assign path_select[0] = (Q[0] < Q_1); //2'b01
//		
//		assign A = path_select[1] ? (A-M) : A;
//	   assign A = path_select[0] ? (A+M) : A;
//		
//		 assign A = A >>> 1;
//		 //assign {Q, Q_1} = {Q,Q_1} >>> 1;
//			
//	//end
//	//endgenerate
//	
//	assign mul = {A, Q};*/
//	
//	
//		//output [15:0] prod;
//	//output busy;
//	//input [7:0] mc, mp;
//	//input clk, start;
//	reg [31:0] A, Q, M;
//	reg Q_1;
//	reg [7:0] count;
//
//	wire [31:0] sum, difference;
//	wire cout;
//	
//	initial begin
//		A = 32'b0;      
//			M = a;
//			Q = b;
//			Q_1 = 1'b0;      
//			count = 32'b0;
//		end
//	
//	always @(*)
//	begin
//		if (count != 32) begin
//			//A = 32'b0;      
//			//M = a;
//			//Q = b;
//			//Q_1 = 1'b0;      
//			//count = 32'b0;
//		//end
//		//else begin
//			case ({Q[0], Q_1})
//				2'b0_1 : {A, Q, Q_1} = {sum[31], sum, Q};
//				2'b1_0 : {A, Q, Q_1} = {difference[31], difference, Q};
//				default: {A, Q, Q_1} = {A[31], A, Q};
//			endcase
//			count = count + 1'b1;
//			
//		end
//	end
//
//	//alu adder (sum, A, M, 1'b0);
//	csa_32 adder(A, M, 1'b0, sum, cout);
//	//alu subtracter (difference, A, ~M, 1'b1);
//	//difference = A - M;
//	csa_32 subtracter(A, ~M, 1'b1, difference, cout);
//
//	assign mul = {A, Q};
//	//assign busy = (count < 8);
//
//
//endmodule
//
//module booth #(parameter N=4) 
//(	
//input [N:0] m, q, 		//Multiplicand, Multiplier 
//output [N+N:0]product 		//
//);
//
//	reg boothbit=0; 
//	
//	//instatiate wires
//	wire [N:0]twoscompM, twoscompQ;
//	wire [N*2:0] pro;
//	
//	//assign to inputs and outputs 
//	assign product= {pro,twoscompM };
//	
//	//intialize modules
//	twos_comp u1 (.a(m), .b(twoscompM));
//	twos_comp u2 (.a(q), .b(twoscompQ));
//	
//	//magic 
//	
//	genvar i; 
//	generate 
//	for(i=N; i>=0;i=i-1 )begin: booth 
//	
//	case (twos_compQ[0])
//	
//	0:case (boothbit) 
//		1://A = A +M (where inputs are a, m and cin=0  )
//		csa add_1 (.Cin(1'b0), .A(product), .B(twosxompM), .Sum(product), .Cout());
//		
//		default:begin end  // do nothing 
//		endcase
//	1:case (boothbit)
//		0:// A = A - M ( where inputs are a, ~m and cin=1  )
//		csa sub_1 (.Cin(1'b1), .A(product), .B(~twosxompM), .Sum(product), .Cout());
//		default: begin//do nothing 
//		end 
//		endcase 
//endcase 
//	 //shift right
//	 pro= {pro[N*2-1:0],twoscompM[N]} >>1;
//	 twosComp = {twoscompM[N-1:0],boothbit}>>1;
//	end 
//endmodule
//
////twos comp needs to be tested
//module twos_comp #(parameter N=4) (input wire [N:0] a,
//								output wire [N:0] b
//	);
//	
//assign b = ~a + 1'b1;							
//								
//endmodule 
//
//								
//					
//
//module alu_mul
//	#(parameter WORD_WIDTH = 32)
//    (input  wire [     WORD_WIDTH  - 1:0] a,
//	  input  wire [     WORD_WIDTH  - 1:0] b,
//	  output wire [(2 * WORD_WIDTH) - 1:0] mul);
//
//`ifdef BOOTH
//	reg [WORD_WIDTH - 1:0] M = a;
//	reg [WORD_WIDTH - 1:0] M_b;
//	reg [2 * WORD_WIDTH - 1:0] P = 0;
//	reg [2 * WORD_WIDTH - 1:0] A = 0;
//	reg [2 * WORD_WIDTH - 1:0] S = 0;
//	
//	// Get the two's complement of the multiplicand into M_b
//	alu_add complement (
//		.a(~M),
//		.b(1),
//		.cout(),
//		.sum(M_b));
//	
//	A = {  M, (WORD_WIDTH)'b0}; // A is an extended multiplicand
//	S = {M_b, (WORD_WIDTH)'b0}; // S is an extended two's complement of the multiplicand
//	P = {(WORD_WIDTH - 1)'b0, b}; // P is the product register that we will be repetitively adding to
//	
//	repeat (WORD_WIDTH) begin
//		case({P[WORD_WIDTH], P[WORD_WIDTH - 1]})
//			00: // do nothing
//			01: begin //add multiplicand to product reg
//				alu_add
//					add (
//						.a(A),
//						.b(P),
//						.cout(),
//						.sum(P));
//			end
//			10: begin // subtract multiplicand from product reg
//				alu_add
//					subtract (
//						.a(S),
//						.b(P),
//						.cout(),
//						.sum(P));
//			end
//			11: // do nothing
//		endcase
//		P  = P >> 1;
//	end
//	
//	mul = P[(2 * WORD_WIDTH) - 1:1]; // The output is the P register minus the least significant digit
//
//`elsif WALLACE
//
//
//`else
//	assign mul = a * b;
//`endif	
//
//endmodule
//
//module alu_mult
//#(parameter WORD_WIDTH = 32)
//(input  wire                          clk_i,
//	output  wire                          stall_o,
//	input  wire [     WORD_WIDTH  - 1:0] a_i,
//	input  wire [     WORD_WIDTH  - 1:0] b_i,
//	output wire [(2 * WORD_WIDTH) - 1:0] mult_o);
//	
//	wire [63:0] mult_unsigned;
//	wire [31:0] a_new, b_new;
//	assign stall_o = 0;
//
//	`ifdef BOOTH
//
//
//	`elsif WALLACE
//
//
//	`elsif MACRO
//	multiplier i_mul (
//		.clk (clk),
//		.a   (a),
//		.b   (b),
//		.p   (mul));
//	`else
//	assign a_new = (a_i[31])? ((~a_i[30:0]) + 1'b1):a_i[30:0]; // compliment if negative
//	assign b_new = (b_i[31])? ((~b_i[30:0]) + 1'b1):b_i[30:0]; // compliment if negative
//	assign mult_unsigned[63:0] = a_new * b_new; // signed multiplication
//	assign mult_o = (a_i[31]^b_i[31]) ? ~mult_unsigned + 1: mult_unsigned;
//	`endif	
//
//endmodule
//
//
//module alu_multu
//	#(parameter WORD_WIDTH = 32)
//    (input  wire                          clk_i,
//     output wire                          stall_o,
//     input  wire [     WORD_WIDTH  - 1:0] a_i,
//	  input  wire [     WORD_WIDTH  - 1:0] b_i,
//	  output wire [(2 * WORD_WIDTH) - 1:0] multu_o);
//
//   assign stall_o = 0;
//
//`ifdef BOOTH
//
//
//
//`elsif WALLACE
//
//
//`elsif MACRO
//   multiplier i_mul (
//    .clk (clk),
//    .a   (a),
//    .b   (b),
//    .p   (mul));
//`else
//	assign multu_o = a_i* b_i;
//`endif	
//
//endmodule
