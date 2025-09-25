function [outputArg1,outputArg2] = get_sub_system_masses(first_stage, second_stage, X)

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

    if first_stage == "LCH4"
        Isp1 = 327;
        ratio = 3.6;
        oxidizer_rho = rho_LOX;
        fuel_rho = rho_LCH4;
        thrust_1 = 2.26e3; % N
        nozzle_exp_ratio_1 = 34.34;
        chamber_pressure_1 = 35.16e3; % Pa
    elseif first_stage == "LH2"
        Isp1 = 366;
        ratio = 6.03;
        oxidizer_rho = rho_LOX;
        fuel_rho = rho_LH2;
        thrust_1 = 1.86e3; % N
        nozzle_exp_ratio_1 = 78;
        chamber_pressure_1 = 20.64e3; % Pa
    elseif first_stage == "RP1"
        Isp1 = 311;
        ratio = 2.72;
        oxidizer_rho = rho_LOX;
        fuel_rho = rho_RP1;
        thrust_1 = 1.92e3; % N
        nozzle_exp_ratio_1 = 37;
        chamber_pressure_1 = 25.8e3; % Pa
    elseif first_stage == "solid"
        Isp1 = 269;
        thrust_1 = 4.5e3; % N
        nozzle_exp_ratio_1 = 16;
        chamber_pressure_1 = 10.5e3; % Pa
    elseif first_stage == "storables"
        Isp1 = 285;
        ratio = 2.67;
        oxidizer_rho = rho_N2O4;
        fuel_rho = rho_UDMH;
        thrust_1 = 1.75e3; % N
        nozzle_exp_ratio_1 = 26.2;
        chamber_pressure_1 = 15.7e3; % Pa
    end

    deltaV1_frac = deltaV*X;
    r = exp(-deltaV1_frac/(g0*Isp1));
    lambda = r - delta;
    M_0 = M_l/lambda; % kg
    M_i = delta*M_0; % kg
    M_p = M_0*(1-r); % kg

    if first_stage == "solid"
        volume = M_p/rho_solid;
        tank_mass = 12.16*volume;
    else
        mass_split = M_p/(ratio+1);
        mass_oxidizer = ratio*mass_split;
        mass_fuel = mass_split;
        volume_oxidizer = mass_oxidizer/oxidizer_rho;
        volume_fuel = mass_fuel/fuel_rho;
        if first_stage == "LH2"
            tank_mass = 12.16*volume_oxidizer + 9.09*volume_fuel;
        else
            tank_mass = 12.16*(volume_oxidizer + volume_fuel);
        end
    end

    if first_stage ~= "solid" && first_stage ~= "storables"
        r_LOX_tank = (volume_oxidizer/(4*pi/3))^(1/3)
        A_LOX_tank = 4*pi*r_LOX_tank^2;
        LOX_insulation_mass = 1.123*A_LOX_tank;
        if first_stage == "LH2"
            r_LH2_tank = (volume_fuel/(4*pi/3))^(1/3)
            A_LH2_tank = 4*pi*r_LH2_tank;
            LH2_insulation_tank = 2.88*A_LH2_tank;
            insulation_mass = LOX_insulation_mass + LH2_insulation_tank;
        else
            insulation_mass = LOX_insulation_mass;
        end
    else
        insulation_mass = 0;
    end

    if first_stage ~= "solid"
        engine_mass = 7.81e-4*thrust_1 + 3.37e-5*thrust_1*sqrt(nozzle_exp_ratio_1) + 59;
        casing_mass = 0;
    else
        engine_mass = 0;
        casing_mass = 0.135*M_p;
    end

    mass_thrust_struct = 2.25e-4*thrust_1;

    mass_gimbals = 237.8*(thrust_1/chamber_pressure_1)^(0.9375);

    mass_avionics = 10*M_0^(0.361);

    % mass_wiring = 1.058*sqrt(M_0)*

end

