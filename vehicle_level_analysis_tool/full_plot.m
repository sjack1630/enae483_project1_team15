solid = readmatrix('solid.csv', 'ThousandsSeparator', ',');
RP1 = readmatrix('RP1.csv', 'ThousandsSeparator', ',');
LCH4 = readmatrix('LCH4.csv', 'ThousandsSeparator', ',');
LH2 = readmatrix('LH2.csv', 'ThousandsSeparator', ',');
storable = readmatrix('storable.csv', 'ThousandsSeparator', ',');

LCH4_min_mass_MASS_solid = solid(1,1);
LH2_min_mass_MASS_solid  = solid(1,2);
RP1_min_mass_MASS_solid  = solid(1,3);
solid_min_mass_MASS_solid  = solid(1,4);
storable_min_mass_MASS_solid  = solid(1,5);

LCH4_min_mass_COST_solid  = solid(2,1);
LH2_min_mass_COST_solid  = solid(2,2);
RP1_min_mass_COST_solid  = solid(2,3);
solid_min_mass_COST_solid  = solid(2,4);
storable_min_mass_COST_solid  = solid(2,5);

LCH4_min_cost_COST_solid  = solid(3,1);
LH2_min_cost_COST_solid  = solid(3,2);
RP1_min_cost_COST_solid  = solid(3,3);
solid_min_cost_COST_solid  = solid(3,4);
storable_min_cost_COST_solid  = solid(3,5);

LCH4_min_cost_MASS_solid  = solid(4,1);
LH2_min_cost_MASS_solid  = solid(4,2);
RP1_min_cost_MASS_solid  = solid(4,3);
solid_min_cost_MASS_solid  = solid(4,4);
storable_min_cost_MASS_solid  = solid(4,5);

LCH4_min_mass_MASS_RP1 = RP1(1,1);
LH2_min_mass_MASS_RP1 = RP1(1,2);
RP1_min_mass_MASS_RP1 = RP1(1,3);
solid_min_mass_MASS_RP1 = RP1(1,4);
storable_min_mass_MASS_RP1 = RP1(1,5);

LCH4_min_mass_COST_RP1 = RP1(2,1);
LH2_min_mass_COST_RP1 = RP1(2,2);
RP1_min_mass_COST_RP1 = RP1(2,3);
solid_min_mass_COST_RP1 = RP1(2,4);
storable_min_mass_COST_RP1 = RP1(2,5);

LCH4_min_cost_COST_RP1 = RP1(3,1);
LH2_min_cost_COST_RP1 = RP1(3,2);
RP1_min_cost_COST_RP1 = RP1(3,3);
solid_min_cost_COST_RP1 = RP1(3,4);
storable_min_cost_COST_RP1 = RP1(3,5);

LCH4_min_cost_MASS_RP1 = RP1(4,1);
LH2_min_cost_MASS_RP1 = RP1(4,2);
RP1_min_cost_MASS_RP1 = RP1(4,3);
solid_min_cost_MASS_RP1 = RP1(4,4);
storable_min_cost_MASS_RP1 = RP1(4,5);

LCH4_min_mass_MASS_LCH4 = LCH4(1,1);
LH2_min_mass_MASS_LCH4 = LCH4(1,2);
RP1_min_mass_MASS_LCH4 = LCH4(1,3);
solid_min_mass_MASS_LCH4 = LCH4(1,4);
storable_min_mass_MASS_LCH4 = LCH4(1,5);

LCH4_min_mass_COST_LCH4 = LCH4(2,1);
LH2_min_mass_COST_LCH4 = LCH4(2,2);
RP1_min_mass_COST_LCH4 = LCH4(2,3);
solid_min_mass_COST_LCH4 = LCH4(2,4);
storable_min_mass_COST_LCH4 = LCH4(2,5);

LCH4_min_cost_COST_LCH4 = LCH4(3,1);
LH2_min_cost_COST_LCH4 = LCH4(3,2);
RP1_min_cost_COST_LCH4 = LCH4(3,3);
solid_min_cost_COST_LCH4 = LCH4(3,4);
storable_min_cost_COST_LCH4 = LCH4(3,5);

