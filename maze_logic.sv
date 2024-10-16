module maze_logic(
	input logic [9:0] xLoc,
	input logic [8:0] yLoc,
	output logic uE, dE, rE, lE); //enable signals

	always_comb begin
	
		uE = 0;
		dE = 0;
		rE = 0;
		lE = 0;
		
		// Horizontal top
		if (yLoc == 7 && xLoc >= 8 && xLoc <= 21 || yLoc == 7 && xLoc >= 23 && xLoc <= 72 ||
		yLoc == 7 && xLoc >= 74 && xLoc <= 87) begin
		    rE <= 1;
		    lE <= 1;
		end
		
		// Horizontal bottom
		else if (yLoc == 64 && xLoc >= 8 && xLoc <= 21 || yLoc == 64 && xLoc >= 23 && xLoc <= 72 ||
		yLoc == 64 && xLoc >= 74 && xLoc <= 87) begin
		    rE <= 1;
		    lE <= 1;
		end
		
		// Vertical left
		else if (xLoc == 7 && yLoc >= 8 && yLoc <= 12 || xLoc == 7 && yLoc >= 14 && yLoc <= 18 ||
		xLoc == 7 && yLoc >= 20 && yLoc <= 51 || xLoc == 7 && yLoc >= 53 && yLoc <= 57 ||
		xLoc == 7 && yLoc >= 59 && yLoc <= 63) begin
			dE <= 1;
		    uE <= 1;
		end
		
		// Vertical right
		else if (xLoc == 88 && yLoc >= 8 && yLoc <= 12 || xLoc == 88 && yLoc >= 14 && yLoc <= 18 ||
		xLoc == 88 && yLoc >= 20 && yLoc <= 51 || xLoc == 88 && yLoc >= 53 && yLoc <= 57 ||
		xLoc == 88 && yLoc >= 59 && yLoc <= 63) begin
			dE <= 1;
		    uE <= 1;
		end
	
		
		// Vertical first column (22) and (73)
		else if (xLoc == 22 && yLoc >= 8 && yLoc <= 12 || xLoc == 22 && yLoc >= 14 && yLoc <= 18 ||
		xLoc == 22 && yLoc >= 20 && yLoc <= 27 || xLoc == 22 && yLoc >= 29 && yLoc <= 39 ||
		xLoc == 22 && yLoc >= 41 && yLoc <= 51 || xLoc == 22 && yLoc >= 53 && yLoc <= 57 ||
		xLoc == 22 && yLoc >= 59 && yLoc <= 63) begin
			dE <= 1;
		    uE <= 1;
		end
		
		// Vertical first column (22) and (73)
		else if (xLoc == 73 && yLoc >= 8 && yLoc <= 12 || xLoc == 73 && yLoc >= 14 && yLoc <= 18 ||
		xLoc == 73 && yLoc >= 20 && yLoc <= 27 || xLoc == 73 && yLoc >= 29 && yLoc <= 39 ||
		xLoc == 73 && yLoc >= 41 && yLoc <= 51 || xLoc == 73 && yLoc >= 53 && yLoc <= 57 ||
		xLoc == 73 && yLoc >= 59 && yLoc <= 63) begin
			dE <= 1;
		    uE <= 1;
		end
		
		// Vertical second column (41) and (52)
		else if (xLoc == 40 && yLoc >= 14 && yLoc <= 27 || xLoc == 40 && yLoc >= 41 && yLoc <= 57) begin
			dE <= 1;
		    uE <= 1;
		end
		
		else if (xLoc == 52 && yLoc >= 14 && yLoc <= 27 || xLoc == 52 && yLoc >= 41 && yLoc <= 57) begin
			dE <= 1;
		    uE <= 1;
		end
		
		// Horizontal first row (13) and (59)
		else if (yLoc == 13 && xLoc >= 8 && xLoc <= 21 || yLoc == 13 && xLoc >= 23 && xLoc <= 39 ||
		yLoc == 13 && xLoc >= 53 && xLoc <= 72 || yLoc == 13 && xLoc >= 74 && xLoc <= 87) begin
		    rE <= 1;
		    lE <= 1;
		end
		
		else if (yLoc == 58 && xLoc >= 8 && xLoc <= 21 || yLoc == 58 && xLoc >= 23 && xLoc <= 39 ||
		yLoc == 58 && xLoc >= 53 && xLoc <= 72 || yLoc == 58 && xLoc >= 74 && xLoc <= 87) begin
		    rE <= 1;
		    lE <= 1;
		end
		
		// Horizontal second row (19) and (52)
		else if (yLoc == 19 && xLoc >= 8 && xLoc <= 21 || yLoc == 19 && xLoc >= 74 && xLoc <= 87) begin
		    rE <= 1;
		    lE <= 1;
		end
		
		else if (yLoc == 52 && xLoc >= 8 && xLoc <= 21 || yLoc == 52 && xLoc >= 74 && xLoc <= 87) begin
		    rE <= 1;
		    lE <= 1;
		end
		
		// Horizontal third row (28) and (40)
		else if (yLoc == 28 && xLoc >= 23 && xLoc <= 39 || yLoc == 28 && xLoc >= 41 && xLoc <= 51 ||
		yLoc == 28 && xLoc >= 53 && xLoc <= 72) begin
		    rE <= 1;
		    lE <= 1;
		end
		
		else if (yLoc == 40 && xLoc >= 23 && xLoc <= 39 || yLoc == 40 && xLoc >= 41 && xLoc <= 51 ||
		yLoc == 40 && xLoc >= 53 && xLoc <= 72) begin
		    rE <= 1;
		    lE <= 1;
		end
		
		// Corner top left
		else if (xLoc == 7 && yLoc == 7 || xLoc == 52 && yLoc == 13) begin
			rE <= 1;
		    dE <= 1;
		end
		
		// Corner top right
		else if (xLoc == 88 && yLoc == 7 || xLoc == 40 && yLoc == 13) begin
			lE <= 1;
		    dE <= 1;
		end
		
		// Corner bottom left
		else if (xLoc == 7 && yLoc == 64 || xLoc == 52 && yLoc == 58) begin
			rE <= 1;
		    uE <= 1;
		end
		
		// Corner bottom right
		else if (xLoc == 88 && yLoc == 64 || xLoc == 40 && yLoc == 58) begin
			uE <= 1;
		    lE <= 1;
		end
		
		// left, right, down
		else if (xLoc == 22 && yLoc == 7 || xLoc == 73 && yLoc == 7 || 
		xLoc == 40 && yLoc == 40 || xLoc == 52 && yLoc == 40) begin
		    rE <= 1;
		    dE <= 1;
		    lE <= 1;
		end
		
		// up, right, down
		else if (xLoc == 7 && yLoc == 13 || xLoc == 7 && yLoc == 19 || 
		xLoc == 7 && yLoc == 52 || xLoc == 7 && yLoc == 58 || xLoc == 22 && yLoc == 28 || xLoc == 22 && yLoc == 40 ||
		xLoc == 73 && yLoc == 19 || xLoc == 73 && yLoc == 52) begin
		    uE <= 1;
		    rE <= 1;
		    dE <= 1;
		end
		
		// up, left, right, down
		else if (xLoc == 22 && yLoc == 13 || xLoc == 22 && yLoc == 58 || 
		xLoc == 73 && yLoc == 13 || xLoc == 73 && yLoc == 58) begin
		    rE <= 1;
		    dE <= 1;
		    lE <= 1;
		    uE <= 1;
		end
		
		// up, left, down
		else if (xLoc == 22 && yLoc == 19 || xLoc == 22 && yLoc == 52 || 
		xLoc == 88 && yLoc == 13 || xLoc == 88 && yLoc == 19 || xLoc == 88 && yLoc == 52 ||
		xLoc == 88 && yLoc == 58 || xLoc == 73 && yLoc == 28 || xLoc == 73 && yLoc == 40) begin
		    dE <= 1;
		    lE <= 1;
		    uE <= 1;
		end
		
		// left, up, right
		else if (xLoc == 40 && yLoc == 28 || xLoc == 52 && yLoc == 28 || 
		xLoc == 22 && yLoc == 64 || xLoc == 73 && yLoc == 64) begin
		    rE <= 1;
		    lE <= 1;
		    uE <= 1;
		end
		
		
		
		
		end
		
	
	
