% function [stage1_total_mass, stage2_total_mass, total_height] = get_sub_system_mass(first_stage, second_stage, X, stage1_num_engines, stage2_num_engines))
for n = 1:30
    rho_LH2 = 71;
    rho_LOX = 1140;
    rho_RP1 = 820;
    rho_LCH4 = 423;
    rho_solid = 1680;
    rho_N2O4 = 1442;
    rho_UDMH = 791;

    g0 = 9.81; % m/s^2
    delta = 0.08;
    deltaV = 12300; % m/s
    M_l = 26000; % kg
    radius = 4; % m
    cap_height = 1; % m
    payload_cone_height = 10; % m
    payload_cyl_height = 10; % m
    engine_space = 3; % m

    if second_stage == "LCH4"
        stage2_Isp = 327;
        stage2_ratio = 3.6;
        stage2_oxidizer_rho = rho_LOX;
        stage2_fuel_rho = rho_LCH4;
        stage2_thrust = 0.745e6; % N
        stage2_nozzle_exp = 45;
        chamber_pressure_2 = 10.1e6; % Pa
    elseif second_stage == "LH2"
        stage2_Isp = 366;
        stage2_ratio = 6.03;
        stage2_oxidizer_rho = rho_LOX;
        stage2_fuel_rho = rho_LH2;
        stage2_thrust = 0.099e6; % N
        stage2_nozzle_exp = 84;
        chamber_pressure_2 = 4.2e6; % Pa
    elseif second_stage == "RP1"
        stage2_Isp = 311;
        stage2_ratio = 2.72;
        stage2_oxidizer_rho = rho_LOX;
        stage2_fuel_rho = rho_RP1;
        stage2_thrust = 0.061e6; % N
        stage2_nozzle_exp = 14.5;
        chamber_pressure_2 = 6.77e6; % Pa
    elseif second_stage == "solid"
        stage2_Isp = 269;
        stage2_thrust = 2.94e6; % N
        stage2_nozzle_exp = 56;
        chamber_pressure_2 = 5e6; % Pa
    elseif second_stage == "storables"
        stage2_Isp = 285;
        stage2_ratio = 2.67;
        stage2_oxidizer_rho = rho_N2O4;
        stage2_fuel_rho = rho_UDMH;
        stage2_thrust = 0.067e6; % N
        stage2_nozzle_exp = 81.3;
        chamber_pressure_2 = 14.7e6; % Pa
    end

    stage2_thrust_total = stage2_thrust * n;

    deltaV2_frac = deltaV*(1-X);
    r = exp(-deltaV2_frac/(g0*stage2_Isp));
    lambda = r - delta;
    M_0 = M_l/lambda; % kg
    M_i = delta*M_0; % kg
    Mp_guess = M_0*(1-r); % kg

    Mf_to_Mp = exp(deltaV2_frac/(g0*stage2_Isp)) - 1;

    tol = .01;
    for i = 1:1000
    
        if second_stage == "solid"
            solid_volume = Mp_guess/rho_solid;
            stage2_tank_mass = 12.16*solid_volume;
        else
            mass_split = Mp_guess/(stage2_ratio+1);
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
        else
            stage2_insulation_mass = 0;
            solid_cap_vol = 2*(pi*cap_height)*(3*radius^2 + cap_height^2)/6;
            solid_cyl_vol = solid_volume - solid_cap_vol;
            solid_cyl_height = solid_cyl_vol/(pi*radius^2);
        end
    
        if second_stage ~= "solid"
            stage2_engine_mass = 7.81e-4*stage2_thrust_total + 3.37e-5*stage2_thrust_total*sqrt(stage2_nozzle_exp) + 59;
            stage2_casing_mass = 0;
        else
            stage2_engine_mass = 0;
            stage2_casing_mass = 0.135*Mp_guess;
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
    
        stage2_mass_thrust_struct = 2.25e-4*stage2_thrust_total;
        stage2_mass_gimbals = 237.8*(stage2_thrust_total/chamber_pressure_2)^(0.9375);
    
        stage2_dry_mass_est = stage2_tank_mass + stage2_insulation_mass + stage2_engine_mass + stage2_mass_thrust_struct + stage2_casing_mass + stage2_mass_gimbals + payload_fairing_mass + stage2_intertank2_fairing_mass + stage2_aft_fairing_mass;
    
        M0_guess = M_l + Mp_guess + stage2_dry_mass_est;
        stage2_mass_wiring = 1.058*sqrt(M0_guess)*stage2_height^(0.25);
        stage2_mass_avionics = 10*M0_guess^(0.361);
    
        stage2_dry_mass = stage2_tank_mass + stage2_insulation_mass + stage2_engine_mass + stage2_mass_thrust_struct + stage2_casing_mass + stage2_mass_gimbals + stage2_mass_avionics + stage2_mass_wiring + payload_fairing_mass + stage2_intertank2_fairing_mass + stage2_aft_fairing_mass;
    
        M_f = M_l + stage2_dry_mass;
        
        Mp_req = M_f*Mf_to_Mp;
    
        residual = Mp_req - Mp_guess;
    
        if abs(residual) < tol
            break;
        end
    
        Mp_guess = Mp_req;
    
    end
    T_to_W = stage2_thrust_total/((Mp_req + stage2_dry_mass)*1.3*g0);
    if T_to_W > 0.76
        n
        break;
    end
end

stage2_wet_mass = Mp_req + stage2_dry_mass;

