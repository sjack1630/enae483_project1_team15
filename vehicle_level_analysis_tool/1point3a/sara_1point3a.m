%Sara C 1.3a Code
%cost analysis

%Looking at mixture of:
%Stage 2: LOX/LH2
%Varied Stage 1: LOX/LCH4, LOX/LH2, LOX/RP1, Solid, Storables

%Variables & Given Parameters
delta1 = 0.08;
delta2 = 0.08;
payload = 26000; %kg
%Specific Impulse
Isp_s2 = 366; %stage 2 
%LCH4, LH2, RP1, solids, storables
Isp = [327, 366, 311, 269, 285]; %stage 1 varies


%initialize X (this is delta_V ratio/fraction)
X=0:0.001:1;

for isp = 1:length(Isp)
    %mass arrays
    cost_s1 = [];
    cost_s2 = [];
    cost_tot = [];
    min_gross_cost = realmax;

    for i = 1:length(X)
        %calling mass function to populate mass arrays
        [stageCost_nr1, stageCost_nr2] = cost_function(Isp(isp), Isp_s2, X(i), delta1, delta2);
        cost_s1 = [cost_s1 stageCost_nr1];
        cost_s2 = [cost_s2 stageCost_nr2];
        cost_tot = [cost_tot (stageCost_nr1 + stageCost_nr2)];

        %min gross mass function - returns the x,y minimum of the m_0 array
        if cost_s1(i) > 0 && cost_s2(i) > 0 && cost_tot(i) < min_gross_cost
            min_gross_cost = cost_tot(i); %convert to metric tons
            x_min = X(i);
        end
    end
    
    %millions to billions
    cost_s1 = cost_s1/1000; 
    cost_s2 = cost_s2/1000;
    cost_tot = cost_tot/1000;
    min_gross_cost = min_gross_cost/1000;

    %output - min cost and corresponding deltaV
    fprintf('Stage 1 Isp = %d s --> Optimum at X = %.3f, Min Gross Cost = %.2f $B2025 \n', Isp(isp), x_min, min_gross_cost);

    %plotting
    plot(X, cost_s1);
    hold on;
    plot(X, cost_s2);
    plot(X, cost_tot);
    plot(x_min, min_gross_cost, '.', MarkerSize=20);
    ylim([0, 80]);
    title(sprintf('Stage 1 Isp = %d s', Isp(isp)));
    legend("First Stage Cost", "Second Stage Cost", "Gross Vehicle Cost")
    xlabel("Delta V Fraction");
    ylabel("Cost ($B2025)")
    hold off;
    
    pause;
end