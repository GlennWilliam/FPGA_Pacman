module pacMan_display (
	input logic clk,
					reset,
					m_up, m_down, m_right, m_left, e_start, m_hold,
	input logic [9:0] x, xPacLoc,
	input logic [8:0] y, yPacLoc,
	
	output logic [7:0]r, g,	b);
							
	always_comb
		begin
			if (x == xPacLoc + 1 && y >= yPacLoc - 1 && y <= yPacLoc + 1|| x == xPacLoc && y >= yPacLoc - 1 && y <= yPacLoc + 1 
			|| x == xPacLoc - 1 && y >= yPacLoc - 1 && y <= yPacLoc + 1)begin
				r = 255;			
				g = 255;
				b = 255;
				end
			else begin
				r = 0;			
				g = 0;
				b = 0;
				end
		end

		
endmodule // pacMan_display