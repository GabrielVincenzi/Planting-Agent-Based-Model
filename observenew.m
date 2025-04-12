function [agent, new_env] = observenew(agent, new_env, k, s, size)
% The function creates a new grid to be compared with the visionGrid of each agent.
% Whether it is better or worst than the previous one. It builds the
% baseline to update agent's probability of planting a tree.

    i = agent.position(1);
    j = agent.position(2);
    V = agent.vision;

    % Define the directions for the search
    south = [i+k, size, i+k-size, j, i+k, j];
    north = [k-i, -1, i-k+size, j, i-k, j];
    east  = [j+k, size, i, j+k-size, i, j+k];
    west  = [k-j, -1, i, j-k+size, i, j-k];
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
        else
            u = directions{m}(5);
            v = directions{m}(6);
        end

        % Fill the new grid with past observations of the environment
        new_env(directionsGrid{m}(1), directionsGrid{m}(2)) = s(u, v).maxcapacity;
    end

end
