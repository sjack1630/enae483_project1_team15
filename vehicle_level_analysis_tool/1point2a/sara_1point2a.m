%Sara C 1.2a Code

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
    m_s1 = [];
    m_s2 = [];
    m_0 = [];
    min_gross_mass = realmax;

    for i = 1:length(X)
        %calling mass function to populate mass arrays
        [m_in1, m_in2, m_pr1, m_pr2, m0] = mass_function(Isp(isp), Isp_s2, X(i), delta1, delta2);
        m_s1 = [m_s1 (m_pr1 + m_in1)];
        m_s2 = [m_s2 (m_pr2 + m_in2)];
        m_0 = [m_0 m0];

        %min gross mass function - returns the x,y minimum of the m_0 array
        if m_s1(i) > 0 && m_s2(i) > 0 && m_0(i) < min_gross_mass
            min_gross_mass = m_0(i); %convert to metric tons
            x_min = X(i);
            
        end
    end
    
    %kg to metric tons
    m_s1 = m_s1/1000; 
    m_s2 = m_s2/1000;
    m_0 = m_0/1000;
    min_gross_mass = min_gross_mass/1000;

    %output - min mass and corresponding deltaV
    fprintf('Stage 1 Isp = %d s --> Optimum at X = %.3f, Min Gross Mass = %.2f metric tons\n', Isp(isp), x_min, min_gross_mass);

    %plotting
    plot(X, m_s1);
    hold on;
    plot(X, m_s2);
    plot(X, m_0);
    plot(x_min, min_gross_mass, '.', MarkerSize=20);
    ylim([0, 1e4]);
    title(sprintf('Stage 1 Isp = %d s', Isp(isp)))
    legend("First Stage Mass", "Second Stage Mass", "Gross Vehicle Mass")
    xlabel("Delta V Fraction");
    ylabel("Mass (metric tons)")
    hold off;
    
    pause;
end
    


