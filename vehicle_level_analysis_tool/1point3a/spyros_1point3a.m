addpath('..')
% Fill the cost arrays
X = 0:0.01:1;
cost1_arr = [];
cost2_arr = [];

% Constants based on the propellents chosen and requirements
Isp1 = 327;     %LOX/LCH4
Isp2 = 311;     %LOX/RP1
delta1 = 0.08;
delta2 = delta1;
mpl = 26000;

% For each X mass value call the mass_function and fill the arrays for mass
% stage 1, mass stage 2, and total mass
for i = 1:length(X)
    [stagecost_nr1, stagecost_nr2] = cost_function(Isp1, Isp2, X(i), delta1, delta2);
    cost1_arr(end+1) = stagecost_nr1;
    cost2_arr(end+1) = stagecost_nr2;
end

% Add the two arrays to get the array of total cost
tot_cost = cost1_arr + cost2_arr;

% Find the minimum gross mass, similar to min_cost_function, but save
% the associated X for the minimum total cost
min_cost = realmax;
for i = 1:length(tot_cost)
    if ~isnan(tot_cost(i)) && tot_cost(i) < min_cost
        min_cost = tot_cost(i);
        min_cost_X = X(i);
    end
end

% Plot the masses of stage 1, stage 2, and total mass in $B2025 as a 
% function of X. Also plot as a point the minimum total cost
plot(X, cost1_arr/1000, "Linewidth", 4)
hold on
plot(X, cost2_arr/1000, "Linewidth", 4)
plot(X, tot_cost/1000, "Linewidth", 4)
plot(min_cost_X, min_cost/1000, '*', "Linewidth", 4, MarkerSize=30)
ylim([0, 500])
legend("1st Stage Cost", "2nd Stage Cost", "Total Cost", "FontSize", 20)
xlabel("1st Stage DeltaV Fraction", "FontSize", 20)
ylabel("Cost ($B2025)", "FontSize", 20)
title("1st Stage: LOX/LCH4, 2nd Stage: LOX/RP1", "FontSize", 20)
