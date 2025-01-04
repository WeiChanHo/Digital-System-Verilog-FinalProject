module DotMatrix(
	input clk,
	input rst,
	input [3:0] score1,
	input [3:0] score2,
	output reg [7:0] dot_col1,
	output reg [7:0] dot_col2,
	output reg [7:0] dot_row
);

reg [2:0] rowcnt;

always@(posedge clk, negedge rst)begin
	if(!rst)begin
		rowcnt <= 3'd0;
		dot_col1 <= 8'd0;
		dot_col2 = 8'd0;
		dot_row = 8'd0;
	end
	else begin
		rowcnt = rowcnt+1;
		case(rowcnt) 
			3'd0: dot_row <= 8'b01111111;
			3'd1: dot_row <= 8'b10111111;
			3'd2: dot_row <= 8'b11011111;
			3'd3: dot_row <= 8'b11101111;
			3'd4: dot_row <= 8'b11110111;
			3'd5: dot_row <= 8'b11111011;
			3'd6: dot_row <= 8'b11111101;
			3'd7: dot_row <= 8'b11111110;
      endcase
		
		case(score1)
			3'd0 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b00111000; //  ***
					3'd1: dot_col1 = 8'b01101100; // ** **
					3'd2: dot_col1 = 8'b11000110; //**   **
					3'd3: dot_col1 = 8'b11000110; //**   **
					3'd4: dot_col1 = 8'b11000110; //**   **
					3'd5: dot_col1 = 8'b11000110; //**   **
					3'd6: dot_col1 = 8'b01101100; // ** **
					3'd7: dot_col1 = 8'b00111000; //  ***
				 endcase
			end
			3'd1 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b00011000; //    **
					3'd1: dot_col1 = 8'b00111000; //   ***
					3'd2: dot_col1 = 8'b00011000; //    **
					3'd3: dot_col1 = 8'b00011000; //    **
					3'd4: dot_col1 = 8'b00011000; //    **
					3'd5: dot_col1 = 8'b00011000; //    **
					3'd6: dot_col1 = 8'b00011000; //    **
					3'd7: dot_col1 = 8'b00111100; //   ****
				endcase
			end
			3'd2 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b01111100; //  *****
					3'd1: dot_col1 = 8'b11000110; // **   **
					3'd2: dot_col1 = 8'b00000110; //      **
					3'd3: dot_col1 = 8'b00001100; //     **
					3'd4: dot_col1 = 8'b00111000; //   ***
					3'd5: dot_col1 = 8'b01100000; //  **
					3'd6: dot_col1 = 8'b11000000; // **
					3'd7: dot_col1 = 8'b11111110; // *******
					endcase
				end
			3'd3 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b01111100; //  *****
					3'd1: dot_col1 = 8'b11000110; // **   **
					3'd2: dot_col1 = 8'b00000110; //      **
					3'd3: dot_col1 = 8'b00011100; //    ***
					3'd4: dot_col1 = 8'b00000110; //      **
					3'd5: dot_col1 = 8'b11000110; // **   **
					3'd6: dot_col1 = 8'b11000110; // **   **
					3'd7: dot_col1 = 8'b01111100; //  *****
				endcase
			end
			3'd4 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b00001100; //     **
					3'd1: dot_col1 = 8'b00011100; //    ***
					3'd2: dot_col1 = 8'b00110100; //   ** *
					3'd3: dot_col1 = 8'b01100100; //  **  *
					3'd4: dot_col1 = 8'b11000100; // **   *
					3'd5: dot_col1 = 8'b11111110; // *******
					3'd6: dot_col1 = 8'b00000100; //      *
					3'd7: dot_col1 = 8'b00000100; //      *
				endcase
			end
			3'd5 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b11111110; // *******
					3'd1: dot_col1 = 8'b11000000; // **
					3'd2: dot_col1 = 8'b11000000; // **
					3'd3: dot_col1 = 8'b11111100; // ******
					3'd4: dot_col1 = 8'b00000110; //      **
					3'd5: dot_col1 = 8'b00000110; //      **
					3'd6: dot_col1 = 8'b11000110; // **   **
					3'd7: dot_col1 = 8'b01111100; //  *****
				endcase
			end
			3'd6 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b00111100; //   ****
					3'd1: dot_col1 = 8'b01100000; //  **
					3'd2: dot_col1 = 8'b11000000; // **
					3'd3: dot_col1 = 8'b11111100; // ******
					3'd4: dot_col1 = 8'b11000110; // **   **
					3'd5: dot_col1 = 8'b11000110; // **   **
					3'd6: dot_col1 = 8'b11000110; // **   **
					3'd7: dot_col1 = 8'b01111100; //  *****
				endcase
			end
			3'd7 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b11111110; // *******
					3'd1: dot_col1 = 8'b11000110; // **   **
					3'd2: dot_col1 = 8'b00001100; //     **
					3'd3: dot_col1 = 8'b00001100; //     **
					3'd4: dot_col1 = 8'b00011000; //    **
					3'd5: dot_col1 = 8'b00011000; //    **
					3'd6: dot_col1 = 8'b00011000; //    **
					3'd7: dot_col1 = 8'b00011000; //    **
				endcase
			end
			4'd8 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b01111100; //  *****
					3'd1: dot_col1 = 8'b11000110; // **   **
					3'd2: dot_col1 = 8'b11000110; // **   **
					3'd3: dot_col1 = 8'b01111100; //  *****
					3'd4: dot_col1 = 8'b11000110; // **   **
					3'd5: dot_col1 = 8'b11000110; // **   **
					3'd6: dot_col1 = 8'b11000110; // **   **
					3'd7: dot_col1 = 8'b01111100; //  *****
				endcase
			end
			4'd9 : begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b01111100; //  *****
					3'd1: dot_col1 = 8'b11000110; // **   **
					3'd2: dot_col1 = 8'b11000110; // **   **
					3'd3: dot_col1 = 8'b01111110; //  ******
					3'd4: dot_col1 = 8'b00000110; //      **
					3'd5: dot_col1 = 8'b00000110; //      **
					3'd6: dot_col1 = 8'b00001100; //     **
					3'd7: dot_col1 = 8'b01111000; //  ****
				endcase
			end
			default:begin
				case(rowcnt)
					3'd0: dot_col1 = 8'b00000000; //
					3'd1: dot_col1 = 8'b00000000; //
					3'd2: dot_col1 = 8'b00000000; //
					3'd3: dot_col1 = 8'b00000000; //    
					3'd4: dot_col1 = 8'b00000000; //    
					3'd5: dot_col1 = 8'b00000000; //    
					3'd6: dot_col1 = 8'b00000000; //    
					3'd7: dot_col1 = 8'b00000000; //   
				endcase
			end
		endcase
		
		case(score2)
			3'd0 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b00111000; //  ***
					3'd1: dot_col2 = 8'b01101100; // ** **
					3'd2: dot_col2 = 8'b11000110; //**   **
					3'd3: dot_col2 = 8'b11000110; //**   **
					3'd4: dot_col2 = 8'b11000110; //**   **
					3'd5: dot_col2 = 8'b11000110; //**   **
					3'd6: dot_col2 = 8'b01101100; // ** **
					3'd7: dot_col2 = 8'b00111000; //  ***
				 endcase
			end
			3'd1 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b00011000; //    **
					3'd1: dot_col2 = 8'b00111000; //   ***
					3'd2: dot_col2 = 8'b00011000; //    **
					3'd3: dot_col2 = 8'b00011000; //    **
					3'd4: dot_col2 = 8'b00011000; //    **
					3'd5: dot_col2 = 8'b00011000; //    **
					3'd6: dot_col2 = 8'b00011000; //    **
					3'd7: dot_col2 = 8'b00111100; //   ****
				endcase
			end
			3'd2 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b01111100; //  *****
					3'd1: dot_col2 = 8'b11000110; // **   **
					3'd2: dot_col2 = 8'b00000110; //      **
					3'd3: dot_col2 = 8'b00001100; //     **
					3'd4: dot_col2 = 8'b00111000; //   ***
					3'd5: dot_col2 = 8'b01100000; //  **
					3'd6: dot_col2 = 8'b11000000; // **
					3'd7: dot_col2 = 8'b11111110; // *******
					endcase
				end
			3'd3 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b01111100; //  *****
					3'd1: dot_col2 = 8'b11000110; // **   **
					3'd2: dot_col2 = 8'b00000110; //      **
					3'd3: dot_col2 = 8'b00011100; //    ***
					3'd4: dot_col2 = 8'b00000110; //      **
					3'd5: dot_col2 = 8'b11000110; // **   **
					3'd6: dot_col2 = 8'b11000110; // **   **
					3'd7: dot_col2 = 8'b01111100; //  *****
				endcase
			end
			3'd4 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b00001100; //     **
					3'd1: dot_col2 = 8'b00011100; //    ***
					3'd2: dot_col2 = 8'b00110100; //   ** *
					3'd3: dot_col2 = 8'b01100100; //  **  *
					3'd4: dot_col2 = 8'b11000100; // **   *
					3'd5: dot_col2 = 8'b11111110; // *******
					3'd6: dot_col2 = 8'b00000100; //      *
					3'd7: dot_col2 = 8'b00000100; //      *
				endcase
			end
			3'd5 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b11111110; // *******
					3'd1: dot_col2 = 8'b11000000; // **
					3'd2: dot_col2 = 8'b11000000; // **
					3'd3: dot_col2 = 8'b11111100; // ******
					3'd4: dot_col2 = 8'b00000110; //      **
					3'd5: dot_col2 = 8'b00000110; //      **
					3'd6: dot_col2 = 8'b11000110; // **   **
					3'd7: dot_col2 = 8'b01111100; //  *****
				endcase
			end
			3'd6 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b00111100; //   ****
					3'd1: dot_col2 = 8'b01100000; //  **
					3'd2: dot_col2 = 8'b11000000; // **
					3'd3: dot_col2 = 8'b11111100; // ******
					3'd4: dot_col2 = 8'b11000110; // **   **
					3'd5: dot_col2 = 8'b11000110; // **   **
					3'd6: dot_col2 = 8'b11000110; // **   **
					3'd7: dot_col2 = 8'b01111100; //  *****
				endcase
			end
			3'd7 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b11111110; // *******
					3'd1: dot_col2 = 8'b11000110; // **   **
					3'd2: dot_col2 = 8'b00001100; //     **
					3'd3: dot_col2 = 8'b00001100; //     **
					3'd4: dot_col2 = 8'b00011000; //    **
					3'd5: dot_col2 = 8'b00011000; //    **
					3'd6: dot_col2 = 8'b00011000; //    **
					3'd7: dot_col2 = 8'b00011000; //    **
				endcase
			end
			4'd8 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b01111100; //  *****
					3'd1: dot_col2 = 8'b11000110; // **   **
					3'd2: dot_col2 = 8'b11000110; // **   **
					3'd3: dot_col2 = 8'b01111100; //  *****
					3'd4: dot_col2 = 8'b11000110; // **   **
					3'd5: dot_col2 = 8'b11000110; // **   **
					3'd6: dot_col2 = 8'b11000110; // **   **
					3'd7: dot_col2 = 8'b01111100; //  *****
				endcase
			end
			4'd9 : begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b01111100; //  *****
					3'd1: dot_col2 = 8'b11000110; // **   **
					3'd2: dot_col2 = 8'b11000110; // **   **
					3'd3: dot_col2 = 8'b01111110; //  ******
					3'd4: dot_col2 = 8'b00000110; //      **
					3'd5: dot_col2 = 8'b00000110; //      **
					3'd6: dot_col2 = 8'b00001100; //     **
					3'd7: dot_col2 = 8'b01111000; //  ****
				endcase
			end
			default:begin
				case(rowcnt)
					3'd0: dot_col2 = 8'b00000000; //
					3'd1: dot_col2 = 8'b00000000; //
					3'd2: dot_col2 = 8'b00000000; //
					3'd3: dot_col2 = 8'b00000000; //    
					3'd4: dot_col2 = 8'b00000000; //    
					3'd5: dot_col2 = 8'b00000000; //    
					3'd6: dot_col2 = 8'b00000000; //    
					3'd7: dot_col2 = 8'b00000000; //   
				endcase
			end
		endcase
	end
end
endmodule 