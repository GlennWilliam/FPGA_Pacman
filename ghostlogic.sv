module ghostlogic(
    input logic [10:0] xPacLoc, yPacLoc, 
    input logic [10:0] xGhost, yGhost,
    input logic g1uE, g1lE, g1rE, g1dE,
    input clk,
    output logic gU, gD, gL, gR
);
    logic signed [10:0] dx;
    logic signed [10:0] dy;

    always_ff @(posedge clk) begin
        dx = xPacLoc - xGhost;
        dy = yPacLoc - yGhost;
        // Default directions to 0
        gU = 0;
        gD = 0;
        gL = 0;
        gR = 0;

        // Determine the direction based on dx and dy, and the availability of movement
        if (dx > 0 && g1rE) begin
            gR = 1;
        end else if (dx < 0 && g1lE) begin
            gL = 1;
        end else if (dy > 0 && g1dE) begin
            gD = 1;
        end else if (dy < 0 && g1uE) begin
            gU = 1;
        end
    end
endmodule
