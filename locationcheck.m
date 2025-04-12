function [temps, tempi, tempj] = locationcheck(u, v, s, grid, temps, tempi, tempj)
% Check if the observed location is free and if it has more sugar

    if grid(u, v) == 0  % Check if the location is free (i.e., no agent is there)
        if s(u, v).currentlevel >= temps.currentlevel  % Check if there's enough sugar
            temps = s(u, v);  % Update the sugar at the location
            tempi = u;
            tempj = v;
        end
    end
end

