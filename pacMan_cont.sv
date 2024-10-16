module pacMan_cont (
	input logic clk,
					reset,
					win, loose,
					uE, dE, rE, lE, //maze enable signals
					up, down, left, right, start, // controler signals
	output logic m_up, m_down, m_right, m_left, e_start, m_hold); // output moves			

	
	//state variables				
	enum{s_start, s_hold, 
			s_up, s_down, s_right, s_left,
			s_checkU, s_checkD, s_checkR, s_checkL,
			s_win, s_loose} ps, ns;
					
					
	// Controller logic w/synchronous reset
	always_ff @(posedge clk)
		if (reset)
			ps <= s_start;
		else
			ps <= ns;
	

	
	// Next state logic constant movement 
	always_comb
		begin
			case(ps)
					s_start:	ns = start ? s_hold : s_start;
					
					s_up:		if	(dE && down) ns = s_down;
								else if (uE) ns = s_checkU;
								else if (rE && right) ns = s_right;
								else if (lE && left) ns = s_left;
								else if (loose) ns = s_loose;
								else if (win) ns = s_win;
								else ns = s_hold;
								
					s_checkU:if (loose) ns = s_loose;
								else if (dE && down) ns = s_down;
								else if (rE && right) ns = s_right;
								else if (lE && left) ns = s_left;
								else if (uE) ns = s_up;
								else ns = s_hold;
								
					s_down:	if	(uE && up) ns = s_up;
								else if (dE) ns = s_checkD;
								else if (rE && right) ns = s_right;
								else if (lE && left) ns = s_left;
								else if (loose) ns = s_loose;
								else if (win) ns = s_win;
								else ns = s_hold;
					
					s_checkD:if (loose) ns = s_loose;
								else if	(uE && up) ns = s_up;
								else if (rE && right) ns = s_right;
								else if (lE && left) ns = s_left;
								else if (dE) ns = s_down;
								else ns = s_hold;
								
					s_right:	if	(lE && left) ns = s_left;
								else if (rE) ns = s_checkR;								
								else if (uE && up) ns = s_up;
								else if (dE && down) ns = s_down;
								else if (loose) ns = s_loose;
								else if (win) ns = s_win;
								else ns = s_hold;
								
					s_checkR:if (loose) ns = s_loose;
								else if (lE && left) ns = s_left;
								else if	(uE && up) ns = s_up;
								else if (dE && down) ns = s_down;
								else if (rE) ns = s_right;
								else ns = s_hold;
								
					s_left:	if (rE && right) ns = s_right;
								else if	(lE) ns = s_checkL;
								else if	(uE && up) ns = s_up;
								else if (dE && down) ns = s_down;
								else if (loose) ns = s_loose;
								else if (win) ns = s_win;
								else ns = s_hold;
					
					s_checkL:if (loose) ns = s_loose;
								else if (rE && right) ns = s_right;
								else if	(uE && up) ns = s_up;
								else if (dE && down) ns = s_down;
								else if (lE) ns = s_left;
								else ns = s_hold;
								
					s_hold:	if	(uE && up) ns = s_up;
								else if (dE && down) ns = s_down;
								else if (rE && right) ns = s_right;
								else if (lE && left) ns = s_left;
								else if (loose) ns = s_loose;
								else if (win) ns = s_win;
								else ns = s_hold;
							
								
					s_loose: ns = start ? s_start : s_loose;
					
					s_win: ns = start ? s_start : s_win;
					

			endcase
		end
		
		//output logic
		assign m_up		= (ps == s_up);
		assign m_down	= (ps == s_down);
		assign m_right	= (ps == s_right);
		assign m_left	= (ps == s_left);
		assign e_start	= (ps == s_start);
		assign m_hold	= (ps == s_hold);
		

	
endmodule 


//	// Next state logic for single space movement 
//	always_comb
//		begin
//			case(ps)
//					s_start:	ns = start ? s_hold : s_start;
//					
//					s_hold:	if	(uE && up) ns = s_up;
//								else if (dE && down) ns = s_down;
//								else if (rE && right) ns = s_right;
//								else if (lE && left) ns = s_left;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//					
//					s_up:		ns = s_hold;
//								
//					s_down:	ns = s_hold;
//								
//					s_right:	ns = s_hold;
//								
//					s_left:	ns = s_hold;
//								
//					s_loose: ns = start ? s_start : s_loose;
//					
//					s_win: ns = start ? s_start : s_win;
//					
//
//			endcase
//		end

//	// Next state logic constant movement first try fail
//	always_comb
//		begin
//			case(ps)
//					s_start:	ns = start ? s_hold : s_start;
//					
//					s_up:		if	(dE && down) ns = s_down;
//								else if (uE) ns = s_up;
//								else if (rE && right) ns = s_right;
//								else if (lE && left) ns = s_left;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//								
//					s_down:	if	(uE && up) ns = s_up;
//								else if (dE) ns = s_down;
//								else if (rE && right) ns = s_right;
//								else if (lE && left) ns = s_left;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//								
//					s_right:	if	(lE && left) ns = s_left;
//								else if (rE) ns = s_right;								
//								else if (uE && up) ns = s_up;
//								else if (dE && down) ns = s_down;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//								
//					s_left:	if (rE && right) ns = s_right;
//								else if	(lE) ns = s_left;
//								else if	(uE && up) ns = s_up;
//								else if (dE && down) ns = s_down;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//								
//					s_hold:	if	(uE && up) ns = s_up;
//								else if (dE && down) ns = s_down;
//								else if (rE && right) ns = s_right;
//								else if (lE && left) ns = s_left;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//							
//								
//					s_loose: ns = start ? s_start : s_loose;
//					
//					s_win: ns = start ? s_start : s_win;
//					
//
//			endcase
//		end



//	// Next state logic constant movement fail 2
//	always_comb
//		begin
//			case(ps)
//					s_start:	ns = start ? s_hold : s_start;
//					
//					s_up:		if	(dE && down) ns = s_down;
//								else if (uE) ns = s_up;
//								else if (rE && right) ns = s_right;
//								else if (lE && left) ns = s_left;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//								
//					s_checkU: ns = uE ? s_up : s_hold;
//								
//					s_down:	if	(uE && up) ns = s_up;
//								else if (dE) ns = s_checkD;
//								else if (rE && right) ns = s_right;
//								else if (lE && left) ns = s_left;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//					
//					s_checkD: ns = dE ? s_down : s_hold;
//								
//					s_right:	if	(lE && left) ns = s_left;
//								else if (rE) ns = s_checkR;								
//								else if (uE && up) ns = s_up;
//								else if (dE && down) ns = s_down;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//								
//					s_checkR: ns = rE ? s_right : s_hold;
//								
//					s_left:	if (rE && right) ns = s_right;
//								else if	(lE) ns = s_checkL;
//								else if	(uE && up) ns = s_up;
//								else if (dE && down) ns = s_down;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//					
//					s_checkL: ns = lE ? s_left : s_hold;
//								
//					s_hold:	if	(uE && up) ns = s_up;
//								else if (dE && down) ns = s_down;
//								else if (rE && right) ns = s_right;
//								else if (lE && left) ns = s_left;
//								else if (loose) ns = s_loose;
//								else if (win) ns = s_win;
//								else ns = s_hold;
//							
//								
//					s_loose: ns = start ? s_start : s_loose;
//					
//					s_win: ns = start ? s_start : s_win;
//					
//
//			endcase
//		end