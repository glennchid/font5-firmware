`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:15 03/13/2014 
// Design Name: 
// Module Name:    AmpTrig 
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
module AmpTrig2(
    input clk,
    input trigger_in,
	 input trig_out_en_b,
	 input [6:0] trig_out_delay_b,
    output reg amp_trig = 1'b0
    );

parameter TRIG_BLK_SIZE = 5'd20;

reg trigger_a, trigger_b, trigd, trig_out_en, trig_out_en_a;//, trig_out_gate = 1'b0;
reg [6:0] trig_out_delay, trig_out_delay_a = 7'b0;
reg [6:0] trig_mstr_ctr = 7'd0;
reg [4:0] trig_blk_ctr = 5'd0;


always @(posedge clk) begin
	trigger_a <= trigger_in;
	trigger_b <= trigger_a;
	trig_out_en <= trig_out_en_a;
	trig_out_en_a <= trig_out_en_b;
	trig_out_delay <= trig_out_delay_a;
	trig_out_delay_a <= trig_out_delay_b;

	
	if (~trigd) begin
		trigd <= trigger_a & ~trigger_b; //leading edge detector on trigger_in
		amp_trig <= amp_trig;
	end else if (trig_mstr_ctr == trig_out_delay) begin
		amp_trig <= (trig_out_en && ~amp_trig) ? 1'b1 : amp_trig;
		//amp_trig <= (trig_out_en) ? 1 : 0;
		trigd <= trigd;
	end else if (amp_trig) begin
		amp_trig <= 1'b0;
		trigd <= 1'b0;
	end else begin
		amp_trig <= amp_trig;
		trigd <= trigd;
	end
	

		
	
	//trig_out_gate <= (trig_out_delay == 7'd0) ? 0 : trig_out_en;
	
	//amp_trig <= ((trig_mstr_ctr == trig_out_delay) && trig_out_gate) ? 1 : 0;
	
	if (trigger_b && (trig_blk_ctr==TRIG_BLK_SIZE)) begin
		trig_mstr_ctr <= trig_mstr_ctr + 1'b1;
		trig_blk_ctr <= 5'd0;
		end
	else if (trigger_b) begin
		trig_mstr_ctr <= trig_mstr_ctr;
		trig_blk_ctr <= trig_blk_ctr + 1'b1;
		end
	else begin
		trig_mstr_ctr <= 7'd0;
		trig_blk_ctr <= 5'd0;
		end
	end
endmodule
