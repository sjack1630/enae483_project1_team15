% TP 1
% Chris Witherspoon
% 1.3

addpath('..')

% Delta constants
d1 = 0.08 ;
d2 = 0.08 ;

% Specific impulse (storables)
isp = 285 ;
isp_comp = 366 ; % 2nd liquid

% Payload mass
mpl = 26000 ;

% Initialize the x array
x = 0:0.001:1 ;

% Create an empty array for later use
first_stage = [];
second_stage = [];

% Cost function loop
i = 1 ;
while i <= length(x)
    [first_stage_cost, second_stage_cost] = cost_function(isp, isp_comp, x(i), d1, d2);
    first_stage(end+1) = first_stage_cost;
    second_stage(end+1) = second_stage_cost;
    i = i + 1 ;
end

% Create an array for the total cost
total_cost = first_stage + second_stage ;

% Initialize the value to change for later
min = realmax;

% Find the value of the minimum cost
i = 1 ;
while i<= length(total_cost)
    if ~isnan(total_cost(i)) && total_cost(i) < min
        min = total_cost(i);
        min_cost_val = x(i);
    end
    i = i + 1 ;
end


% Plot the graph
plot(x, first_stage/1000)
hold on
plot(x, second_stage/1000)
plot(x, total_cost/1000)
plot(min_cost_val, min/1000, '.', MarkerSize=20)
ylim([0, 500])
legend("First Stage", "Second Stage", "Combined Cost")
xlabel("First Stage \DeltaV Fraction")
ylabel("Cost (billions)")
title("Storables cost v stage graph") % Storables is the consistent