for n = 1:30
    if first_stage == "LCH4"
        stage1_Isp = 327;
        stage1_ratio = 3.6;
        stage1_oxidizer_rho = rho_LOX;
        stage1_fuel_rho = rho_LCH4;
        stage1_thrust = 2.26e6; % N
        stage1_nozzle_exp = 34.34;
        chamber_pressure_1 = 35.16e6; % Pa
    elseif first_stage == "LH2"
        stage1_Isp = 366;
        stage1_ratio = 6.03;
        stage1_oxidizer_rho = rho_LOX;
        stage1_fuel_rho = rho_LH2;
        stage1_thrust = 1.86e6; % N
        stage1_nozzle_exp = 78;
        chamber_pressure_1 = 20.64e6; % Pa
    elseif first_stage == "RP1"
        stage1_Isp = 311;
        stage1_ratio = 2.72;
        stage1_oxidizer_rho = rho_LOX;
        stage1_fuel_rho = rho_RP1;
        stage1_thrust = 1.92e6; % N
        stage1_nozzle_exp = 37;
        chamber_pressure_1 = 25.8e6; % Pa
    elseif first_stage == "solid"
        stage1_Isp = 269;
        stage1_thrust = 4.5e6; % N
        stage1_nozzle_exp = 16;
        chamber_pressure_1 = 10.5e6; % Pa
    elseif first_stage == "storables"
        stage1_Isp = 285;
        stage1_ratio = 2.67;
        stage1_oxidizer_rho = rho_N2O4;
        stage1_fuel_rho = rho_UDMH;
        stage1_thrust = 1.75e6; % N
        stage1_nozzle_exp = 26.2;
        chamber_pressure_1 = 15.7e6; % Pa
    end

    stage1_thrust_total = stage1_thrust * n;

    deltaV1_frac = deltaV*X;
    r = exp(-deltaV1_frac/(g0*stage1_Isp));
    lambda = r - delta;
    M_0 = M_l/lambda; % kg
    M_i = delta*M_0; % kg
    Mp_guess = M_0*(1-r); % kg

    Mf_to_Mp = exp(deltaV1_frac/(g0*stage1_Isp)) - 1;

    tol = .01;
    for i = 1:1000

        if first_stage == "solid"
            solid_volume = Mp_guess/rho_solid;
            stage1_tank_mass = 12.16*solid_volume;
        else
            mass_split = Mp_guess/(stage1_ratio+1);
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
        else
            stage1_insulation_mass = 0;
            solid_cap_vol = 2*(pi*cap_height)*(3*radius^2 + cap_height^2)/6;
            solid_cyl_vol = solid_volume - solid_cap_vol;
            solid_cyl_height = solid_cyl_vol/(pi*radius^2);
        end
    
        if first_stage ~= "solid"
            stage1_engine_mass = 7.81e-4*stage1_thrust_total + 3.37e-5*stage1_thrust_total*sqrt(stage1_nozzle_exp) + 59;
            stage1_casing_mass = 0;
        else
            stage1_engine_mass = 0;
            stage1_casing_mass = 0.135*Mp_guess;
        end

        interstage_fairing_height = engine_space + cap_height;
    
        interstage_fairing_area = 2*pi*radius*interstage_fairing_height;
        aft_fairing_area = 2*pi*radius*(engine_space + cap_height);
    
        interstage_fairing_mass = 4.95*interstage_fairing_area^(1.15);
        stage1_aft_fairing_mass = 4.95*aft_fairing_area^(1.15);
    
        if first_stage ~= "solid"    
            intertank2_fairing_area = 2*pi*radius*(2*cap_height);
            stage1_intertank2_fairing_mass = 4.95*intertank2_fairing_area^(1.15);
            stage1_height = interstage_fairing_height + 4*cap_height + ox_cyl_height + fuel_cyl_height + engine_space;
        else 
            stage1_intertank2_fairing_mass = 0;
            stage1_height = interstage_fairing_height + 2*cap_height + solid_cyl_height + engine_space;
        end
    
        
    
        stage1_mass_thrust_struct = 2.25e-4*stage1_thrust_total;
        stage1_mass_gimbals = 237.8*(stage1_thrust_total/chamber_pressure_1)^(0.9375);
    
        stage1_dry_mass_est = interstage_fairing_mass + stage1_tank_mass + stage1_insulation_mass + stage1_engine_mass + stage1_mass_thrust_struct + stage1_casing_mass + stage1_mass_gimbals + stage1_intertank2_fairing_mass + stage1_aft_fairing_mass;
    
        M0_guess = Mp_guess + stage1_dry_mass_est + stage2_wet_mass;
        stage1_mass_wiring = 1.058*sqrt(M0_guess)*stage1_height^(0.25);
        stage1_mass_avionics = 10*M0_guess^(0.361);
    
        stage1_dry_mass = stage1_tank_mass + stage1_insulation_mass + stage1_engine_mass + stage1_mass_thrust_struct + stage1_casing_mass + stage1_mass_gimbals + stage1_mass_avionics + stage1_mass_wiring + stage1_intertank2_fairing_mass + stage1_aft_fairing_mass;
    
        M_f = stage1_dry_mass + stage2_wet_mass;
        
        Mp_req = M_f*Mf_to_Mp;
    
        residual = Mp_req - Mp_guess;
    
        if abs(residual) < tol
            break;
        end
    
        Mp_guess = Mp_req;
    
    end
    T_to_W = stage1_thrust_total/((Mp_req + stage1_dry_mass + stage2_wet_mass)*1.3*g0);
    if T_to_W > 1.3
        n
        break;
    end
end
    
