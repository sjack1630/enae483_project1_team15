function [min_gross_mass] = min_gross_mass_function(Isp1, Isp2, delta1, delta2)

    m_pl = 26000;
    min_gross_mass = realmax;
    for X = 0:0.01:1
        [m_in1, m_in2, m_pr1, m_pr2] = mass_function(Isp1, Isp2, X, delta1, delta2);
        curr_m0 = m_in1 + m_in2 + m_pr1 + m_pr2 + m_pl;
        if curr_m0 < min_gross_mass
            min_gross_mass = curr_m0;
        end
    end

end