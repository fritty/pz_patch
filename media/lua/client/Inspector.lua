---
--- Created by fritt.
--- DateTime: 30.05.2022 17:28
---

local function Inspect(object, x, y)
    local thisObject = object;
    local player = getSpecificPlayer(0);

    s = ISMoveableSpriteProps.fromObject(thisObject);

    if s then
        if s.spriteName then player:Say(s.spriteName) end
        if s and s.spriteName and s.spriteName == "industry_01_23" then
            local modData = thisObject:getModData();
            if modData and modData.fuelAmount and tonumber(modData.fuelAmount) > 0 then
                player:Say(tostring(ISMoveableSpriteProps.fromObject(thisObject).weight));
            end
        end
        return;
    end

    player:Say("wat");
end
Events.OnObjectLeftMouseButtonDown.Add(Inspect);