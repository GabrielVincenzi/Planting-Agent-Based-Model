function s = initcircularsugar(size, maxsugar, beta)
% The function creates an environment for the model with two radial, smooth peaks.
% It initializes two layers: the max capacity of the cell and its current level of
% sugar, forming a symmetric structure.
% Higher beta : steeper peaks.
mymap = [0.8667 0.6314 0.3686
            0.7373 0.4235 0.1451
            0.3765 0.4235 0.2196
            0.2196 0.4 0.2549
            0.4157 0.6 0.3059
            0.6549 0.7882 0.3412];

    % Create an empty environment with 'size x size' cells
    s = repmat(struct('currentlevel', 0, 'maxcapacity', 0), size, size);

    % Define the center of the environment
    center = (size - 1) / 2;

    % Set the coordinates for each cell in the environment
    for i = 1:size
        for j = 1:size
            % Define the locations of the two peaks
            peak1_center = [center / 2, center / 2];  % Top left
            peak2_center = [3 * center / 2, 3 * center / 2];  % Bottom right

            % Calculate the distance to each peak
            distance1 = sqrt((i - peak1_center(1))^2 + (j - peak1_center(2))^2);
            distance2 = sqrt((i - peak2_center(1))^2 + (j - peak2_center(2))^2);

            % Calculate the max capacity with a smooth drop-off for each peak
            % The parameter 'beta' scales the steepness of the peak's slope
            s(i, j).maxcapacity = maxsugar * (exp(-beta * distance1 / (size / 6)) + exp(-beta * distance2 / (size / 6)));
            s(i, j).currentlevel = s(i, j).maxcapacity;  % Initialize current level to max capacity
        end
    end
    
    % Display the maximum value of the max capacity matrix
    % Commented out for the App
    % maxval = max([s.maxcapacity]);
    % disp("The maximum value of Sugar is " + max(maxval));

    % figure(1);
    % set(gcf, 'Position', [200, 200, 600, 400]);
    % imagesc(reshape([s.maxcapacity], size, size));
    % colormap(mymap);
    % colorbar;
    % clim([0, 10]); 
    % axis square;
end