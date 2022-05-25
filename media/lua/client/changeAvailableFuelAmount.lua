---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by fritt.
--- DateTime: 24.05.2022 18:42
---

require'TimedActions/ISTakeFuel';
require'Vehicles/ISRefuelFromGasPump';
require'HowMuchFuel/HMFCheckFuel';

local function OverrideFuelAmount(pump, pumpCurrent)
    local fuelAmount = pumpCurrent;

    if fuelAmount > 800 then
        local min = 50;
        local max = 500;
        fuelAmount = ZombRand(min, max+1);
        pump:setPipedFuelAmount(fuelAmount);
    end
    return fuelAmount;
end

local ISTakeFuel_start = ISTakeFuel.start;
function ISTakeFuel:start(...)
    OverrideFuelAmount(self.fuelStation, tonumber(self.fuelStation:getPipedFuelAmount()));
    ISTakeFuel_start(self, ...);
end

local ISRefuelFromGasPump_start = ISRefuelFromGasPump.start;
function ISRefuelFromGasPump:start(...)
    OverrideFuelAmount(self.fuelStation, tonumber(self.fuelStation:getPipedFuelAmount()));
    ISRefuelFromGasPump_start(self, ...);
end

local HMFCheckFuel_start = HMFCheckFuel.start;
function HMFCheckFuel:start(...)
    self.fuelAmount = OverrideFuelAmount(self.pump, self.fuelAmount);
    HMFCheckFuel_start(self, ...);
end