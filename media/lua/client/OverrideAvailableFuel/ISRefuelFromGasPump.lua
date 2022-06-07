---
--- Created by fritt.
--- DateTime: 24.05.2022 18:42
---

require'Vehicles/ISRefuelFromGasPump';
local OverrideFuelAmount = require("fritt_patch/FP_OverrideFuelAmount");

local ISRefuelFromGasPump_start = ISRefuelFromGasPump.start;
function ISRefuelFromGasPump:start(...)
    OverrideFuelAmount(self.fuelStation, tonumber(self.fuelStation:getPipedFuelAmount()));
    ISRefuelFromGasPump_start(self, ...);
end