classdef Agent
    % The individual unit of the model.

    properties
        metabolism
        vision
        visionGrid
        wealthHistory
        active = 1
        position
        alpha
        beta
        probPlanting
    end

    methods
        function obj = Agent(position, metabolismmax, visionmax, alpha, beta)
            % Constructor to initialize the agent with given parameters
            obj.position = position;
            obj.alpha = alpha;
            obj.beta = beta;
            obj.metabolism = ceil(rand * metabolismmax);
            obj.vision = ceil(rand * visionmax);
            obj.visionGrid = zeros(2*obj.vision+1);
            obj.wealthHistory = 0;
            obj.probPlanting = 0.5;
        end
        
        % Method to update the wealth and store it in the history
        function obj = updateWealth(obj, newWealth)
            obj.wealthHistory = [obj.wealthHistory, newWealth];
        end
        
        % Method to get the last value of wealth
        function lastWealth = getLastWealth(obj)
            lastWealth = obj.wealthHistory(end);
        end

        % Method to update the distribution of p
        function obj = updatePlantingProb(obj, N, X)
            obj.alpha = obj.alpha + X;
            obj.beta = obj.beta + (N - X);
            obj.probPlanting = obj.alpha / (obj.alpha + obj.beta);
            %obj.prob_planting = betarnd(obj.alpha, obj.beta);
        end
    end
end


% Use Beta (a, b) distribution as a prior for p, then update it as
% a_up = a + higher cells
% b_up = b + (total cells - higher cells)
% p_up = a_up / (a_up + b_up)