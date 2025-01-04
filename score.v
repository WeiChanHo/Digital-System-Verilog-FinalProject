module score (
    input wire rst,
    input wire inGame,
    input wire hit,
    input wire CLOCK_50,
	  input wire clk_1hz,
    output wire [7:0] row, // Dot matrix row for tens digit
    output wire [7:0] tens_col, // Dot matrix column for tens digit
    output wire [7:0] units_col  // Dot matrix column for units digit
);

  // Registers to hold the score and digits
  reg [6:0] score;
  reg [3:0] tens_digit, units_digit;
  reg clk_div;
  reg [25:0] count;
  // Increment score on hit
  reg [4:0] counter;
  reg stop;

initial begin
    counter=30;
    stop=1;
   
end

always@(posedge clk_1hz or negedge rst) begin
    if(!rst) begin
        counter <= 30;
       
        stop <= 0;
    end

    else begin
        if(inGame && !stop) begin
            counter <= counter - 1;
            if(counter == 0) begin
                
                stop <= 1;
            end
            
        end

        else begin
            counter <= 30;
  
        end
    end
end


	 reg increment_prev;
    always @(posedge CLOCK_50 or negedge rst) begin
        if (!rst) begin
            score <= 0;
            increment_prev <= 0;
        end else if(inGame &&!stop) begin
            increment_prev <= hit;
            if (hit && !increment_prev) begin  // Rising edge detection
                if (score == 99)
                    score <= 0;
                else
                   score <=score + 1;
            end
        end
    end
    
    // Convert counter to BCD
    always @(*) begin
        tens_digit = score / 10;
        units_digit = score % 10;
    end
//    always @(posedge hit or posedge rst) begin
//        if (rst) begin
//            score <= 7'b0;
//        end else if (inGame) begin
//            score <= score + 1'b1;
//        end
//    end

    // Split score into tens and units digits
//    always @(*) begin
//        if (rst) begin
//            tens_digit <= 4'b0;
//            units_digit <= 4'b0;
//        end else begin
//            tens_digit <= score / 10;
//            units_digit <= score % 10;
//        end
//    end
always @(posedge CLOCK_50 or negedge rst) begin
        if (!rst) begin
            count <= 26'b0;
            clk_div <= 0;
        end else if (count == 26'd2500) begin
            count <= 26'b0;
            clk_div <= ~clk_div;  // Toggle output clock
        end else begin
            count <= count + 1;
        end
    end

    // Instantiate DotMatrix module for tens digit
    DotMatrix numbers_display (
			.clk(clk_div),
			.rst(inGame),
			.score1(units_digit),
			.score2(tens_digit),
			.dot_col1(units_col),
			.dot_col2(tens_col),
			.dot_row(row)
    );


endmodule
