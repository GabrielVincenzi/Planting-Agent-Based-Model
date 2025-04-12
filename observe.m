function [agent, temps, tempi, tempj] = observe(agent, k, grid, s, gridSize, temps, tempi, tempj)
% The function checks the level of sugar in each direction based on vision (k).
% It returns the coordinates of the best location for the agent to move.
% Fill the agent's visionGrid with past observations of the environment

    i = agent.position(1);
    j = agent.position(2);
    V = agent.vision;

    % Define the directions for the search
    south = [i+k, gridSize, i+k-gridSize, j, i+k, j];
    north = [k-i, -1, i-k+gridSize, j, i-k, j];
    east  = [j+k, gridSize, i, j+k-gridSize, i, j+k];
    west  = [k-j, -1, i, j-k+gridSize, i, j-k];
    directions = {south, north, east, west};

    % Define the directions in order to fill the agent's grid
    southGrid = [V+k+1, V+1];
    northGrid = [V-k+1, V+1];
    eastGrid  = [V+1, V-k+1];
    westGrid  = [V+1, V+k+1];
    directionsGrid = {southGrid, northGrid, eastGrid, westGrid};

    for m = 1:length(directions)
        % Choose the direction based on the previous cells
        if (directions{m}(1) > directions{m}(2))
            u = directions{m}(3);
            v = directions{m}(4);
            [temps, tempi, tempj] = locationcheck(u, v, s, grid, temps, tempi, tempj);
        else
            u = directions{m}(5);
            v = directions{m}(6);
            [temps, tempi, tempj] = locationcheck(u, v, s, grid, temps, tempi, tempj);
        end

        % Fill the agent's visionGrid with past observations of the environment
        agent.visionGrid(directionsGrid{m}(1), directionsGrid{m}(2)) = s(u, v).maxcapacity;

    end
end