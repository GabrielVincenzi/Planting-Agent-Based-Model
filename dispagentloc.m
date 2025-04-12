function a = dispagentloc(s, size, grid)
    % Display the agent locations in a subplot for each run
    mymap = [0.8667 0.6314 0.3686
            0.7373 0.4235 0.1451
            0.3765 0.4235 0.2196
            0.2196 0.4 0.2549
            0.4157 0.6 0.3059
            0.6549 0.7882 0.3412];

    figure(2);
    set(gcf, 'Position', [100, 200, 600, 400]);
    imagesc(reshape([s.maxcapacity], size, size));
    colormap(mymap);
    colorbar;
    clim([0, 10]); 

    %title("Maximum Capacity of the Environment");
    axis square;
    hold on;

    %subplot(ceil(sqrt(nruns)), ceil(sqrt(nruns)), runs); 
    spy(grid, 'k', 10);
    axis square;
end
