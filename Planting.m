%% Sugarscape with Class Agent
% Cooperative game where each individual can cooperate or defect on the
% depletion or creation of resources.

gridSize = 100;
numAgents = 1000;
visionmax = 5;
metabolismmax = 5;
maxsugar = 20;
accumulation_rule = 0.5;
resource_steepness = 1.5;
resource_usage = 0.2;
nruns = 9;

%s = initsugarscape(gridSize, maxsugar);
s = initcircularsugar(gridSize, maxsugar, resource_steepness);
[agents, grid] = initagents(gridSize, s, visionmax, metabolismmax, numAgents);

for runs = 1:nruns
    dispagentloc(s, gridSize, grid);
    dispwealth(agents, nruns, runs);
    s = updates(s, gridSize, accumulation_rule);

    for idx = randperm(length(agents)) % Use the length of agents to get the random order
        agent = agents(idx); % Get the current agent
        if agent.active == 1
            
            % Agent explores sugarscape in random directions and selects the best location
            temps = s(agent.position(1), agent.position(2));  % Get the sugar at agent's current position
            tempi = agent.position(1);
            tempj = agent.position(2);
            
            for k = agent.vision : -1 : 1  % Vision range
                [agents(idx), temps, tempi, tempj] = observe(agents(idx), k, grid, s, gridSize, temps, tempi, tempj);
            end
            
            % Agent moves to best location, updates sugar stock and eats sugar
            [agents(idx), grid, s] = moveagent(agents(idx), s, tempi, tempj, temps, grid, true, resource_usage);

            % Agent observes new environment
            new_env = zeros(2*agents(idx).vision+1);
            for k = agent.vision : -1 : 1
                [agents(idx), new_env] = observenew(agents(idx), new_env, k, s, gridSize);
            end

            % Find the difference between before and now
            diff_env = new_env - agents(idx).visionGrid;
            agents(idx).visionGrid = double(diff_env >0);
           

            % Update agent's probability of planting a tree
            N = agents(idx).vision * 4;
            X = sum(agents(idx).visionGrid, 'all');
            agents(idx) = agents(idx).updatePlantingProb(N, X);

            %disp(['Agent ', num2str(idx), ' moved to ', num2str(agent.position)])
            %disp(['New wealth: ', num2str(agent.getLastWealth())])
        end
    end
end