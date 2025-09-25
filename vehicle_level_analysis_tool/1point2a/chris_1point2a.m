% TP 1
% Chris Witherspoon
% 1.2

addpath('..')

% Delta constants
d1 = 0.08 ;
d2 = 0.08 ;

% Specific impulse (storables)
isp = 285 ;
isp_comp = 285 ; % Second

% Payload mass
mpl = 26000 ;

% X variable array
x = 0:0.001:1 ;

% Stage arrays initializations
first_stage = [] ;
second_stage = [] ;
tot_mass = [] ;

% Array population
i = 1 ; % initialize the variable to loop
while i <= length(x)
    [min1, min2, mpr1, mpr2, m0] = mass_function(isp, isp_comp, x(i), d1, d2);
    first_stage(end+1) = min1 + mpr1 ;
    second_stage(end+1) = min2 + mpr2 ;
    tot_mass(end+1) = m0 ;
    i = i + 1 ;
end

% Value placeholder for the mass
min_m0 = realmax ;
min_mox = NaN ;
% Check the min value
i = 1 ; %
while  i <= length(x)
    if first_stage(i) > 0 && second_stage(i) > 0 && tot_mass(i) < min_m0 
        min_m0 = tot_mass(i) ;
        min_mox = x(i) ;
    end
    i = i + 1 ;
end

% Plotting the graph
plot(x,first_stage/1000) ;
hold on ;
grid on ;
title("Storables then LOX/LCH4")
plot(x, second_stage/1000) ;
plot(x, tot_mass/1000) ;
plot(min_mox, min_m0/1000, '.', MarkerSize = 20) ;
legend('Stage 1 Mass','Stage 2 Mass','Total Mass','Minimum Mass','Location','best');
ylim([0, 1e4]) ;
xlabel("First Stage") ;
ylabel("Mass") ;