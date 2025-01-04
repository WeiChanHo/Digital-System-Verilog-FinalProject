`timescale 1ns / 1ps

module top(rst, inGame, clk, seg1, seg2, seg3, o_hsync, o_vsync, o_red, o_green, o_blue, keypadCol, keypadRow,row,tens_col,units_col);

input rst, inGame, clk;
input [3:0] keypadCol;
output [3:0] keypadRow;

output [6:0] seg1, seg2, seg3;//seg3用來debug地鼠的位置，之後可以拔掉

output o_hsync, o_vsync;
output [3:0] o_red, o_green, o_blue;

output wire [7:0] row; // Dot matrix row for tens digit
output wire [7:0] tens_col; // Dot matrix column for tens digit
output wire [7:0] units_col;  // Dot matrix column for units digit

wire clk_1hz, clk_1khz, clk_div;
wire [3:0] sec1, sec2;
wire [3:0] position, counter;
wire [3:0] keypadBuf;


// timer
FD fd_1hz(.clk_50Mhz(clk), .reset(rst), .clock_div(clk_1hz));
timer u_timer(
    .inGame(inGame), 
    .rst(rst), 
    .clk_1hz(clk_1hz), 
    .sec1(sec1), 
    .sec2(sec2), 
    .counter(counter)
);
SevenDisplay u_s1(.count(sec1), .out(seg1));
SevenDisplay u_s2(.count(sec2), .out(seg2));

// generate position
FD#(.TIME_EXPIRE(12500000)) fd_rnd(.clk_50Mhz(clk), .reset(rst), .clock_div(clk_div));
random u_rand(
    .rst(rst), 
    .clk_1hz(clk_div), 
    .position(position)
);

FD#(.TIME_EXPIRE(25000)) fd_1khz(.clk_50Mhz(clk), .reset(rst), .clock_div(clk_1khz));
CheckKeyPad u_keypad(
    .clk_div(clk_1khz), 
    .reset(rst), 
    .keypadCol(keypadCol), 
    .keypadRow(keypadRow), 
    .keypadBuf(keypadBuf)
);
SevenDisplay u_s3(.count(keypadBuf), .out(seg3));


// TODO: hit will remain previous value
assign hit = (keypadBuf == position);

vga_driver VGA_disp(
	.rst(rst),
	.clk(clk),           // 50 MHz
	.inGame(inGame),
	.hit(hit),
	.position(position),
	.o_hsync(o_hsync),      // horizontal sync
	.o_vsync(o_vsync),	     // vertical sync
	.o_red(o_red),
	.o_blue(o_blue),
	.o_green(o_green)  
);

score Score(
  .rst(rst),
  .CLOCK_50(clk),
  .clk_1hz(clk_1hz),
  .inGame(inGame),
  .hit(hit),
  .row(row),
  .tens_col(tens_col),
  .units_col(units_col)
);



endmodule

