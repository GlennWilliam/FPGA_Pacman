module winner#(parameter WIDTH = 96, parameter HEIGHT = 72)(
	
	input logic clk, reset, gamewin,
	input logic [9:0] x,
	input logic [8:0] y,

	output logic gamelose,
	output logic [7:0] r, g, b);
   
	
	logic contact;
	logic	[12:0] displayAddress;
	logic [7:0]  qOut;
	
	
	always_ff @(posedge clk)begin
		if(reset)
			displayAddress = 0;
		else if (gamewin)begin
			displayAddress <= (y * WIDTH + x) + 1;
		
			end
		end
		
	ROM_win 
		romW(
				.address(displayAddress),
				.clock(clk),
				.q(qOut));

	// output logic 
	assign gamelose = contact;
	assign r = qOut * 250;
	assign g = qOut * 250;
	assign b = qOut;

	 
endmodule
