% solids row
% combo: first prop: LOX/LH2, second prop: solid
addpath('..')

% Set constants based on requirements and propellant combination
delta1 = 0.08;
delta2 = 0.08;
Isp1 = 366;
Isp2 = 269;
m_pl = 26000;

% Initialize/populate arrays
X = 0:0.001:1;
cost_stage1_arr = [];
cost_stage2_arr = [];

% For each X value, call cost_function and populate the arrays for cost of
% stage 1 and mass of stage 2
for i = 1:length(X)
    [stageCost_nr1, stageCost_nr2] = cost_function(Isp1, Isp2, X(i), delta1, delta2);
    cost_stage1_arr(end+1) = stageCost_nr1;
    cost_stage2_arr(end+1) = stageCost_nr2;
end

% Add the two arrays to get an array of the total cost
total_cost = cost_stage1_arr + cost_stage2_arr;

% Find the minimum gross mass, similar to min_cost_function, but save
% the associated X for the minimum total cost
min_cost = realmax;
for i = 1:length(total_cost)
    if ~isnan(total_cost(i)) && total_cost(i) < min_cost
        min_cost = total_cost(i);
        min_cost_X = X(i);
    end
end

% Plot mass of stage 1, mass of stage 2, and total mass in billions of dollars 
% as a function of X. Also plot as a point the minimum total cost
plot(X, cost_stage1_arr/1000)
hold on
plot(X, cost_stage2_arr/1000)
plot(X, total_cost/1000)
plot(min_cost_X, min_cost/1000, '.', MarkerSize=20)
ylim([0, 500])
legend("First Stage Cost", "Second Stage Cost", "Combined Launch Vehicle Cost")
xlabel("First Stage \DeltaV Fraction")
ylabel("Cost ($B2025)")
title("First Stage: LOX/LH2, Second Stage: Solid")

