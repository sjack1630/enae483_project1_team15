function [stageCost_nr1, stageCost_nr2] = cost_function(Isp1, Isp2, X, delta1, delta2)
    % Returns the total cost given specific impulse of stage 1,
    % specific impulse of stage 2, and delV fraction (delta1, delta2 are
    % assumed to be 0.08)

    % Call mass function to get the inert masses of stage 1 and 2 for the 
    % cost equation, then add the two stage costs together
    [m_in1, m_in2, m_pr1, m_pr2, m0] = mass_function(Isp1, Isp2, X, delta1, delta2);
    stageCost_nr1 = 13.52*m_in1^0.55;
    stageCost_nr2 = 13.52*m_in2^0.55;

end