module ghost_datapath #(parameter WIDTH = 96, parameter HEIGHT = 72,
								parameter X_START = 46, parameter Y_START = 28) (
	input logic clk,
					reset,
					m_up, m_down, m_right, m_left, e_start, // valid moves from control

	output logic [9:0] xGhost,
	output logic [8:0] yGhost);
	

	logic [9:0] xLoc;
	logic [8:0] yLoc;
	
	
	always_ff @(posedge clk) begin
		if (reset || e_start) begin
			xLoc <= X_START;
			yLoc <= Y_START;
			end
			
		// limits of the board, allows pass through 
		else if (xLoc == (WIDTH + 1))
			xLoc <= 1;
			
		else if (xLoc == 0)
			xLoc <= (WIDTH);
			
		else if (yLoc == (HEIGHT + 1))
			yLoc <= 1;
			
		else if (yLoc == 0)
			yLoc <= (HEIGHT);
			
		// Location movment 
		if (m_up)
			yLoc <= yLoc - 1;
			
		if(m_down)
			yLoc <= yLoc + 1;
	
		if (m_right)
			xLoc <= xLoc + 1;
		
		if (m_left)
			xLoc <= xLoc - 1;
			
	end // always_ff
			
	
	//Otput logic
	assign xGhost = xLoc;
	assign yGhost = yLoc;
	

endmodule // ghost_datapath