GM.Death = GM.Death or {}

GM.Death.IsDead = false
GM.Death.IsKnockout = false

local FirstSpawn = true

function RespawnPed()
    local coords = GetEntityCoords(PlayerPedId())
    SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
    SetPlayerInvincible(PlayerPedId(), false)
    TriggerEvent("playerSpawned", coords.x, coords.y, coords.z, coords.heading)
    ClearPedBloodDamage(PlayerPedId())
end

RegisterNetEvent("Death:onDeath")
AddEventHandler("Death:onDeath", function()
    if (not GM.Death.IsDead and not GM.Death.IsKnockout) then
        GM.Death.IsDead = true

        SetEntityInvincible(PlayerPedId(), true)
        RespawnPed()
        TriggerEvent("Dead:openUI", true)
        TriggerServerEvent("Ambulance:setDead", true)

        ClearPedTasksImmediately(GetPlayerPed(-1))
        SetTimecycleModifier("damage")

        while (GM.Death.IsDead) do
            Wait(0)
            DisablePlayerFiring(PlayerId(), true)
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
            ResetPedRagdollTimer(PlayerPedId())
            SetEntityHealth(PlayerPedId(), 120)
        end
    end
end)

RegisterNetEvent("Death:onKnockout")
AddEventHandler("Death:onKnockout", function()
    if not GM.Death.IsDead and not GM.Death.IsKnockout then
        GM.Death.IsKnockout = true
        GM.Death.Knockout_time = GetGameTimer() + GM.Death.KnockoutTime
        SetEntityInvincible(PlayerPedId(), true)
        RespawnPed()
        ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
        SetTimecycleModifier("glasses_black")

        if (GM.Death.KnockoutBar == nil) then
            local endTime = GetGameTimer() + GM.Death.KnockoutTime
            GM.Death.KnockoutBar = GM.Visual:addBar("INCONSCIENT :", {
                endTime = endTime, 
            })
        end

        while (GM.Death.IsKnockout) do
            Wait(0)
            DisablePlayerFiring(PlayerId(), true)
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
            ResetPedRagdollTimer(PlayerPedId())
            SetEntityHealth(PlayerPedId(), 120)
            if GetGameTimer() >= GM.Death.Knockout_time then
                SetEntityInvincible(PlayerPedId(), false)
                DoScreenFadeOut(500)
                Wait(500)
                ClearTimecycleModifier()
                Wait(500)
                DoScreenFadeIn(500)
                SetEntityHealth(PlayerPedId(), 130)
                GM.Death.IsKnockout = false
                if (GM.Death.KnockoutBar ~= nil) then
                    GM.Visual:deleteBar(GM.Death.KnockoutBar)
                    GM.Death.KnockoutBar = nil
                end
            end
        end
    end
end)

AddEventHandler("playerSpawned", function()
    if FirstSpawn then
        TriggerServerEvent("Ambulance:requestDeathStatus")
        exports.spawnmanager:setAutoSpawn(false) -- disable respawn
        FirstSpawn = false
    end
end)

GM:newThread(function()
	while true do
		Wait(800)
		if IsPedFatallyInjured(PlayerPedId()) then
            Wait(0)
            SetEntityInvincible(PlayerPedId(), true)
			Wait(500)
			local DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())

            if IsMelee(DeathCauseHash) then
                TriggerEvent("Death:onKnockout")
            else
                TriggerEvent("Death:onDeath")
            end

			DeathCauseHash = nil
		end
	end
end)

function IsMelee(Weapon)
	local Weapons = {'WEAPON_BAT', 'WEAPON_CROWBAR', 'WEAPON_UNARMED', 'WEAPON_FLASHLIGHT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_KNUCKLE', 'WEAPON_NIGHTSTICK', 'WEAPON_WRENCH', 'WEAPON_POOLCUE', 'WEAPON_SNOWBALL', 'WEAPON_BALL', 'WEAPON_FLARE', 'WEAPON_FLAREGUN', 'WEAPON_DAGGER', 'WEAPON_BOTTLE', 'WEAPON_HATCHET', 'WEAPON_KNIFE', 'WEAPON_MACHETE', 'WEAPON_SWITCHBLADE', 'WEAPON_BATTLEAXE', 'WEAPON_STONE_HATCHET'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

RegisterNetEvent("Ambulance:revivePlayer")
AddEventHandler("Ambulance:revivePlayer", function()
    GM.Death.IsDead = false
    TriggerEvent("Dead:openUI", false)
    TriggerEvent("Dead:resetUI")
    TriggerEvent('esx_status:set', 'hunger', 1000000)
    TriggerEvent('esx_status:set', 'thirst', 1000000)
    GM:newThread(function()
        DoScreenFadeOut(800)

        while (not IsScreenFadedOut()) do
            Citizen.Wait(0)
        end

        RespawnPed()
        ClearTimecycleModifier()
        DoScreenFadeIn(800)
    end)
end)

RegisterNetEvent("Ambulance:healPlayer", function()
    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
    TriggerEvent('esx_status:set', 'hunger', 1000000)
    TriggerEvent('esx_status:set', 'thirst', 1000000)
end)

RegisterNetEvent("Ambulance:suicide", function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("Ambulance:heal", function()
    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
end)

function getDeathTime()
    return GM.Death.Time
end

exports("getDeathTime", getDeathTime)

function getPlayerDeath()
    return GM.Death.IsDead
end

exports("getPlayerDeath", getPlayerDeath)

function getPlayerKnockout()
    return GM.Death.IsKnockout
end

exports("getPlayerKnockout", getPlayerKnockout)