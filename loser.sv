module loser#(parameter WIDTH = 96, parameter HEIGHT = 72)(
	
	input logic clk, reset,
	input logic [9:0] x, xPacLoc, xGhost,
	input logic [8:0] y, yPacLoc, yGhost,

	output logic gamelose,
	output logic [7:0] r, g, b);
   
	
	logic contact;
	logic	[12:0] displayAddress;
	logic [7:0]  rOut, gOut, bOut;

	

	always_ff @(posedge clk)
		if(reset)
			contact = 0;
		else if (xPacLoc == xGhost && yPacLoc == yGhost)
			contact = 1;
	
	
	always_ff @(posedge clk)begin
		if(reset)
			displayAddress = 0;
		else if (contact)begin
			displayAddress <= (y * WIDTH + x) + 1;
		
			end
		end
		
	ROM_gameOver_R 
		romR(
				.address(displayAddress),
				.clock(clk),
				.q(rOut));


	ROM_gameOver_G 
		romG(
				.address(displayAddress),
				.clock(clk),
				.q(gOut));


	ROM_gameOver_B 
		romB(
				.address(displayAddress),
				.clock(clk),
				.q(bOut));
				
				
	// output logic 
	assign gamelose = contact;
	assign r = rOut * 250;
	assign g = gOut * 250;
	assign b = bOut;

	 
endmodule
