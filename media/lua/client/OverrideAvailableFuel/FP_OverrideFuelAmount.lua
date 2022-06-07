---
--- Created by fritt.
--- DateTime: 30.05.2022 15:41
---

local function FP_OverrideFuelAmount(pump, pumpCurrent)
    local fuelAmount = pumpCurrent;
    if fuelAmount > 800 then
        local min = 50;
        local max = 500;
        fuelAmount = ZombRand(min, max+1);
        pump:setPipedFuelAmount(fuelAmount);
    end
    return fuelAmount;
end

return FP_OverrideFuelAmount;