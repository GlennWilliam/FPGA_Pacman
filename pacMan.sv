module pacMan #(parameter WIDTH = 96, parameter HEIGHT = 72) (
	input logic clk,
					reset,
					win, loose,
					uE, dE, rE, lE, //maze enable signals
					up, down, left, right, start, // controler signals
	input logic [9:0] x, // from display driver
	input logic [8:0] y,

	output logic [9:0] xPacLoc, 
	output logic [8:0] yPacLoc,
	output logic [7:0]r, g, b);

	//internal wires
	logic m_up, m_down, m_right, m_left, e_start, m_hold,
			upOut, downOut, leftOut, rightOut;
	
	user_direction_hold user_D( // holds user input
										.clk, .reset,
										.upIn(up), .downIn(down), .leftIn(left), .rightIn(right), .startIn(start),
										.upOut, .downOut, .leftOut, .rightOut);
	
	pacMan_cont c_unit (//inputs
							.clk,
							.reset,
							.win, .loose,
							.uE, .dE, .rE, .lE, //maze enable signals
							.up(upOut), .down(downOut), .left(leftOut), .right(rightOut), .start, // controler signals
							//outputs
							.m_up, .m_down, .m_right, .m_left, .e_start, .m_hold); // output moves		
	
	pacMan_datapath#(.WIDTH(96), .HEIGHT(72)) d_unit  (
									.clk,
									.reset,
									.m_up, .m_down, .m_right, .m_left, .e_start, // valid moves from control
									//outputs
									.xPacLoc,
									.yPacLoc);
	
	pacMan_display pDis ( 	//inputs
								.clk,
								.reset,
								.m_up, .m_down, .m_right, .m_left, .e_start, .m_hold,
								.x, .xPacLoc,
								.y, .yPacLoc,
								//outputs
								.r, .g, .b);
	
endmodule 
		

