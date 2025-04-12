function dispwealth(agents, nruns, runs)
    % The function displays the last wealth values of active agents as a histogram.

    numActiveAgents = sum([agents.active] == 1);
    wealthValues = zeros(1, numActiveAgents);

    % Loop through each active agent and find each present wealth value
    id = 1;
    for i = 1:length(agents)
        if agents(i).active == 1
            wealthValues(id) = agents(i).getLastWealth();
            id = id + 1;
        end
    end

    % Create a new figure window for displaying the histogram of wealth values
    figure(3);
    set(gcf, 'Position', [800, 200, 600, 400]);
    subplot(ceil(sqrt(nruns)), ceil(sqrt(nruns)), runs);
    histogram(wealthValues, 'FaceColor', 'k');
    axis square;
end