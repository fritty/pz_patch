---
--- Created by fritt.
--- DateTime: 30.05.2022 15:47
---

require'TimedActions/ISTakeFuel';
local OverrideFuelAmount = require("fritt_patch/FP_OverrideFuelAmount");

local ISTakeFuel_start = ISTakeFuel.start;
function ISTakeFuel:start(...)
    OverrideFuelAmount(self.fuelStation, tonumber(self.fuelStation:getPipedFuelAmount()));
    ISTakeFuel_start(self, ...);
end