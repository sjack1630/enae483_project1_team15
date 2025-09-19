solid = readmatrix('solid.csv', 'ThousandsSeparator', ',');
RP1 = readmatrix('RP1.csv', 'ThousandsSeparator', ',');
LCH4 = readmatrix('LCH4.csv', 'ThousandsSeparator', ',');
LH2 = readmatrix('LH2.csv', 'ThousandsSeparator', ',');
storable = readmatrix('storable.csv', 'ThousandsSeparator', ',');

LH2_min_mass_MASS_solid  = solid(1,2);
LH2_min_mass_COST_solid  = solid(2,2);
LH2_min_cost_COST_solid  = solid(3,2);
LH2_min_cost_MASS_solid  = solid(4,2);

LH2_min_mass_MASS_RP1 = RP1(1,2);
LH2_min_mass_COST_RP1 = RP1(2,2);
LH2_min_cost_COST_RP1 = RP1(3,2);
LH2_min_cost_MASS_RP1 = RP1(4,2);

LH2_min_mass_MASS_LCH4 = LCH4(1,2);
LH2_min_mass_COST_LCH4 = LCH4(2,2);
LH2_min_cost_COST_LCH4 = LCH4(3,2);
LH2_min_cost_MASS_LCH4 = LCH4(4,2);

LH2_min_mass_MASS_LH2 = LH2(1,2);
LH2_min_mass_COST_LH2 = LH2(2,2);
LH2_min_cost_COST_LH2 = LH2(3,2);
LH2_min_cost_MASS_LH2 = LH2(4,2);

LH2_min_mass_MASS_storable = storable(1,2);
LH2_min_mass_COST_storable = storable(2,2);
LH2_min_cost_COST_storable = storable(3,2);
LH2_min_cost_MASS_storable = storable(4,2);

figure;
plot(LH2_min_mass_MASS_solid, LH2_min_mass_COST_solid, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')
hold on
plot(LH2_min_cost_MASS_solid, LH2_min_cost_COST_solid, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')

plot(LH2_min_mass_MASS_RP1, LH2_min_mass_COST_RP1, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)
plot(LH2_min_cost_MASS_RP1, LH2_min_cost_COST_RP1, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)

plot(LH2_min_mass_MASS_LCH4, LH2_min_mass_COST_LCH4, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')
plot(LH2_min_cost_MASS_LCH4, LH2_min_cost_COST_LCH4, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')

plot(LH2_min_mass_MASS_LH2, LH2_min_mass_COST_LH2, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)
plot(LH2_min_cost_MASS_LH2, LH2_min_cost_COST_LH2, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)

plot(LH2_min_mass_MASS_storable, LH2_min_mass_COST_storable, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)
plot(LH2_min_cost_MASS_storable, LH2_min_cost_COST_storable, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)

red = plot(nan, nan, 'o', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r', 'MarkerSize', 10);
blue = plot(nan, nan, 'o', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b', 'MarkerSize', 10);
green = plot(nan, nan, 'o', 'MarkerFaceColor', [0 52 0]/255, 'MarkerEdgeColor', [0 52 0]/255, 'MarkerSize', 10);
orange = plot(nan, nan, 'o', 'MarkerFaceColor', [255 153 51]/255, 'MarkerEdgeColor', [255 153 51]/255, 'MarkerSize', 10);
purple = plot(nan, nan, 'o', 'MarkerFaceColor', [204 0 204]/255, 'MarkerEdgeColor', [204 0 204]/255, 'MarkerSize', 10);

circle = plot(nan, nan, 'o', 'Color', 'k', 'MarkerSize', 10);
star = plot(nan, nan, '*', 'Color', 'k', 'MarkerSize', 10);
x = plot(nan, nan, 'x', 'Color', 'k', 'MarkerSize', 10);
diamond = plot(nan, nan, 'diamond', 'Color', 'k', 'MarkerSize', 10);
triangle = plot(nan, nan, '^', 'Color', 'k', 'MarkerSize', 10); 

legend([circle, star, x, diamond, triangle, blue, purple, green, red, orange], 'First Stage: LOX/LCH4', 'First Stage: LOX/LH2', 'First Stage: LOX/RP1', 'First Stage: Solid', 'First Stage: Storables', 'Second Stage: LOX/LCH4', 'Second Stage: LOX/LH2', 'Second Stage: LOX/RP1', 'Second Stage: Solid', 'Second Stage: Storables')

xlabel('Mass (t)')
ylabel('Cost ($B2025)')
title('Minimum Cost and Minimum Mass Propellant Mix Designs')
grid on