LCH4_min_cost_MASS_LCH4 = LCH4(4,1);
LH2_min_cost_MASS_LCH4 = LCH4(4,2);
RP1_min_cost_MASS_LCH4 = LCH4(4,3);
solid_min_cost_MASS_LCH4 = LCH4(4,4);
storable_min_cost_MASS_LCH4 = LCH4(4,5);

LCH4_min_mass_MASS_LH2 = LH2(1,1);
LH2_min_mass_MASS_LH2 = LH2(1,2);
RP1_min_mass_MASS_LH2 = LH2(1,3);
solid_min_mass_MASS_LH2 = LH2(1,4);
storable_min_mass_MASS_LH2 = LH2(1,5);

LCH4_min_mass_COST_LH2 = LH2(2,1);
LH2_min_mass_COST_LH2 = LH2(2,2);
RP1_min_mass_COST_LH2 = LH2(2,3);
solid_min_mass_COST_LH2 = LH2(2,4);
storable_min_mass_COST_LH2 = LH2(2,5);

LCH4_min_cost_COST_LH2 = LH2(3,1);
LH2_min_cost_COST_LH2 = LH2(3,2);
RP1_min_cost_COST_LH2 = LH2(3,3);
solid_min_cost_COST_LH2 = LH2(3,4);
storable_min_cost_COST_LH2 = LH2(3,5);

LCH4_min_cost_MASS_LH2 = LH2(4,1);
LH2_min_cost_MASS_LH2 = LH2(4,2);
RP1_min_cost_MASS_LH2 = LH2(4,3);
solid_min_cost_MASS_LH2 = LH2(4,4);
storable_min_cost_MASS_LH2 = LH2(4,5);

LCH4_min_mass_MASS_storable = storable(1,1);
LH2_min_mass_MASS_storable = storable(1,2);
RP1_min_mass_MASS_storable = storable(1,3);
solid_min_mass_MASS_storable = storable(1,4);
storable_min_mass_MASS_storable = storable(1,5);

LCH4_min_mass_COST_storable = storable(2,1);
LH2_min_mass_COST_storable = storable(2,2);
RP1_min_mass_COST_storable = storable(2,3);
solid_min_mass_COST_storable = storable(2,4);
storable_min_mass_COST_storable = storable(2,5);

LCH4_min_cost_COST_storable = storable(3,1);
LH2_min_cost_COST_storable = storable(3,2);
RP1_min_cost_COST_storable = storable(3,3);
solid_min_cost_COST_storable = storable(3,4);
storable_min_cost_COST_storable = storable(3,5);

LCH4_min_cost_MASS_storable = storable(4,1);
LH2_min_cost_MASS_storable = storable(4,2);
RP1_min_cost_MASS_storable = storable(4,3);
solid_min_cost_MASS_storable = storable(4,4);
storable_min_cost_MASS_storable = storable(4,5);


