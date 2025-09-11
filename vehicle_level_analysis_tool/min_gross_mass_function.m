function [min_gross_mass] = min_gross_mass_function(Isp1, Isp2, delta1, delta2)

    min_gross_mass = realmax;
    for X = 0:0.01:1
        [m_1, m_2, m_pr1, m_pr2] = mass_function(Isp1, Isp2, X, delta1, delta2);
        if m_1 < min_gross_mass
            min_gross_mass = m_1;
        end
    end

end