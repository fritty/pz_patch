---
--- Created by fritt.
--- DateTime: 30.05.2022 16:20
---

require("FuelAPI/ISMoveableSpriteProps");
local FuelAPIUtils = require("FuelAPI/Utils");

local function FuelToWeight( fuelAmount )
    return 10 + toInt(tonumber(fuelAmount)*5);--0.1275);
end

local function ModifyObjSpriteProps( props, object )
    if FuelAPIUtils.GetSandboxCanPickupFullBarrel() and props and props.spriteName and props.spriteName == "industry_01_23" then
        local modData = object:getModData();
        if modData and modData.fuelAmount and tonumber(modData.fuelAmount) > 0 then
            props.weight = FuelToWeight(modData.fuelAmount);
            props.rawWeight = props.weight * 10;
        end
    end
end

local ISMoveableSpriteProps_fromObject = ISMoveableSpriteProps.fromObject;
function ISMoveableSpriteProps.fromObject(_object)
    local s = ISMoveableSpriteProps_fromObject(_object);
    ModifyObjSpriteProps(s, _object);
    return s;
end

local ISMoveableSpriteProps_getObjectMoveProps = ISMoveableSpriteProps.getObjectMoveProps;
function ISMoveableSpriteProps:getObjectMoveProps( _obj )
    local s = ISMoveableSpriteProps_getObjectMoveProps(self, _obj);
    ModifyObjSpriteProps(s, _obj);
    return s;
end

local ISMoveableSpriteProps_getInfoPanelFlagsGeneral = ISMoveableSpriteProps.getInfoPanelFlagsGeneral;
function ISMoveableSpriteProps:getInfoPanelFlagsGeneral( _square, _object, _player, _mode )
    ModifyObjSpriteProps(self, _object);
    ISMoveableSpriteProps_getInfoPanelFlagsGeneral(self, _square, _object, _player, _mode);
end

local ISMoveableSpriteProps_getInfoPanelFlagsPerTile = ISMoveableSpriteProps.getInfoPanelFlagsPerTile;
function ISMoveableSpriteProps:getInfoPanelFlagsPerTile( _square, _object, _player, _mode )
    ModifyObjSpriteProps(self, _object);
    ISMoveableSpriteProps_getInfoPanelFlagsPerTile(self,_square, _object, _player, _mode);
end

local ISMoveableSpriteProps_canPickUpMoveableInternal = ISMoveableSpriteProps.canPickUpMoveableInternal;
function ISMoveableSpriteProps:canPickUpMoveableInternal( _character, _square, _object, _isMulti )
    ModifyObjSpriteProps(self, _object);
    return ISMoveableSpriteProps_canPickUpMoveableInternal(self, _character, _square, _object, _isMulti);
end

--local ISMoveableSpriteProps_instanceItem = ISMoveableSpriteProps.instanceItem;
--function ISMoveableSpriteProps:instanceItem(_spriteNameOverride)
--    local item = ISMoveableSpriteProps_instanceItem(self, _spriteNameOverride);
--    local modData = item:getModData();
--    if modData and modData.fuelAmount and tonumber(modData.fuelAmount) > 0 then
--        item:setActualWeight(40);--(FuelToWeight(modData.fuelAmount));
--    end
--    return item;
--end

local ISMoveableSpriteProps_pickUpMoveableInternal = ISMoveableSpriteProps.pickUpMoveableInternal;
function ISMoveableSpriteProps:pickUpMoveableInternal( _character, _square, _object, ... )
    local fuelAmount = 0;
    if instanceof(_object, "IsoObject") and FuelAPIUtils.GetSandboxCanPickupFullBarrel() then
        local props = _object:getProperties();
        if props and props:Val("CustomName") == "Barrel" then
            local modData = _object:getModData();
            if modData.fuelAmount and tonumber(modData.fuelAmount) > 0 then
                fuelAmount = tonumber(modData.fuelAmount);
            end
        end
    end

    local item = ISMoveableSpriteProps_pickUpMoveableInternal(self, _character, _square, _object, ...);

    if instanceof(item, "InventoryItem") and fuelAmount > 0 then
        local modData = item:getModData();
        item:setActualWeight(FuelToWeight(modData.fuelAmount));
        item:setCustomWeight(true);

        --getSpecificPlayer(0):Say(item:getFullType() .. " weight " .. tostring(item:getWeight()) .. " aweight " .. tostring(item:getActualWeight()));
    end

    return item;
end

Events.onLoadModDataFromServer.Add();