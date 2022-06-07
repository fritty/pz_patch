---
--- Created by fritt.
--- DateTime: 30.05.2022 15:41
---

require("HowMuchFuel/HMFCheckFuel");
local OverrideFuelAmount = require("fritt_patch/FP_OverrideFuelAmount");

local HMFCheckFuel_start = HMFCheckFuel.start;
function HMFCheckFuel:start(...)
    self.fuelAmount = OverrideFuelAmount(self.pump, self.fuelAmount);
    HMFCheckFuel_start(self, ...);
end