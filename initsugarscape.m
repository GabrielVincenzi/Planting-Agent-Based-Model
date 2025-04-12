function s = initsugarscape(size, maxsugar)
% The function creates the environment for the model with two peaks.
% It builds two layers: max capacity of the cell and its current level of
% sugar in a symmetric structure object.
mymap = [0.8667 0.6314 0.3686
            0.7373 0.4235 0.1451
            0.3765 0.4235 0.2196
            0.2196 0.4 0.2549
            0.4157 0.6 0.3059
            0.6549 0.7882 0.3412];

    x = -ceil(0.75*size) : size-ceil(0.75*size)-1;
    y = -ceil(0.25*size) : size-ceil(0.25*size)-1;
    s1 = repmat(struct('currentlevel', 0, 'maxcapacity', 0), size, size);
    for i = 1:size
      for j = 1:size
          if (x(i) == 0 && y(j) == 0)
              s1(i,j).maxcapacity = maxsugar;
          else
              s1(i,j).maxcapacity = maxsugar / sqrt(abs(x(i)) + abs(y(j)));
          end 
      end
    end
    
    s2 = s1';
    s = repmat(struct('currentlevel', 0, 'maxcapacity', 0), size, size);
    for i = 1:size
        for j = 1:size
            s(i,j).maxcapacity = s1(i,j).maxcapacity + s2(i,j).maxcapacity;
            s(i,j).currentlevel = s(i,j).maxcapacity;
        end
    end
    
    % maxrow = max([s.maxcapacity]);
    % disp("The maximum value of Sugar is " + max(maxrow))
    
    % Commented out for the App
    % figure(1);
    % imagesc(reshape([s.maxcapacity], size, size));
    % title("Maximum Capacity of the Environment")
    % colormap(mymap);
    % colorbar;
    %clim([0, 10]); 
    % axis square;
end

