% solids row
% combo: first prop: LOX/LH2, second prop: solid

delta1 = 0.08;
delta2 = 0.08;
Isp1 = 366;
Isp2 = 269;
m_pl = 26000;
X = 0:0.001:1;
m_stage1_arr = [];
m_stage2_arr = [];

for i = 1:length(X)
    [m_in1, m_in2, m_pr1, m_pr2] = mass_function(Isp1, Isp2, X(i), delta1, delta2);
    m_stage1_arr(end+1) = m_in1 + m_pr1;
    m_stage2_arr(end+1) = m_in2 + m_pr2;
end

m0_arr = m_stage1_arr + m_stage2_arr + m_pl;

min_m0 = realmax;
for i = 1:length(m0)
    if m_stage1_arr(i) > 0 && m_stage2_arr(i) > 0 && m0_arr(i) < min_m0
        min_m0 = m0_arr(i);
        min_m0_X = X(i);
    end
end

plot(X, m_stage1_arr/1000)
hold on
plot(X, m_stage2_arr/1000)
plot(X, m0/1000)
plot(min_m0_X, min_m0/1000, '.', MarkerSize=20)
ylim([-100, 1e4])
legend("First Stage Mass", "Second Stage Mass", "Gross Vehicle Mass")
xlabel("First Stage \DeltaV Fraction")
ylabel("Mass (t)")
title("First Stage: LOX/LH2, Second Stage: Solid")

