`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:27 09/11/2012 
// Design Name: 
// Module Name:    dff_sync 
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
module dff_sync(
	input  wire clk,
	input  wire reset_b,
	input  wire sig,
	output reg  sync_sig);

	reg r1;

	always@(posedge clk or negedge reset_b)
		if (~reset_b) begin
			sync_sig <= 1'b0;
			r1       <= 1'b0;
		end
		else begin
			r1       <= sig;
			sync_sig <= r1;
		end
			


endmodule
