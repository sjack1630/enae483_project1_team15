function min_cost = min_cost_function(Isp1, Isp2, delta1, delta2)

    min_cost = realmax;
    for X = 0:0.01:1
        total_cost = cost_function(Isp1, Isp2, X, delta1, delta2);
        if total_cost < min_cost
            min_cost = total_cost;
        end
    end

end