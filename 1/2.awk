#!/bin/awk -f
{
    mass = $0;
    req_fuel = 0;
    while (mass > 0) {
        fuel_for_mass = int(mass / 3) - 2;
        if (fuel_for_mass < 0) {
            break;
        }
        req_fuel += fuel_for_mass
        mass = fuel_for_mass
        print req_fuel
    }
    sum += req_fuel;
    print "Total for " $0 ": " req_fuel;
}
END {
    print "Total sum: " sum
}
