addpath('..')
% Fill the mass arrays
X = 0:0.01:1;
m1_arr = [];
m2_arr = [];
m0_arr = [];

% Constants based on the propellents chosen and requirements
Isp1 = 327;     %LOX/LCH4
Isp2 = 311;     %LOX/RP1
delta1 = 0.08;
delta2 = delta1;
mpl = 26000;

% For the X mass value call the "mass_function" and fill the arrays for mass
% stage 1, mass stage 2, and total mass
for i = 1:length(X)
    [m_in1, m_in2, m_pr1, m_pr2, m0] = mass_function(Isp1, Isp2, X(i), delta1, delta2);
    m1_arr(end+1) = m_in1 + m_pr1;
    m2_arr(end+1) = m_in2 + m_pr2;
    m0_arr(end+1) = m0;
end

% Find the minimum gross mass, similar to min_gross_mass_function, but save
% the associated X for the minimum gross mass
min_m0 = realmax;
for i = 1:length(m0_arr)
    if m1_arr(i) > 0 && m2_arr(i) > 0 && m0_arr(i) < min_m0
        min_m0 = m0_arr(i);
        min_m0_X = X(i);
    end
end

% Plot mass stage 1, mass stage 2, and total mass in metric tons 
% as a function of X. Plot minimum gross mass as a point on the graph
plot(X, m1_arr/1000, "Linewidth", 4)
hold on
plot(X, m2_arr/1000, "Linewidth", 4)
plot(X, m0_arr/1000, "Linewidth", 4)
plot(min_m0_X, min_m0/1000, '*', "LineWidth", 4, MarkerSize=30)
ylim([0, 1e4])
legend("1st Stage Mass", "2nd Stage Mass", "Total Mass", "FontSize", 20, "Location", "southwest")
xlabel("First Stage DeltaV Fraction", "FontSize", 20)
ylabel("Mass (metric tons)", "FontSize", 20)
title("1st Stage: LOX/LCH4, 2nd Stage: LOX/RP1", "FontSize", 20)
