module ghost_display #(parameter RED = 255, parameter GRN = 0,parameter BLUE = 0)(
	input logic clk,
					reset,
					m_up, m_down, m_right, m_left, e_start, m_hold,
	input logic [9:0] x, xGhost,
	input logic [8:0] y, yGhost,
	
	output logic [7:0]r, g,	b);
							
	always_comb
		begin
			if (x == xGhost + 1 && y >= yGhost - 1 && y <= yGhost + 1|| x == xGhost && y >= yGhost - 1 && y <= yGhost + 1 
			|| x == xGhost - 1 && y >= yGhost - 1 && y <= yGhost + 1)begin
				r = RED;			
				g = GRN;
				b = BLUE;
				end
			else begin
				r = 0;			
				g = 0;
				b = 0;
				end
		end

		
endmodule // ghost_display