// holds user input until next user input
// also decides start direction 
module user_direction_hold( 
			input logic clk, reset,
							upIn, downIn, leftIn, rightIn, startIn,
			output logic upOut, downOut, leftOut, rightOut);
	
	
	logic up, down, left, right;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			up <= 0;
			down <= 0;
			left <= 0;
			right <= 0;
			end
		else if (startIn) begin
			up <= 0;
			down <= 0;
			left <= 1;
			right <= 0;
			end
		else if (upIn) begin
			up <= 1;
			down <= 0;
			left <= 0;
			right <= 0;
			end
		else if (downIn) begin
			up <= 0;
			down <= 1;
			left <= 0;
			right <= 0;
			end
		else if (leftIn) begin
			up <= 0;
			down <= 0;
			left <= 1;
			right <= 0;
			end
		else if (rightIn) begin
			up <= 0;
			down <= 0;
			left <= 0;
			right <= 1;
			end
			
	end
	
	// Output logic
	assign upOut = up;
	assign downOut = down;
	assign leftOut = left; 
	assign rightOut = right; 
	

endmodule
