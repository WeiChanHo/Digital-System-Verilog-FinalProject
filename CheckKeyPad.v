module CheckKeyPad(clk_div, reset, keypadCol, keypadRow, keypadBuf);
// 記得要額外用一個position reg去記錄打擊位置，不要直接吃keypadBuf比較好
input clk_div, reset;
input [3:0]keypadCol;

// we output "keypadBuf" to game logic unit to detect hit a mole or not
output reg [3:0]keypadRow, keypadBuf;

reg [3:0]keypadDelay;

parameter TimeExpire_KEY = 4'd2; // 20 ms

always@(posedge clk_div or negedge reset) begin
    if(!reset) begin
        keypadRow <= 4'b1110;
        // reset will lock buf the value 0 and we don't use position as a whack-a-mole position
        keypadBuf <= 4'b0000;
        keypadDelay <= 4'd0;
    end

    else begin
        if(keypadDelay == TimeExpire_KEY) begin
            keypadDelay <= 4'd0;
            
            // current button pressed
            case({keypadRow, keypadCol})
                8'b1110_1110: keypadBuf <= 4'h7;
                8'b1110_1101: keypadBuf <= 4'h4;
                8'b1110_1011: keypadBuf <= 4'h1;
                8'b1110_0111: keypadBuf <= 4'h0;

                8'b1101_1110: keypadBuf <= 4'h8;
                8'b1101_1101: keypadBuf <= 4'h5;
                8'b1101_1011: keypadBuf <= 4'h2;
                8'b1101_0111: keypadBuf <= 4'ha;

                8'b1011_1110: keypadBuf <= 4'h9;
                8'b1011_1101: keypadBuf <= 4'h6;
                8'b1011_1011: keypadBuf <= 4'h3;
                8'b1011_0111: keypadBuf <= 4'hb;

                8'b0111_1110: keypadBuf <= 4'hc;
                8'b0111_1101: keypadBuf <= 4'hd;
                8'b0111_1011: keypadBuf <= 4'he;
                8'b0111_0111: keypadBuf <= 4'hf;

                default: keypadBuf <= keypadBuf;
                // 1~9 represent positions, 10~16 and 0 don't use
            endcase

            // next row
            case(keypadRow)
                4'b1110: keypadRow <= 4'b1101;
                4'b1101: keypadRow <= 4'b1011;
                4'b1011: keypadRow <= 4'b0111;
                4'b0111: keypadRow <= 4'b1110;

                default: keypadRow <= 4'b1110;
            endcase
        end

        else begin
            keypadDelay <= keypadDelay + 1'b1;
        end
    end
end

endmodule