function [agents, grid] = initagents(gridSize, s, visionmax, metabolismmax, numAgents)
    % Initialize agents without overlapping positions

    % Generate random unique positions for the agents
    [X, Y] = meshgrid(1:gridSize, 1:gridSize);
    allPositions = [X(:), Y(:)];
    randomIndices = randperm(size(allPositions, 1), numAgents);
    selectedPositions = allPositions(randomIndices, :);

    grid = zeros(gridSize);

    % Create agents at the selected positions
    agents = Agent.empty(numAgents, 0);
    for i = 1:numAgents
        position = selectedPositions(i, :);
        agents(i) = Agent(position, metabolismmax, visionmax, 1, 1);
        x = position(1);
        y = position(2);
        grid(x, y) = 1;
        initialWealth = s(x, y).currentlevel;
        agents(i).wealthHistory = initialWealth;
    end
end