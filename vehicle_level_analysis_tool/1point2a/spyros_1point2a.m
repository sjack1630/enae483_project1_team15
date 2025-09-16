% LOX/RP1 row
% combo: first prop: LOX/LCH4, second prop: LOX/RPI
addpath('..')

% Set constants based on requirements and propellant combination
delta1 = 0.08;
delta2 = 0.08;
Isp1 = 327;
Isp2 = 311;
m_pl = 26000;

% Initialize/populate arrays
X = 0:0.001:1;
m_stage1_arr = [];
m_stage2_arr = [];
m0_arr = [];

% For each X value, call mass_function and populate the arrays for mass of
% stage 1, mass of stage 2, and total mass
for i = 1:length(X)
    [m_in1, m_in2, m_pr1, m_pr2, m0] = mass_function(Isp1, Isp2, X(i), delta1, delta2);
    m_stage1_arr(end+1) = m_in1 + m_pr1;
    m_stage2_arr(end+1) = m_in2 + m_pr2;
    m0_arr(end+1) = m0;
end

% Find the minimum gross mass, similar to min_gross_mass_function, but save
% the associated X for the minimum gross mass
min_m0 = realmax;
for i = 1:length(m0_arr)
    if m_stage1_arr(i) > 0 && m_stage2_arr(i) > 0 && m0_arr(i) < min_m0
        min_m0 = m0_arr(i);
        min_m0_X = X(i);
    end
end

% Plot mass of stage 1, mass of stage 2, and total mass in metric tons 
% as a function of X. Also plot as a point the minimum gross mass
plot(X, m_stage1_arr/1000)
hold on
plot(X, m_stage2_arr/1000)
plot(X, m0_arr/1000)
plot(min_m0_X, min_m0/1000, '.', MarkerSize=20)
ylim([0, 1e4])
legend("First Stage Mass", "Second Stage Mass", "Gross Vehicle Mass")
xlabel("First Stage \DeltaV Fraction")
ylabel("Mass (t)")

