module GameLogic(rst, keypadBuf, position, hit);

input rst;
input [3:0] position; // restricted in 1~9
input [3:0] keypadBuf;

output hit;

assign hit = (keypadBuf == position) && !rst;

endmodule //GameLogic