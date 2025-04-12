function [agent, grid, s] = moveagent(agent, s, tempi, tempj, temps, grid, planting, resourceusage)
% Move the agent to the best location found, update sugar stock, and eat sugar.

    x = agent.position(1);
    y = agent.position(2);
    
    % If the agent has found a better location to move
    if temps.currentlevel > s(agent.position(1), agent.position(2)).currentlevel

        % Move agent to the new position
        agent.position = [tempi, tempj];
        
        % Update the grid
        grid(x, y) = 0;
        grid(tempi, tempj) = 1;
        
        
        % Update wealth and sugar level at new location
        % Plant a tree in the next place
        if planting
            plant_tree = binornd(1, agent.probPlanting);

            if plant_tree
                new_wealth = agent.getLastWealth + resourceusage * temps.currentlevel - agent.metabolism;
                agent = agent.updateWealth(new_wealth);
                s(tempi, tempj).currentlevel = 0;
                s(tempi, tempj).maxcapacity = s(tempi, tempj).maxcapacity + (1 - resourceusage) * temps.currentlevel;
            else
                new_wealth = agent.getLastWealth + temps.currentlevel - agent.metabolism;
                agent = agent.updateWealth(new_wealth);
                s(tempi, tempj).currentlevel = 0;
                s(tempi, tempj).maxcapacity = s(tempi, tempj).maxcapacity - (resourceusage / 2) * temps.currentlevel;
            end


        else
            new_wealth = agent.getLastWealth + temps.currentlevel - agent.metabolism;
            agent = agent.updateWealth(new_wealth);
            s(tempi, tempj).currentlevel = 0;
        end

    else
        % If the agent stays at the same location temps = s
        if planting
            new_wealth = agent.getLastWealth + resourceusage * temps.currentlevel - agent.metabolism;
            agent = agent.updateWealth(new_wealth);
            s(tempi, tempj).currentlevel = 0;
            s(tempi, tempj).maxcapacity = s(tempi, tempj).maxcapacity + (1 - resourceusage) * temps.currentlevel;
        else
            new_wealth = agent.getLastWealth + temps.currentlevel - agent.metabolism;
            agent = agent.updateWealth(new_wealth);
            s(tempi, tempj).currentlevel = 0;
        end
    end

    % Check if the agent's wealth is non-positive
    if new_wealth <= 0
        agent.active = 0; % Mark the agent as inactive
        grid(agent.position(1), agent.position(2)) = 0;
    end
end