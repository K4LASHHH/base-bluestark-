GM.Armor["active"] = false

RegisterNetEvent('Armor:setActive', function(boolean)
    GM.Armor["active"] = boolean
end)

AddEventHandler("gameEventTriggered", function(eventName, eventArguments)
    if (GM.Armor["active"]) then 
        local args = {}
        if eventName == "CEventNetworkEntityDamage" then
            local victimEntity, attackEntity, damage, _, _, fatalBool, weaponUsed, _, _, _, entityType = table.unpack(eventArguments)
            args = { victimEntity, attackEntity, fatalBool == 1, weaponUsed, entityType, math.floor(string.unpack("f", string.pack("i4", damage)))}
            if GetEntityType(victimEntity) == 1 then 
                if victimEntity == PlayerPedId() then 
                    if (GM.Armor["active"]) then 
                        if GetPedArmour(PlayerPedId()) == 0 then
                            TriggerServerEvent("Armor:removeItem")
                            GM.Armor["active"] = false
                        end
                    end
                end
            end
        end
    end
end)