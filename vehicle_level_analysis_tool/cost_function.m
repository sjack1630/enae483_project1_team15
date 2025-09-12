function [stageCost_nr1, stageCost_nr2] = cost_function(Isp1, Isp2, X, delta1, delta2)

    [m_in1, m_in2, m_pr1, m_pr2] = mass_function(Isp1, Isp2, X, delta1, delta2);
    stageCost_nr1 = 13.52*m_in1^0.55;
    stageCost_nr2 = 13.52*m_in2^0.55;

end