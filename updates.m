function s = updates(s, size, alpha)
% The function updates the current level of sugar in each position
% It is an alpha proportion of the maximum capacity of each cell

    for i = randperm(size)
        for j = randperm(size)
            if s(i, j).currentlevel + alpha * s(i, j).maxcapacity < s(i, j).maxcapacity
                s(i, j).currentlevel = s(i, j).currentlevel + alpha * s(i, j).maxcapacity;
            else
                s(i, j).currentlevel = s(i, j).maxcapacity;
            end
        end
    end
end