endmodule 
		
//		else if (y == 64 && x % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (y == 13 && x >= 6 && x <= 41 && x % 3 == 1 || 
//		y == 13 && x >= 51 && x <= 89 && x % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (y == 58 && x >= 6 && x <= 41 && x % 3 == 1 || 
//		y == 58 && x >= 51 && x <= 89 && x % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (y == 19 && x >= 6 && x <= 23 && x % 3 == 1 || 
//		y == 19 && x >= 72 && x <= 89 && x % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (y == 52 && x >= 6 && x <= 23 && x % 3 == 1 || 
//		y == 52 && x >= 72 && x <= 89 && x % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		
//		else if (y == 28 && x >= 21 && x <= 74 && x % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (y == 40 && x >= 21 && x <= 74 && x % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		// Food Vertical
//		else if (x == 7 && y % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (x == 88 && y % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (x == 22 && y % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (x == 73 && y % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (x == 40 && y >= 12 && y <= 29 && y % 3 == 1 ||
//		x == 40 && y >= 38 && y <= 59 && y % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//		else if (x == 52 && y >= 12 && y <= 29 && y % 3 == 1 ||
//		x == 52 && y >= 38 && y <= 59 && y % 3 == 1) begin
//		    r <= 255;
//		    g <= 255;
//		    b <= 0;
//		end
//		
//
//	end