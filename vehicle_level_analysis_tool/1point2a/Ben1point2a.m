% I have the LOX/LCH4 second stage row
% the first stage I am selecting is LOX/LH2 and the 
% second stage is LOX/LCH4
addpath('..')
% given Constants 
Delta_1 = 0.08;
Delta_2 = 0.08;
Isp_1 = 327;
Isp_2 = 327;
m_PL = 26000;

% the range of x from 0 to 1 at 0.01 intervals and the
% number of x values we will have
X = 0:0.001:1;
X_length = 1001;

% the arrays
X_array = zeros(1,X_length);
M_stage1 = zeros(1,X_length);
M_stage2 = zeros(1,X_length);
M_total = zeros(1,X_length);

% filling the arrays
S = 1;
while S <= X_length
    X_Position = X(S);
    % call mass function from 1.1
    [m_in1, m_in2, m_pr1, m_pr2, m0] = mass_function(Isp_1, Isp_2, X_Position, Delta_1, Delta_2);
    % defind and populate the arrays from these values
    M_stage1(S) = m_in1 + m_pr1; 
    M_stage2(S) = m_in2 + m_pr2; 
    M_total(S) = m0; 
    S = S + 1; 
end

% finding the minimum gross mass 
Minimum_M0 = inf;
Minimum_M0X = NaN;

S = 2;
while S <= X_length
    if (M_stage1(S) > 0) && (M_stage2(S) > 0) && (M_total(S) < Minimum_M0)
        Minimum_M0 = M_total(S);
        Minimum_M0X = X(S);
    end
    S = S + 1;
end

% Converting to metric tons

M_stage1 = M_stage1 / 1000;
M_stage2 = M_stage2 / 1000;
M_total = M_total / 1000;
Minimum_M0 = Minimum_M0 / 1000;

% making the plots
plot(X, M_stage1);
hold on;
plot(X, M_stage2);
plot(X, M_total);
plot(Minimum_M0X, Minimum_M0, '.', 'MarkerSize',20)
ylim([0,1e4]);
xlabel('X value');
ylabel('Mass (Metric Tons)');
title('Mass of Stages vs. X value');
legend('Stage 1 Mass', 'Stage 2 Mass', 'Total Mass');
grid on;