figure;
plot(LCH4_min_mass_MASS_solid, LCH4_min_mass_COST_solid, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')
hold on
plot(LCH4_min_cost_MASS_solid, LCH4_min_cost_COST_solid, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')

plot(LH2_min_mass_MASS_solid, LH2_min_mass_COST_solid, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')
plot(LH2_min_cost_MASS_solid, LH2_min_cost_COST_solid, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')

plot(RP1_min_mass_MASS_solid, RP1_min_mass_COST_solid, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')
plot(RP1_min_cost_MASS_solid, RP1_min_cost_COST_solid, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')

plot(solid_min_mass_MASS_solid, solid_min_mass_COST_solid, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')
plot(solid_min_cost_MASS_solid, solid_min_cost_COST_solid, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')

plot(storable_min_mass_MASS_solid, storable_min_mass_COST_solid, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')
plot(storable_min_cost_MASS_solid, storable_min_cost_COST_solid, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'r')


plot(LCH4_min_mass_MASS_RP1, LCH4_min_mass_COST_RP1, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)
plot(LCH4_min_cost_MASS_RP1, LCH4_min_cost_COST_RP1, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)

plot(LH2_min_mass_MASS_RP1, LH2_min_mass_COST_RP1, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)
plot(LH2_min_cost_MASS_RP1, LH2_min_cost_COST_RP1, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)

plot(RP1_min_mass_MASS_RP1, RP1_min_mass_COST_RP1, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)
plot(RP1_min_cost_MASS_RP1, RP1_min_cost_COST_RP1, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)

plot(solid_min_mass_MASS_RP1, solid_min_mass_COST_RP1, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)
plot(solid_min_cost_MASS_RP1, solid_min_cost_COST_RP1, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)

plot(storable_min_mass_MASS_RP1, storable_min_mass_COST_RP1, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)
plot(storable_min_cost_MASS_RP1, storable_min_cost_COST_RP1, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [0 52 0]/255)

plot(LCH4_min_mass_MASS_LCH4, LCH4_min_mass_COST_LCH4, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')
plot(LCH4_min_cost_MASS_LCH4, LCH4_min_cost_COST_LCH4, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')

plot(LH2_min_mass_MASS_LCH4, LH2_min_mass_COST_LCH4, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')
plot(LH2_min_cost_MASS_LCH4, LH2_min_cost_COST_LCH4, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')

plot(RP1_min_mass_MASS_LCH4, RP1_min_mass_COST_LCH4, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')
plot(RP1_min_cost_MASS_LCH4, RP1_min_cost_COST_LCH4, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')

plot(solid_min_mass_MASS_LCH4, solid_min_mass_COST_LCH4, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')
plot(solid_min_cost_MASS_LCH4, solid_min_cost_COST_LCH4, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')

plot(storable_min_mass_MASS_LCH4, storable_min_mass_COST_LCH4, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')
plot(storable_min_cost_MASS_LCH4, storable_min_cost_COST_LCH4, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b')

plot(LCH4_min_mass_MASS_LH2, LCH4_min_mass_COST_LH2, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)
plot(LCH4_min_cost_MASS_LH2, LCH4_min_cost_COST_LH2, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)

plot(LH2_min_mass_MASS_LH2, LH2_min_mass_COST_LH2, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)
plot(LH2_min_cost_MASS_LH2, LH2_min_cost_COST_LH2, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)

plot(RP1_min_mass_MASS_LH2, RP1_min_mass_COST_LH2, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)
plot(RP1_min_cost_MASS_LH2, RP1_min_cost_COST_LH2, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)

plot(solid_min_mass_MASS_LH2, solid_min_mass_COST_LH2, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)
plot(solid_min_cost_MASS_LH2, solid_min_cost_COST_LH2, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)

plot(storable_min_mass_MASS_LH2, storable_min_mass_COST_LH2, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)
plot(storable_min_cost_MASS_LH2, storable_min_cost_COST_LH2, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [204 0 204]/255)

plot(LCH4_min_mass_MASS_storable, LCH4_min_mass_COST_storable, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)
plot(LCH4_min_cost_MASS_storable, LCH4_min_cost_COST_storable, 'o', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)

plot(LH2_min_mass_MASS_storable, LH2_min_mass_COST_storable, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)
plot(LH2_min_cost_MASS_storable, LH2_min_cost_COST_storable, '*', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)

plot(RP1_min_mass_MASS_storable, RP1_min_mass_COST_storable, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)
plot(RP1_min_cost_MASS_storable, RP1_min_cost_COST_storable, 'x', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)

plot(solid_min_mass_MASS_storable, solid_min_mass_COST_storable, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)
plot(solid_min_cost_MASS_storable, solid_min_cost_COST_storable, 'diamond', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)

plot(storable_min_mass_MASS_storable, storable_min_mass_COST_storable, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)
plot(storable_min_cost_MASS_storable, storable_min_cost_COST_storable, '^', 'MarkerSize', 15, 'LineWidth', 2, 'Color', [255 153 51]/255)

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
