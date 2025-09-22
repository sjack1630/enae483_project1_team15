function [min_X, min_cost] = min_cost_function(Isp1, Isp2, delta1, delta2)
    % Returns the minimum cost given specific impulse of stage 1,
    % specific impulse of stage 2, and delV fraction (delta1, delta2 are
    % assumed to be 0.08)

    % Find minimum cost by iteratively calling cost_function and comparing
    % total cost for each X
    min_cost = realmax;
    for X = 0:0.001:1
        [stageCost_nr1, stageCost_nr2] = cost_function(Isp1, Isp2, X, delta1, delta2);
        total_cost = stageCost_nr1 + stageCost_nr2;
        if total_cost < min_cost
            min_cost = total_cost;
            min_X = X;
        end
    end
end