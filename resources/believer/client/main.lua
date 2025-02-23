CreateThread(function()
	if NetworkIsPlayerActive(PlayerId()) then
		exports.spawnmanager:setAutoSpawn(false)
		DoScreenFadeOut(0)
		Wait(500)
		TriggerServerEvent('esx:onPlayerJoined')
	end
end)

RegisterNetEvent("esx:requestModel", function(model)
	ESX.Streaming.RequestModel(model)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
	ESX.PlayerData = xPlayer


	exports.spawnmanager:spawnPlayer({
		x = ESX.PlayerData.coords.x,
		y = ESX.PlayerData.coords.y,
		z = ESX.PlayerData.coords.z + 0.25,
		heading = ESX.PlayerData.coords.heading,
		model = `mp_m_freemode_01`,
		skipFade = false
	}, function()
		TriggerServerEvent('esx:onPlayerSpawn')
		TriggerEvent('esx:onPlayerSpawn')

		if isNew then
			TriggerEvent('skinchanger:loadDefaultModel', skin.sex == 0)
		elseif skin then
			TriggerEvent('skinchanger:loadSkin', skin)
		end

		TriggerEvent('esx:loadingScreenOff')
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
	end)

	ESX.PlayerLoaded = true

	while ESX.PlayerData.ped == nil do Wait(20) end

	if Config.EnablePVP then
		SetCanAttackFriendly(ESX.PlayerData.ped, true, false)
		NetworkSetFriendlyFireOption(true)
	end

	local playerId = PlayerId()

	-- RemoveHudCommonents
	for i = 1, #(Config.RemoveHudCommonents) do
		if Config.RemoveHudCommonents[i] then
			SetHudComponentPosition(i, 999999.0, 999999.0)
		end
	end

	-- DisableNPCDrops
	if Config.DisableNPCDrops then
		local weaponPickups = { `PICKUP_WEAPON_CARBINERIFLE`, `PICKUP_WEAPON_PISTOL`, `PICKUP_WEAPON_PUMPSHOTGUN` }
		for i = 1, #weaponPickups do
			ToggleUsePickupsForPlayer(playerId, weaponPickups[i], false)
		end
	end

	if Config.DisableVehicleSeatShuff then
		AddEventHandler('esx:enteredVehicle', function(vehicle, plate, seat)
			if seat == 0 then
				SetPedIntoVehicle(ESX.PlayerData.ped, vehicle, 0)
				SetPedConfigFlag(ESX.PlayerData.ped, 184, true)
			end	
		end)
	end

	if Config.DisableHealthRegeneration or Config.DisableWeaponWheel or Config.DisableAimAssist or Config.DisableVehicleRewards then
		CreateThread(function()
			while true do
				if Config.DisableHealthRegeneration then
					SetPlayerHealthRechargeMultiplier(playerId, 0.0)
				end

				if Config.DisableWeaponWheel then
					BlockWeaponWheelThisFrame()
					DisableControlAction(0, 37, true)
				end

				if Config.DisableAimAssist then
					if IsPedArmed(ESX.PlayerData.ped, 4) then
						SetPlayerLockonRangeOverride(playerId, 2.0)
					end
				end
				
				if Config.DisableVehicleRewards then
					DisablePlayerVehicleRewards(playerId)
				end

				Wait(0)
			end
		end)
	end

	-- Disable Dispatch services
	if Config.DisableDispatchServices then
		for i = 1, 15 do
			EnableDispatchService(i, false)
		end
	end

	-- Disable Scenarios
	if Config.DisableScenarios then
		local scenarios = {
			'WORLD_VEHICLE_ATTRACTOR',
			'WORLD_VEHICLE_AMBULANCE',
			'WORLD_VEHICLE_BICYCLE_BMX',
			'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
			'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
			'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',
			'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',
			'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
			'WORLD_VEHICLE_BICYCLE_ROAD',
			'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
			'WORLD_VEHICLE_BIKER',
			'WORLD_VEHICLE_BOAT_IDLE',
			'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
			'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
			'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
			'WORLD_VEHICLE_BROKEN_DOWN',
			'WORLD_VEHICLE_BUSINESSMEN',
			'WORLD_VEHICLE_HELI_LIFEGUARD',
			'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
			'WORLD_VEHICLE_CONSTRUCTION_SOLO',
			'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
			'WORLD_VEHICLE_DRIVE_PASSENGERS',
			'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
			'WORLD_VEHICLE_DRIVE_SOLO',
			'WORLD_VEHICLE_FIRE_TRUCK',
			'WORLD_VEHICLE_EMPTY',
			'WORLD_VEHICLE_MARIACHI',
			'WORLD_VEHICLE_MECHANIC',
			'WORLD_VEHICLE_MILITARY_PLANES_BIG',
			'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
			'WORLD_VEHICLE_PARK_PARALLEL',
			'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
			'WORLD_VEHICLE_PASSENGER_EXIT',
			'WORLD_VEHICLE_POLICE_BIKE',
			'WORLD_VEHICLE_POLICE_CAR',
			'WORLD_VEHICLE_POLICE',
			'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
			'WORLD_VEHICLE_QUARRY',
			'WORLD_VEHICLE_SALTON',
			'WORLD_VEHICLE_SALTON_DIRT_BIKE',
			'WORLD_VEHICLE_SECURITY_CAR',
			'WORLD_VEHICLE_STREETRACE',
			'WORLD_VEHICLE_TOURBUS',
			'WORLD_VEHICLE_TOURIST',
			'WORLD_VEHICLE_TANDL',
			'WORLD_VEHICLE_TRACTOR',
			'WORLD_VEHICLE_TRACTOR_BEACH',
			'WORLD_VEHICLE_TRUCK_LOGS',
			'WORLD_VEHICLE_TRUCKS_TRAILERS',
			'WORLD_VEHICLE_DISTANT_EMPTY_GROUND',
			'WORLD_HUMAN_PAPARAZZI'
		}
		
		for i, v in pairs(scenarios) do
			SetScenarioTypeEnabled(v, false)
		end
	end
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight) ESX.SetPlayerData("maxWeight", newMaxWeight) end)

