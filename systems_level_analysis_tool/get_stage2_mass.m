function [stage2_total_mass, stage2_height] = get_stage2_mass(second_stage, M_p, M_0, num_engines, init)
    
    rho_LH2 = 71;
    rho_LOX = 1140;
    rho_RP1 = 820;
    rho_LCH4 = 423;
    rho_solid = 1680;
    rho_N2O4 = 1442;
    rho_UDMH = 791;
    
    M_l = 26000; % kg
    radius = 6; % m
    cap_height = 1; % m
    payload_cone_height = 10; % m
    payload_cyl_height = 10; % m
    engine_space = 3; % m
    
    if second_stage == "LCH4"
        stage2_ratio = 3.6;
        stage2_oxidizer_rho = rho_LOX;
        stage2_fuel_rho = rho_LCH4;
        stage2_thrust_single = 0.745e6; % N
        stage2_nozzle_exp = 45;
        chamber_pressure_2 = 10.1e6; % Pa
    elseif second_stage == "LH2"
        stage2_ratio = 6.03;
        stage2_oxidizer_rho = rho_LOX;
        stage2_fuel_rho = rho_LH2;
        stage2_thrust_single = 0.099e6; % N
        stage2_nozzle_exp = 84;
        chamber_pressure_2 = 4.2e6; % Pa
    elseif second_stage == "RP1"
        stage2_ratio = 2.72;
        stage2_oxidizer_rho = rho_LOX;
        stage2_fuel_rho = rho_RP1;
        stage2_thrust_single = 0.061e6; % N
        stage2_nozzle_exp = 14.5;
        chamber_pressure_2 = 6.77e6; % Pa
    elseif second_stage == "solid"
        stage2_thrust_single = 2.94e6; % N
        stage2_nozzle_exp = 56;
        chamber_pressure_2 = 5e6; % Pa
    elseif second_stage == "storables"
        stage2_ratio = 2.67;
        stage2_oxidizer_rho = rho_N2O4;
        stage2_fuel_rho = rho_UDMH;
        stage2_thrust_single = 0.067e6; % N
        stage2_nozzle_exp = 81.3;
        chamber_pressure_2 = 14.7e6; % Pa
    end
    
    if init
        stage2_thrust = stage2_thrust_single;
    else
        stage2_thrust = stage2_thrust_single*num_engines;
    end

    if second_stage == "solid"
        solid_volume = M_p/rho_solid;
        stage2_tank_mass = 12.16*solid_volume;
    else
        mass_split = M_p/(stage2_ratio+1);
        mass_oxidizer = stage2_ratio*mass_split;
        mass_fuel = mass_split;
        volume_oxidizer = mass_oxidizer/stage2_oxidizer_rho;
        volume_fuel = mass_fuel/stage2_fuel_rho;
        if second_stage == "LH2"
            stage2_tank_mass = 12.16*volume_oxidizer + 9.09*volume_fuel;
        else
            stage2_tank_mass = 12.16*(volume_oxidizer + volume_fuel);
        end
    end
    
    if second_stage ~= "solid"
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
    
    if second_stage ~= "solid" && second_stage ~= "storables"
        LOX_stage2_insulation_mass = 1.123*(ox_cap_surf_area + ox_cyl_surf_area);
        if second_stage == "LH2"
            LH2_stage2_insulation_mass = 2.88*(fuel_cap_surf_area + fuel_cyl_surf_area);
            stage2_insulation_mass = LOX_stage2_insulation_mass + LH2_stage2_insulation_mass;
        elseif second_stage == "LCH4"
            LCH4_stage2_insulation_mass = 1.123*(fuel_cap_surf_area + fuel_cyl_surf_area);
            stage2_insulation_mass = LOX_stage2_insulation_mass + LCH4_stage2_insulation_mass;
        else
            stage2_insulation_mass = LOX_stage2_insulation_mass;
        end
    elseif second_stage == "solid"
        stage2_insulation_mass = 0;
        solid_cap_vol = 2*(pi*cap_height)*(3*radius^2 + cap_height^2)/6;
        solid_cyl_vol = solid_volume - solid_cap_vol;
        solid_cyl_height = solid_cyl_vol/(pi*radius^2);
    else
        stage2_insulation_mass = 0;
    end
    
    if second_stage ~= "solid"
        stage2_engine_mass = 7.81e-4*stage2_thrust + 3.37e-5*stage2_thrust*sqrt(stage2_nozzle_exp) + 59;
        stage2_casing_mass = 0;
    else
        stage2_engine_mass = 0;
        stage2_casing_mass = 0.135*M_p;
    end
    
    payload_fairing_area = pi*radius*sqrt(radius^2 + payload_cone_height^2) + 2*pi*radius*payload_cyl_height;
    aft2_fairing_area = 2*pi*radius*(engine_space + cap_height);
    
    payload_fairing_mass = 4.95*payload_fairing_area^(1.15);
    stage2_aft_fairing_mass = 4.95*aft2_fairing_area^(1.15);
    
    if second_stage ~= "solid"    
        intertank2_fairing_area = 2*pi*radius*(2*cap_height);
        stage2_intertank2_fairing_mass = 4.95*intertank2_fairing_area^(1.15);
        stage2_height = payload_cone_height + payload_cyl_height + 4*cap_height + ox_cyl_height + fuel_cyl_height + engine_space;
    else 
        stage2_intertank2_fairing_mass = 0;
        stage2_height = payload_cone_height + payload_cyl_height + 2*cap_height + solid_cyl_height + engine_space;
    end
    
    stage2_mass_wiring = 1.058*sqrt(M_0)*stage2_height^(0.25);
    
    stage2_mass_thrust_struct = 2.25e-4*stage2_thrust;
    
    stage2_mass_gimbals = 237.8*(stage2_thrust/chamber_pressure_2)^(0.9375);
    
    stage2_mass_avionics = 10*M_0^(0.361);
    
    stage2_total_mass = M_p + stage2_mass_wiring + stage2_mass_avionics + stage2_tank_mass + stage2_insulation_mass + stage2_engine_mass + stage2_mass_thrust_struct + stage2_casing_mass + stage2_mass_gimbals + payload_fairing_mass + stage2_intertank2_fairing_mass + stage2_aft_fairing_mass + M_l;

    assignin('base', 'stage2_mass_wiring', stage2_mass_wiring);
    assignin('base', 'stage2_mass_avionics', stage2_mass_avionics);
    assignin('base', 'stage2_tank_mass', stage2_tank_mass);
    assignin('base', 'stage2_insulation_mass', stage2_insulation_mass);
    assignin('base', 'stage2_engine_mass', stage2_engine_mass);
    assignin('base', 'stage2_mass_thrust_struct', stage2_mass_thrust_struct);
    assignin('base', 'stage2_casing_mass', stage2_casing_mass);
    assignin('base', 'stage2_mass_gimbals', stage2_mass_gimbals);
    assignin('base', 'payload_fairing_mass', payload_fairing_mass);
    assignin('base', 'stage2_intertank2_fairing_mass', stage2_intertank2_fairing_mass);
    assignin('base', 'stage2_aft_fairing_mass', stage2_aft_fairing_mass);

end