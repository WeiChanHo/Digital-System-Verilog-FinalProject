module FD#(
	parameter TIME_EXPIRE = 32'd25000000
	// TIME_EXPIRE = T_out/(T_in*2)
	// default 1Hz
)(
	input clk_50Mhz, reset,
	output reg clock_div
);

reg [31:0]count;

always@(posedge clk_50Mhz or negedge reset) begin
	
	// reset
	if(!reset) begin
		count <= 32'd0;
		clock_div <= 1'b0;
	end
	
	// not reset
	else begin
		if(count == TIME_EXPIRE) begin
			count <= 32'd0;
			clock_div <= ~clock_div;
		end
		else begin
			count <= count + 32'd1;
		end
	end
end

endmodule