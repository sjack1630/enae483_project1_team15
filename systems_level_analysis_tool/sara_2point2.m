
first_stage = "LH2"
second_stage = "LH2" 
X = 0.54;

[num_engines_stage1, num_engines_stage2, stage1_only_total_mass, stage2_only_total_mass, total_mass, total_height, stage1_T_to_W, stage2_T_to_W] = get_MER_total_mass(first_stage, second_stage, X)

fprintf('Number of engines (Stage 1): %.2f\n', num_engines_stage1);
fprintf('Number of engines (Stage 2): %.2f\n', num_engines_stage2);
fprintf('Stage 1 only total mass: %.2f kg\n', stage1_only_total_mass);
fprintf('Stage 2 only total mass: %.2f kg\n', stage2_only_total_mass);
fprintf('Total mass: %.2f kg\n', total_mass);
fprintf('Total height: %.2f m\n', total_height);
fprintf('Stage 1 Thrust-to-Weight ratio: %.3f\n', stage1_T_to_W);
fprintf('Stage 2 Thrust-to-Weight ratio: %.3f\n', stage2_T_to_W);