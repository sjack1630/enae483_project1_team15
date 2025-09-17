function [min_X, min_gross_mass] = min_gross_mass_function(Isp1, Isp2, delta1, delta2)
    % Returns the minimum gross mass given specific impulse of stage 1,
    % and specific impulse of stage 2 (delta1, delta2 are
    % assumed to be 0.08)

    % Initialize minimum gross mass
    min_gross_mass = realmax;

    % Find minimum gross mass by iteratively calling mass_function and comparing
    % gross mass for each X
    for X = 0:0.001:1
        [m_in1, m_in2, m_pr1, m_pr2, m0] = mass_function(Isp1, Isp2, X, delta1, delta2);
        if m0 < min_gross_mass
            min_gross_mass = m0;
            min_X = X;
        end
    end

end