function min_cost = min_cost_function(Isp1, Isp2, delta1, delta2)

    min_cost = realmax;
    for X = 0:0.01:1
        [stageCost_nr1, stageCost_nr2] = cost_function(Isp1, Isp2, X, delta1, delta2);
        total_cost = stageCost_nr1 + stageCost_nr2;
        if total_cost < min_cost
            min_cost = total_cost;
        end
    end

end