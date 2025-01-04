module random (rst, clk_1hz, position);

input rst, clk_1hz;
output reg [3:0] position;

reg [7:0] seed;
reg [3:0] op1, op2;
reg operator;

initial begin
    op1 = 1;
    op2 = 1;
    operator = 1;
end

always@(posedge clk_1hz, negedge rst) begin
    if(!rst) begin
        seed <= 8'hA5;
    end
    else begin
        seed <= seed * 8'h41 + 8'h37;
    end
end

always@(posedge clk_1hz, negedge rst) begin
    if(!rst) begin
        op1 <= 1;
        op2 <= 1;
        operator <= 1;
        position <= 4'd1;
    end

    else begin
        op1 <= seed[3:0]%9 + 1;
        op2 <= seed[7:4]%9 + 1;
        operator <= seed[0];

        if(operator) begin
            position <= (op1 + op2)%9+1;
        end
        else begin
            position <= ((op1>op2)?(op1-op2):(op2-op1))%9+1;
        end
    end
end
endmodule //random