module timer(inGame, rst, clk_1hz, sec1, sec2, counter);

input inGame, rst, clk_1hz;
output reg [3:0] sec1, sec2;
output reg [4:0] counter;
reg stop;

initial begin
    counter=30;
    stop=1;
    sec1=3;
    sec2=0;
end

always@(posedge clk_1hz or negedge rst) begin
    if(!rst) begin
        counter <= 30;
        sec1 <= 4'd3;
        sec2 <= 4'd0;
        stop <= 0;
    end

    else begin
        if(inGame && !stop) begin
            counter <= counter - 1;
            if(counter == 0) begin
                sec1 <= 3;
                sec2 <= 0;
                stop <= 1;
            end
            else begin
                sec1 <= counter/10;
                sec2 <= counter%10;
            end
        end

        else begin
            counter <= 30;
            sec1 <= 3;
            sec2 <= 0;
        end
    end
end

endmodule