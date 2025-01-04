`timescale 1ns / 1ps

// image generator of a road and a sky 640x480 @ 60 fps

////////////////////////////////////////////////////////////////////////
module vga_driver(
	input rst,
	input clk,           // 50 MHz
	input inGame,
	input hit,
	input [3:0] position,
	output o_hsync,      // horizontal sync
	output o_vsync,	     // vertical sync
	output [3:0] o_red,
	output [3:0] o_blue,
	output [3:0] o_green  
);

	reg [9:0] counter_x = 0;  // horizontal counter
	reg [9:0] counter_y = 0;  // vertical counter
	reg [3:0] r_red = 0;
	reg [3:0] r_blue = 0;
	reg [3:0] r_green = 0;

	reg stop;
	
	reg reset = 0;  // for PLL
	
	wire clk25MHz;

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// clk divider 50 MHz to 25 MHz
	// don't touch this divider!!!!!
	ip ip1(
		.areset(reset),
		.inclk0(clk),
		.c0(clk25MHz),
		.locked()
		);  
	// end clk divider 50 MHz to 25 MHz

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// counter and sync generation
	always @(posedge clk25MHz or negedge rst)  // horizontal counter
		begin 
			if(!rst) begin
				counter_x <= 0;
			end

			else begin
				if (counter_x < 799)
					counter_x <= counter_x + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
				else
					counter_x <= 0;
			end

			              
		end  // always 
	
	always @ (posedge clk25MHz or negedge rst)  // vertical counter
	begin 
		if(!rst) begin
			counter_y <= 0;
		end

		else begin
			if (counter_x == 799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (counter_y < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						counter_y <= counter_y + 1;
					else
						counter_y <= 0;              
				end  // if (counter_x...
			else begin
				counter_y <= counter_y;
			end
		end
	end  // always
	// end counter and sync generation  

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// hsync and vsync output assignments
	assign o_hsync = (counter_x >= 0 && counter_x < 96) ? 1:0;  // hsync high for 96 counts                                                 
	assign o_vsync = (counter_y >= 0 && counter_y < 2) ? 1:0;   // vsync high for 2 counts
	// end hsync and vsync output assignments

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// pattern generate
	always @ (posedge clk25MHz or negedge rst)
	begin
		if(!rst) begin
			r_red <= 4'hf;
			r_green <= 4'hf;
			r_blue <= 4'hf;
		end
		else begin
			if(inGame && !stop) begin
			// draw pattern here!!!
				if(counter_y > 35 && counter_y <= 80) begin
					r_red <= 4'h0;
					r_green <= 4'h0;
					r_blue <= 4'h0;
				end
				// squares
				else if((counter_y > 80 && counter_y <= 200) || (counter_y > 205 && counter_y <= 325) || (counter_y > 330 && counter_y <= 450)) 
				begin
					if((counter_x >= 144 && counter_x <= 279))
					begin
						r_red <= 4'h0;
						r_green <= 4'h0;
						r_blue <= 4'h0;
					end
					else if((counter_x > 279 && counter_x <= 399) || (counter_x > 404 && counter_x <= 524) || (counter_x > 529 && counter_x <= 649)) 
					begin
						case (position)
							1: begin
								if(counter_x > 309 && counter_x <= 369 && counter_y > 360 && counter_y <= 420 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 309 && counter_x <= 369 && counter_y > 360 && counter_y <= 420 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end
							2: begin
								if(counter_x > 309 && counter_x <= 369 && counter_y > 235 && counter_y <= 295 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 309 && counter_x <= 369 && counter_y > 235 && counter_y <= 295 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end 
							3: begin
								if(counter_x > 309 && counter_x <= 369 && counter_y > 110 && counter_y <= 170 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 309 && counter_x <= 369 && counter_y > 110 && counter_y <= 170 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end 
							4: begin
								if(counter_x > 434 && counter_x <= 494 && counter_y > 360 && counter_y <= 420 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 434 && counter_x <= 494 && counter_y > 360 && counter_y <= 420 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end 
							5: begin
								if(counter_x > 434 && counter_x <= 494 && counter_y > 235 && counter_y <= 295 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 434 && counter_x <= 494 && counter_y > 235 && counter_y <= 295 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end 
							6: begin
								if(counter_x > 434 && counter_x <= 494 && counter_y > 110 && counter_y <= 170 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 434 && counter_x <= 494 && counter_y > 110 && counter_y <= 170 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end 
							7: begin
								if(counter_x > 559 && counter_x <= 619 && counter_y > 360 && counter_y <= 420 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 559 && counter_x <= 619 && counter_y > 360 && counter_y <= 420 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end 
							8: begin
								if(counter_x > 559 && counter_x <= 619 && counter_y > 235 && counter_y <= 295 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 559 && counter_x <= 619 && counter_y > 235 && counter_y <= 295 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end 
							9: begin
								if(counter_x > 559 && counter_x <= 619 && counter_y > 110 && counter_y <= 170 && hit) begin
									r_red <= 4'hf;
									r_green <= 4'h0;
									r_blue <= 4'h0;
								end
								else if(counter_x > 559 && counter_x <= 619 && counter_y > 110 && counter_y <= 170 && !hit) begin
									r_red <= 4'h0;
									r_green <= 4'hf;
									r_blue <= 4'h0;
								end  
								else
								begin
									r_red <= 4'hf;
									r_green <= 4'hf;
									r_blue <= 4'hf;
								end
							end  
							default: // white square
							begin
								r_red <= 4'hf;
								r_green <= 4'hf;
								r_blue <= 4'hf;
							end 
						endcase
					end
					else if((counter_x > 399 && counter_x <= 404) || (counter_x > 524 && counter_x <= 529))
					begin
						r_red <= 4'h0;
						r_green <= 4'h0;
						r_blue <= 4'h0;
					end
					else 
					begin
						r_red <= 4'h0;
						r_green <= 4'h0;
						r_blue <= 4'h0;
					end			
				end
				// line
				else if((counter_y > 200 && counter_y <= 205) || (counter_y > 325 && counter_y <= 330)) 
				begin
					r_red <= 4'h0;
					r_green <= 4'h0;
					r_blue <= 4'h0;
				end
				//(counter_y > 450 && counter_y <= 514)
				else begin
					r_red <= 4'h0;
					r_green <= 4'h0;
					r_blue <= 4'h0;
				end
			end
			// basic pattern
			else begin
				if(counter_y > 35 && counter_y <= 80) begin
					r_red <= 4'h0;
					r_green <= 4'h0;
					r_blue <= 4'h0;
				end
				// squares
				else if((counter_y > 80 && counter_y <= 200) || (counter_y > 205 && counter_y <= 325) || (counter_y > 330 && counter_y <= 450)) 
				begin
					if((counter_x >= 144 && counter_x <= 279))
					begin
						r_red <= 4'h0;
						r_green <= 4'h0;
						r_blue <= 4'h0;
					end
					else if((counter_x > 279 && counter_x <= 399) || (counter_x > 404 && counter_x <= 524) || (counter_x > 529 && counter_x <= 649)) 
					begin
						r_red <= 4'hf;
						r_green <= 4'hf;
						r_blue <= 4'hf;
					end
					else if((counter_x > 399 && counter_x <= 404) || (counter_x > 524 && counter_x <= 529))
					begin
						r_red <= 4'h0;
						r_green <= 4'h0;
						r_blue <= 4'h0;
					end
					else 
					begin
						r_red <= 4'h0;
						r_green <= 4'h0;
						r_blue <= 4'h0;
					end			
				end
				// line
				else if((counter_y > 200 && counter_y <= 205) || (counter_y > 325 && counter_y <= 330)) 
				begin
					r_red <= 4'h0;
					r_green <= 4'h0;
					r_blue <= 4'h0;
				end
				//(counter_y > 450 && counter_y <= 514)
				else begin
					r_red <= 4'h0;
					r_green <= 4'h0;
					r_blue <= 4'h0;
				end
			end
		end
	end
	// end pattern generate

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// color output assignments
	// only output the colors if the counters are within the adressable video time constraints
	assign o_red = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_red : 4'h0;
	assign o_blue = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_blue : 4'h0;
	assign o_green = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_green : 4'h0;
	// end color output assignments
	
endmodule  // VGA_image_gen
