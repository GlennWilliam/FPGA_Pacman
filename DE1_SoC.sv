
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, V_GPIO,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	inout logic [35:26] V_GPIO; // added for controler


	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	
	// clock divider
	logic [31:0] clkD;
	logic slow_clk;

	clock_divider divider (.clock(CLOCK_50), .divided_clocks(clkD));

	assign slow_clk = clkD[21]; //14 = 1526 Hz (50 MHz / 2**(14+1))

	//
	logic reset, 
			up, down, left, right, select, start, A, B, 
			uE, dE, rE, lE,
			g1uE, g1dE, g1rE, g1lE,
			win, loose,
			gamewin, gamelose;
	logic [9:0] x, xPacLoc, xGhost;
	logic [8:0] y, yPacLoc, yGhost;
	logic [7:0] r, g, b,
					r_maze, g_maze, b_maze,
					r_food, g_food, b_food,
					r_pac, g_pac, b_pac,
					r_g1, g_g1, b_g1,
					r_over, g_over, b_over,
					r_win, g_win, b_win;
					
	
	video_driver #(.WIDTH(96), .HEIGHT(72))
		v1 (.CLOCK_50, .reset(~KEY[3]), .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	
	n8_driver n8outs ( //inputs 
							.clk(CLOCK_50), .data_in(V_GPIO[28]), .latch(V_GPIO[26]), .pulse(V_GPIO[27]), 
							//outputs
							.up(up), .down(down), .left(left), .right(right), .select(select), .start(start), .a(A), .b(B));
	
	n8_display 
		n8DisHex(
					  .clk(CLOCK_50),
					  .up(up), .down(down), .left(left), .right(right), .select(select), .start(start), .a(A), .b(B),
					  .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5)
					  );
					  
	// Metastability 
 	logic U, D, L, R, S;
  	userInput uM (.clock(slow_clk), .reset, .Key(up), .Out(U));
  	userInput dM (.clock(slow_clk), .reset, .Key(down), .Out(D));
  	userInput lM (.clock(slow_clk), .reset, .Key(left), .Out(L));
  	userInput rM (.clock(slow_clk), .reset, .Key(right), .Out(R));
  	userInput sM (.clock(slow_clk), .reset, .Key(start), .Out(S));

// 	logic U, D, L, R, S;
//	userInput uP (.clock(slow_clk), .reset, .Key(~KEY[3]), .Out(U));
//	userInput dP (.clock(slow_clk), .reset, .Key(~KEY[2]), .Out(D));
//	userInput lP (.clock(slow_clk), .reset, .Key(~KEY[1]), .Out(L));
//	userInput rP (.clock(slow_clk), .reset, .Key(~KEY[0]), .Out(R));
//	userInput sP (.clock(slow_clk), .reset, .Key(SW[0]), .Out(S));

	logic gU, gD, gL, gR, gS;
// 	userInput uG (.clock(slow_clk), .reset, .Key(SW[4]), .Out(gU));
// 	userInput dG (.clock(slow_clk), .reset, .Key(SW[3]), .Out(gD));
// 	userInput lG (.clock(slow_clk), .reset, .Key(SW[2]), .Out(gL));
// 	userInput rG (.clock(slow_clk), .reset, .Key(SW[1]), .Out(gR));
	//userInput sG (.clock(slow_clk), .reset, .Key(SW[0]), .Out(gS));
	// assign LEDR[9:0] = xPacLoc;
	assign reset = ~KEY[0];

	
	pacMan #(.WIDTH(96), .HEIGHT(72))
		pac (
				.clk(slow_clk),
				.reset,
				.win, .loose,
				.uE, .dE, .rE, .lE, //maze enable signals
				.up(U), .down(D), .left(L), .right(R), .start(S), // controler signals
				.x, // from display driver
				.y,
				// output location and display signals
				.xPacLoc, 
				.yPacLoc,
				.r(r_pac), .g(g_pac), .b(b_pac));
				
	maze_logic 
		pac_mz_logic ( //inputs
						.xLoc(xPacLoc), .yLoc(yPacLoc), 
						//outputs
						.uE, .dE, .rE, .lE);
	
	ghost #(.WIDTH(96), .HEIGHT (72),
				.X_START(46), .Y_START(28), // ghost start location
				.RED(255), .GRN(0), .BLUE(0)) //ghost color
			g1(
				.clk(slow_clk),
				.reset,
				.win, .loose,
				.uE(g1uE), .dE(g1dE), .rE(g1rE), .lE(g1lE), //maze enable signals
				.up(gU), .down(gD), .left(gL), .right(gR), .start(S), // controler signals
				.x, // from display driver
				.y,
				// output
				.xGhost, 
				.yGhost,
				.r(r_g1), .g(g_g1), .b(b_g1));
				
	maze_logic 
		g1_mz_logic ( //inputs
						.xLoc(xGhost), .yLoc(yGhost), 
						//outputs
						.uE(g1uE), .dE(g1dE), .rE(g1rE), .lE(g1lE));

    maze
		generate_maze (
			.x(x), .y(y), 
			.r(r_maze), .g(g_maze), .b(b_maze));
	
	food_4
		generate_food (
			.x(x), .y(y),
			.r(r_food), .g(g_food), .b(b_food), 
			.xPacLoc(xPacLoc), .yPacLoc(yPacLoc), 
			.clk(CLOCK_50), .gamewin(gamewin));
	
	ghostlogic 
		movementghost (
			.xPacLoc(xPacLoc), .yPacLoc(yPacLoc), 
			.xGhost(xGhost), .yGhost(yGhost),  
			.g1uE(g1uE), .g1lE(g1lE), .g1rE(g1rE), .g1dE(g1dE),
			.gU(gU), .gD(gD), .gL(gL), .gR(gR), .clk(slow_clk));
    
   loser #(.WIDTH(96), .HEIGHT(72))
		gameOver(
			.clk(CLOCK_50), .reset,
			.x, .xPacLoc, .xGhost,
			.y, .yPacLoc, .yGhost,
			// outputs
			.gamelose,
			.r(r_over), .g(g_over), .b(b_over));
			
	winner #(.WIDTH(96), .HEIGHT(72))
		win_display(	
			.clk(CLOCK_50), .reset, .gamewin,
			.x,
			.y,
			//outputs
			.r(r_win), .g(g_win), .b(b_win));

	
	// This to check
	assign LEDR[0] = gamelose;
	assign LEDR[1] = gamewin;
	
	// display logic 
	always_comb begin
		if (gamewin) begin
			r = r_win;
			g = g_win;
			b = b_win;
		end else if (gamelose) begin
			r = r_over;
			g = g_over;
			b = b_over;
		end else if (r_pac != 0 || g_pac != 0 || b_pac != 0) begin
			r = r_pac;
			g = g_pac;
			b = b_pac;
		end else if (r_g1 != 0 || g_g1 != 0 || b_g1 != 0) begin
			r = r_g1;
			g = g_g1;
			b = b_g1;
		end else if (r_maze != 0 || g_maze != 0 || b_maze != 0) begin
			r = r_maze;
			g = g_maze;
			b = b_maze;
		end else if (r_food != 0 || g_food != 0 || b_food != 0) begin
			r = r_food;
			g = g_food;
			b = b_food;
		end else begin
			r = 0;
			g = 0;
			b = 0;
		end
	end

	
//	assign HEX0 = '1;
//	assign HEX1 = '1;
//	assign HEX2 = '1;
//	assign HEX3 = '1;
//	assign HEX4 = '1;
//	assign HEX5 = '1;
//	assign reset = 0;
	
endmodule  // DE1_SoC

