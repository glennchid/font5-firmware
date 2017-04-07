integer i, j;

initial begin
	for (i=0; i < N_CTRL_REGS; i=i+1) ctrl_regs[i] = 0;
	for (j=0; j < N_CTRL_REGS; j=j+1) ctrl_regs_mem[j] = 0;
	`ifdef XILINX_ISIM
		//ctrl_regs[39]=7'b1011110; // {6'd47,1'b0}
		ctrl_regs[37]=7'sd8; // new K1 loop 1 gain
		ctrl_regs[39]=7'd94; // if use_strobes enabled must multiply by 2 -- max decimal = 127
		ctrl_regs[40]=7'b0110000;
		ctrl_regs[41]=7'b0010100;
		
		ctrl_regs[43] = 7'd1;        	// FF-on
		ctrl_regs[44] = 7'd0;			// Const DAC on
		ctrl_regs[45] = 7'sd8;		// new K2 loop 1 gain
		ctrl_regs[46] = 7'd0;//7'b0010000; 	// K1 const DAC = +4095
		ctrl_regs[47] = 7'd0;
		ctrl_regs[48] = 7'd64;
		ctrl_regs[49] = 7'd32;			// K1 gain
		ctrl_regs[50] = 7'd32;			// K2 gain
		//ctrl_regs[51] = 7'd0;
		ctrl_regs[51] = 7'b0000000; // 7'b0001100	// ch1 and ch2 IIR filters on
		ctrl_regs[52] = 7'b0000000; // 7'b0110000
		ctrl_regs[111]=3'd7;				// Trigger threshold code
		ctrl_regs[119] = 7'b0010100; // top seven bits of ten-bit decimal "164" - # samples
		ctrl_regs[120] = 7'b1001111; // [bottom three bits of above,  top four bits of channel select (ones hot)]
		ctrl_regs[121] = 7'b1111110; // [bottom five bits of channel select (ones hot), top two bits of eight-bit decimal "164"
		ctrl_regs[122] = 7'b1001000; // [bottom six bits of above, trigSync_ext (ie. ring clock) enable]
		ctrl_regs[123] = 7'd1; 			// Run mode
		ctrl_regs[124] = 7'b0000100; // oflowMode= saturate

		
		ctrl_regs_mem[39]=7'b1011001; //{start proc[6:0], use strobes}  = 44, 1
		ctrl_regs_mem[40]=7'b0110000;
		ctrl_regs_mem[41]=7'b0010100;
		ctrl_regs_mem[43] = 7'd1;        	// FF-on
		ctrl_regs_mem[49] = 7'd32;			// K1 gain
		ctrl_regs_mem[50] = 7'd32;			// K2 gain
		//ctrl_regs_mem[51] = 7'd2;
		ctrl_regs_mem[111]=3'd7;
		ctrl_regs_mem[119] = 7'b0010100; // top seven bits of ten-bit decimal "164"
		ctrl_regs_mem[120] = 7'b1001111; // [bottom three bits of above,  top four bits of channel select (ones hot)]
		ctrl_regs_mem[121] = 7'b1111110; // [bottom five bits of channel select (ones hot), top two bits of eight-bit decimal "164"
		ctrl_regs_mem[122] = 7'b1001000; // [bottom six bits of above, trigSync_ext (ie. ring clock) enable]
		ctrl_regs_mem[123] = 7'd1; 			// Run mode
		ctrl_regs_mem[124] = 7'b0000100; // oflowMode= saturate

	`else
		ctrl_regs[51] = 7'b1111100;
		ctrl_regs[52] = 7'b0001111;
		//ctrl_regs[96] = 7'd96; // Baud_rate 460.8 kbps
		ctrl_regs[96] = 7'd40; //WAS 32// Baud 112.8; sync_en =1
		ctrl_regs[97] = 7'd56; // 3 high in 4
		ctrl_regs[110] = 7'd0; ///DigInA threshold
		ctrl_regs[111] = 7'd7; ///DigInB threshold		
		ctrl_regs[119] = 7'b0111110; // top seven bits of ten-bit decimal "164" // "500"
		ctrl_regs[120] = 7'b1001111; // [bottom three bits of above,  top four bits of channel select (ones hot)]
		ctrl_regs[121] = 7'b1111100; // [bottom five bits of channel select (ones hot), top two bits of eight-bit decimal "164"
		ctrl_regs[122] = 7'b0000000; // [bottom six bits of above, trigSync_ext (ie. ring clock) enable]
		ctrl_regs[123] = 7'd0; 			// Run mode
		ctrl_regs[124] = 7'd5;			// 7'b0001101;
		
		ctrl_regs_mem[51] = 7'b1111100;
		ctrl_regs_mem[52] = 7'b0001111;
		//ctrl_regs_mem[96] = 7'd0; // Baud_rate 460.8 kbps
		ctrl_regs_mem[96] = 7'd40; //WAS 32// Baud 112.8; sync_en =1
		ctrl_regs_mem[97] = 7'd56; // 3 high in 4

		ctrl_regs_mem[110]=3'd0; ///DigInA threshold
		ctrl_regs_mem[111]=3'd7; ///DigInB threshold		
		ctrl_regs_mem[119] = 7'b0111110; // top seven bits of ten-bit decimal "164"
		ctrl_regs_mem[120] = 7'b1001111; // [bottom three bits of above,  top four bits of channel select (ones hot)]
		ctrl_regs_mem[121] = 7'b1111100; // [bottom five bits of channel select (ones hot), top two bits of eight-bit decimal "164"
		ctrl_regs_mem[122] = 7'b0000000; // [bottom six bits of above, trigSync_ext (ie. ring clock) enable]
		ctrl_regs_mem[123] = 7'd0; 			// Run mode
		ctrl_regs_mem[124] = 7'd5; // 7'b0001101;
	`endif
	end
	