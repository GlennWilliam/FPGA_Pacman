// This modules display in the path every 3 pixels (yellow colored)
// Once the food is eaten, it deleted the food
module food_4 (x, y, xPacLoc, yPacLoc, r, g, b, clk, gamewin, reset);
    
    input logic clk, reset;
	input logic [9:0] x, xPacLoc;
	input logic [8:0] y, yPacLoc;
	output logic [7:0] r, g, b;
	output logic gamewin;
	logic [7:0] food_count;

    // Memory array to track food state (1 if food is present, 0 if food is eaten)
    logic food_state[96][72]; // Assuming VGA resolution, adjust size as needed
    // Initialize the food state array
    initial begin
        food_count = 0;
        for (int i = 0; i < 96; i++) begin
            for (int j = 0; j < 72; j++) begin
                food_state[i][j] = 0;
            end
        end
        
        // Horizontal
        for (int i = 7; i <= 89; i = i + 3) begin
            food_state[i][7] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 7; i <= 89; i = i + 3) begin
            food_state[i][64] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 7; i <= 40; i = i + 3) begin 
            food_state[i][13] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 52; i <= 88; i = i + 3) begin
            food_state[i][13] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 7; i <= 40; i = i + 3) begin
            food_state[i][58] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 52; i <= 88; i = i + 3) begin
            food_state[i][58] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 7; i <= 22; i = i + 3) begin
            food_state[i][19] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 73; i <= 88; i = i + 3) begin
            food_state[i][19] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 7; i <= 22; i = i + 3) begin
            food_state[i][52] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 73; i <= 88; i = i + 3) begin
            food_state[i][52] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 22; i <= 73; i = i + 3) begin
            food_state[i][28] = 1;
            food_count = food_count + 1;
        end
        
        for (int i = 22; i <= 73; i = i + 3) begin
            food_state[i][40] = 1;
            food_count = food_count + 1;
        end
        
        // Vertical 
        for (int j = 7; j <= 64; j = j + 3) begin
            food_state[7][j] = 1;
            food_count = food_count + 1;
        end
        
        for (int j = 7; j <= 64; j = j + 3) begin
            food_state[88][j] = 1;
            food_count = food_count + 1;
        end
        
        for (int j = 7; j <= 64; j = j + 3) begin
            food_state[22][j] = 1;
            food_count = food_count + 1;
        end
        
        for (int j = 7; j <= 64; j = j + 3) begin 
            food_state[73][j] = 1;
            food_count = food_count + 1;
        end
        
        for (int j = 13; j <= 28; j = j + 3) begin
            food_state[40][j] = 1;
            food_count = food_count + 1;
        end
        
        for (int j = 40; j <= 58; j = j + 3) begin
            food_state[40][j] = 1;
            food_count = food_count + 1;
        end
        
        for (int j = 13; j <= 28; j = j + 3) begin
            food_state[52][j] = 1;
            food_count = food_count + 1;
        end
        
        for (int j = 40; j <= 58; j = j + 3) begin
            food_state[52][j] = 1;
            food_count = food_count + 1;
        end
        
        
    end

    // Update food state on Pacman collision
    always_ff @(posedge clk) begin
        if (food_state[xPacLoc][yPacLoc]) begin
            food_state[xPacLoc][yPacLoc] <= 0; // Mark food as eaten
            food_count = food_count - 1;
        end
        
        if (food_count == 0) begin
            gamewin = 1;
        end else begin
            gamewin = 0;
        end
    end
    
    // Set pixel color based on food state
    always_comb begin
        // Default color (black)
        r = 0;
        g = 0;
        b = 0;

        // Check food state for the current pixel
        if (food_state[x][y]) begin
            // Food color (yellow)
            r = 255;
            g = 255;
            b = 0;
        end
    end
    
    
endmodule