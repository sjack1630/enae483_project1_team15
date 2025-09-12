function [m_in1, m_in2, m_pr1, m_pr2] = mass_function(Isp1, Isp2, X, delta1, delta2)
    deltaV_tot = 12300; % m/s
    g0 = 9.81; % m/s^2
    m_pl = 26000; % kg

    deltaV1 = X*deltaV_tot;
    deltaV2 = (1-X)*deltaV_tot;

    R1 = exp(deltaV1/(g0*Isp1));
    R2 = exp(deltaV2/(g0*Isp2));

    m_2 = R2*m_pl/(1 - R2*delta2);
    m_1 = R1*m_2/(1 - R1*delta1);

    m_in1 = delta1*m_1;
    m_in2 = delta2*m_2;

    m_f1 = m_1/R1;
    m_f2 = m_2/R2;

    m_pr1 = m_1 - m_in1 - m_2;
    m_pr2 = m_2 - m_pl - m_in2;

end