local function onPlayerSpawn()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', false)
end

AddEventHandler('playerSpawned', onPlayerSpawn)
AddEventHandler('esx:onPlayerSpawn', onPlayerSpawn)

AddEventHandler('esx:onPlayerDeath', function()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', true)
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Wait(100)
	end
end)

-- Credit: https://github.com/LukeWasTakenn, https://github.com/LukeWasTakenn/luke_garages/blob/master/client/client.lua#L331-L352
AddStateBagChangeHandler('VehicleProperties', nil, function(bagName, key, value)
	if not value then 
		return 
	end

    local netId = bagName:gsub('entity:', '')
    local timer = GetGameTimer()
    while not NetworkDoesEntityExistWithNetworkId(tonumber(netId)) do
	    Wait(0)
	    if GetGameTimer() - timer > 10000 then
	        return
	    end
    end
	
    local vehicle = NetToVeh(tonumber(netId))
    local timer = GetGameTimer()
    while NetworkGetEntityOwner(vehicle) ~= PlayerId() do
        Wait(0)
	    if GetGameTimer() - timer > 10000 then
	        return
	    end
    end

    ESX.Game.SetVehicleProperties(vehicle, value)
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #(ESX.PlayerData.accounts) do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end

	ESX.SetPlayerData('accounts', ESX.PlayerData.accounts)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(Job)
	ESX.SetPlayerData('job', Job)
end)

RegisterNetEvent('esx:registerSuggestions')
AddEventHandler('esx:registerSuggestions', function(registeredCommands)
	for name, command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

-- disable wanted level
if not Config.EnableWantedLevel then
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)
end

RegisterNetEvent("esx:tpm")
AddEventHandler("esx:tpm", function()
	local GetEntityCoords = GetEntityCoords
	local GetGroundZFor_3dCoord = GetGroundZFor_3dCoord
	local GetFirstBlipInfoId = GetFirstBlipInfoId
	local DoesBlipExist = DoesBlipExist
	local DoScreenFadeOut = DoScreenFadeOut
	local GetBlipInfoIdCoord = GetBlipInfoIdCoord
	local GetVehiclePedIsIn = GetVehiclePedIsIn


	local blipMarker = GetFirstBlipInfoId(8)
	if not DoesBlipExist(blipMarker) then
		ESX.ShowNotification("~r~Vous n'avez pas de marqueur sur la carte.")
	end

	DoScreenFadeOut(650)
	while not IsScreenFadedOut() do
		Wait(0)
	end

	local ped, coords = PlayerPedId(), GetBlipInfoIdCoord(blipMarker)
	local vehicle = GetVehiclePedIsIn(ped, false)
	local oldCoords = GetEntityCoords(ped)

	local x, y, groundZ, Z_START = coords['x'], coords['y'], 850.0, 950.0
	local found = false
	FreezeEntityPosition(vehicle > 0 and vehicle or ped, true)

	for i = Z_START, 0, -25.0 do
		local z = i
		if (i % 2) ~= 0 then
			z = Z_START - i
		end

		NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
		local curTime = GetGameTimer()
		while IsNetworkLoadingScene() do
			if GetGameTimer() - curTime > 1000 then
				break
			end
			Wait(0)
		end
		NewLoadSceneStop()
		SetPedCoordsKeepVehicle(ped, x, y, z)

		while not HasCollisionLoadedAroundEntity(ped) do
			RequestCollisionAtCoord(x, y, z)
			if GetGameTimer() - curTime > 1000 then
				break
			end
			Wait(0)
		end

		found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
		if found then
			Wait(0)
			SetPedCoordsKeepVehicle(ped, x, y, groundZ)
			break
		end
		Wait(0)
	end

	DoScreenFadeIn(650)
	FreezeEntityPosition(vehicle > 0 and vehicle or ped, false)

	if not found then
		SetPedCoordsKeepVehicle(ped, oldCoords['x'], oldCoords['y'], oldCoords['z'] - 1.0)
		ESX.ShowNotification("~b~Vous avez été téléporté à l'endroit où vous étiez avant le téléport.")
	end

	SetPedCoordsKeepVehicle(ped, x, y, groundZ)
	ESX.ShowNotification("~b~Vous avez été téléporté avec succès.")
end)

RegisterNetEvent("esx:killPlayer")
AddEventHandler("esx:killPlayer", function()
	SetEntityHealth(ESX.PlayerData.ped, 0)
end)

RegisterNetEvent("esx:freezePlayer")
AddEventHandler("esx:freezePlayer", function(input)
	local player = PlayerId()
	if input == 'freeze' then
		SetEntityCollision(ESX.PlayerData.ped, false)
		FreezeEntityPosition(ESX.PlayerData.ped, true)
		SetPlayerInvincible(player, true)
	elseif input == 'unfreeze' then
		SetEntityCollision(ESX.PlayerData.ped, true)
		FreezeEntityPosition(ESX.PlayerData.ped, false)
		SetPlayerInvincible(player, false)
	end
end)

ESX.RegisterClientCallback("esx:GetVehicleType", function(cb, model)
	cb(ESX.GetVehicleType(model))
end)

RegisterNetEvent('esx:updatePlayerData', function(key, val)
	ESX.SetPlayerData(key, val)
end)