module ghost #(parameter WIDTH = 96, parameter HEIGHT = 72,
					parameter X_START = 46, parameter Y_START = 28,
					parameter RED = 255, parameter GRN = 0, parameter BLUE = 0) (
	input logic clk,
					reset,
					win, loose,
					uE, dE, rE, lE, //maze enable signals
					up, down, left, right, start, // controler signals
	input logic [9:0] x, // from display driver
	input logic [8:0] y,

	output logic [9:0] xGhost, 
	output logic [8:0] yGhost,
	output logic [7:0]r, g, b);

	//internal wires
	logic m_up, m_down, m_right, m_left, e_start, m_hold,
			upOut, downOut, leftOut, rightOut;
	
	user_direction_hold g_hold( // holds user input
										.clk, .reset,
										.upIn(up), .downIn(down), .leftIn(left), .rightIn(right), .startIn(start),
										.upOut, .downOut, .leftOut, .rightOut);
	
	ghost_cont c_unit (//inputs
							.clk,
							.reset,
							.win, .loose,
							.uE, .dE, .rE, .lE, //maze enable signals
							.up(upOut), .down(downOut), .left(leftOut), .right(rightOut), .start, // controler signals
							//outputs
							.m_up, .m_down, .m_right, .m_left, .e_start, .m_hold); // output moves		
	
	ghost_datapath#(WIDTH, HEIGHT) d_unit  (
									.clk,
									.reset,
									.m_up, .m_down, .m_right, .m_left, .e_start, // valid moves from control
									//outputs
									.xGhost,
									.yGhost);
	
	ghost_display#(RED, GRN, BLUE) gDis ( 	//inputs
								.clk,
								.reset,
								.m_up, .m_down, .m_right, .m_left, .e_start, .m_hold,
								.x, .xGhost,
								.y, .yGhost,
								//outputs
								.r, .g, .b);
	
endmodule 