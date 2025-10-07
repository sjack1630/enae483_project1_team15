function [stage1_total_mass, stage1_height] = get_stage1_mass(first_stage, M_p, M_0, stage2_total_mass, num_engines, init)
    
    % Set density constants
    rho_LH2 = 71;
    rho_LOX = 1140;
    rho_RP1 = 820;
    rho_LCH4 = 423;
    rho_solid = 1680;
    rho_N2O4 = 1442;
    rho_UDMH = 791;
    
    % Set tank constants
    radius = 6.4; % m
    cap_height = 1; % m
    payload_cone_height = 10; % m
    payload_cyl_height = 10; % m
    engine_space = 3; % m
    
    % Constants that depend on propellant choice
    if first_stage == "LCH4"
        stage1_ratio = 3.6;
        stage1_oxidizer_rho = rho_LOX;
        stage1_fuel_rho = rho_LCH4;
        stage1_thrust_single = 2.26e6; % N
        stage1_nozzle_exp = 34.34;
        chamber_pressure_1 = 35.16e6; % Pa
    elseif first_stage == "LH2"
        stage1_ratio = 6.03;
        stage1_oxidizer_rho = rho_LOX;
        stage1_fuel_rho = rho_LH2;
        stage1_thrust_single = 1.86e6; % N
        stage1_nozzle_exp = 78;
        chamber_pressure_1 = 20.64e6; % Pa
    elseif first_stage == "RP1"
        stage1_ratio = 2.72;
        stage1_oxidizer_rho = rho_LOX;
        stage1_fuel_rho = rho_RP1;
        stage1_thrust_single = 1.92e6; % N
        stage1_nozzle_exp = 37;
        chamber_pressure_1 = 25.8e6; % Pa
    elseif first_stage == "solid"
        stage1_thrust_single = 4.5e6; % N
        stage1_nozzle_exp = 16;
        chamber_pressure_1 = 10.5e6; % Pa
    elseif first_stage == "storables"
        stage1_ratio = 2.67;
        stage1_oxidizer_rho = rho_N2O4;
        stage1_fuel_rho = rho_UDMH;
        stage1_thrust_single = 1.75e6; % N
        stage1_nozzle_exp = 26.2;
        chamber_pressure_1 = 15.7e6; % Pa
    end
    
    % Set thrust according to number of engines
    if init
        stage1_thrust = stage1_thrust_single;
    else
        stage1_thrust = stage1_thrust_single*num_engines;
    end

    % Compute stage1 tank mass
    if first_stage == "solid"
        solid_volume = M_p/rho_solid;
        stage1_tank_mass = 12.16*solid_volume;
    else
        mass_split = M_p/(stage1_ratio+1);
        mass_oxidizer = stage1_ratio*mass_split;
        mass_fuel = mass_split;
        volume_oxidizer = mass_oxidizer/stage1_oxidizer_rho;
        volume_fuel = mass_fuel/stage1_fuel_rho;
        if first_stage == "LH2"
            stage1_tank_mass = 12.16*volume_oxidizer + 9.09*volume_fuel;
        else
            stage1_tank_mass = 12.16*(volume_oxidizer + volume_fuel);
        end
    end

    % Compute stage1 tank volume assuming cylinder and two sphere caps 1m
    % tall each
    if first_stage ~= "solid"
        ox_cap_vol = 2*(pi*cap_height)*(3*radius^2 + cap_height^2)/6;
        ox_cyl_vol = volume_oxidizer - ox_cap_vol;
        ox_cyl_height = ox_cyl_vol/(pi*radius^2);
        ox_cap_surf_area = 2*(pi*(radius^2 + cap_height^2));
        ox_cyl_surf_area = 2*pi*radius*ox_cyl_height;

        fuel_cap_vol = 2*(pi*cap_height)*(3*radius^2 + cap_height^2)/6;
        fuel_cyl_vol = volume_fuel - fuel_cap_vol;
        fuel_cyl_height = fuel_cyl_vol/(pi*radius^2);
        fuel_cap_surf_area = 2*(pi*(radius^2 + cap_height^2));
        fuel_cyl_surf_area = 2*pi*radius*fuel_cyl_height;
    end

    % Compute insulation from tank volume, edge cases for storables and
    % solids
    if first_stage ~= "solid" && first_stage ~= "storables"
        LOX_stage1_insulation_mass = 1.123*(ox_cap_surf_area + ox_cyl_surf_area);
        if first_stage == "LH2"
            LH2_stage1_insulation_mass = 2.88*(fuel_cap_surf_area + fuel_cyl_surf_area);
            stage1_insulation_mass = LOX_stage1_insulation_mass + LH2_stage1_insulation_mass;
        elseif first_stage == "LCH4"
            LCH4_stage1_insulation_mass = 1.123*(fuel_cap_surf_area + fuel_cyl_surf_area);
            stage1_insulation_mass = LOX_stage1_insulation_mass + LCH4_stage1_insulation_mass;
        else
            stage1_insulation_mass = LOX_stage1_insulation_mass;
        end
    elseif first_stage == "solid"
        stage1_insulation_mass = 0;
        solid_cap_vol = 2*(pi*cap_height)*(3*radius^2 + cap_height^2)/6;
        solid_cyl_vol = solid_volume - solid_cap_vol;
        solid_cyl_height = solid_cyl_vol/(pi*radius^2);
    else
        stage1_insulation_mass = 0;
    end

    % Set engine and casing mass, dependent on propellant
    if first_stage ~= "solid"
        stage1_engine_mass = 7.81e-4*stage1_thrust + 3.37e-5*stage1_thrust*sqrt(stage1_nozzle_exp) + 59;
        stage1_casing_mass = 0;
    else
        stage1_engine_mass = 0;
        stage1_casing_mass = 0.135*M_p;
    end

    % Compute payload and aft fairing areas
    interstage_fairing_area = 2*pi*radius*(engine_space + cap_height);
    aft2_fairing_area = 2*pi*radius*(engine_space + cap_height);

    interstage_fairing_mass = 4.95*interstage_fairing_area^(1.15);
    stage1_aft_fairing_mass = 4.95*aft2_fairing_area^(1.15);

    % Compute intertank fairing mass and overall height dependent on propellant
    if first_stage ~= "solid"    
        intertank2_fairing_area = 2*pi*radius*(2*cap_height);
        stage1_intertank_fairing_mass = 4.95*intertank2_fairing_area^(1.15);
        stage1_height = payload_cone_height + payload_cyl_height + 4*cap_height + ox_cyl_height + fuel_cyl_height + engine_space;
    else 
        stage1_intertank_fairing_mass = 0;
        stage1_height = payload_cone_height + payload_cyl_height + 2*cap_height + solid_cyl_height + engine_space;
    end

    % Compute wiring, thrust structure, and gimbals masses
    stage1_mass_wiring = 1.058*sqrt(M_0)*stage1_height^(0.25);

    stage1_mass_thrust_struct = 2.25e-4*stage1_thrust;

    stage1_mass_gimbals = 237.8*(stage1_thrust/chamber_pressure_1)^(0.9375);

    % Compute total mass
    stage1_total_mass = M_p + stage1_mass_wiring + stage1_tank_mass + stage1_insulation_mass + stage1_engine_mass + stage1_mass_thrust_struct + stage1_casing_mass + stage1_mass_gimbals + interstage_fairing_mass + stage1_intertank_fairing_mass + stage1_aft_fairing_mass + stage2_total_mass;
    
    % Assign workspace variables
    assignin('base', 'stage1_propellant_mass', M_p);
    assignin('base', 'stage1_tank_mass', stage1_tank_mass);
    assignin('base', 'stage1_mass_wiring', stage1_mass_wiring);
    assignin('base', 'stage1_insulation_mass', stage1_insulation_mass);
    assignin('base', 'stage1_engine_mass', stage1_engine_mass);
    assignin('base', 'stage1_mass_thrust_struct', stage1_mass_thrust_struct);
    assignin('base', 'stage1_casing_mass', stage1_casing_mass);
    assignin('base', 'stage1_mass_gimbals', stage1_mass_gimbals);
    assignin('base', 'interstage_fairing_mass', interstage_fairing_mass);
    assignin('base', 'stage1_intertank_fairing_mass', stage1_intertank_fairing_mass);
    assignin('base', 'stage1_aft_fairing_mass', stage1_aft_fairing_mass);

end