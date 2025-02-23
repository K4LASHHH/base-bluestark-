-- Locals

ESX = exports['believer']:getSharedObject()

local seatbeltOn = false
local drink, food = 0,0
local enableField = false
local FuelLevel = 65
local blacklistedStrings = {"<", ">", "http", "https", ".png", ".mp4", ".mp3", ".mov", ".webm"}
local antiSpam = false
local isFunk = false

function toggleField(enable)
    enableField = enable
    if enable then
        SendNUIMessage({
            action = 'open',
        })
    else
        SendNUIMessage({
            action = 'close',
        })
    end
end

RegisterNetEvent("pma-voice:setTalkingMode")
AddEventHandler("pma-voice:setTalkingMode", function(mode)
    talkingStage = mode

    SendNUIMessage({
        action = 'updateVoiceLevel', 
        TalkingStage = talkingStage,
    })
end)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
    end

    local playerData = ESX.GetPlayerData()

    SendNUIMessage({
        action = "setidentifier",
        data = playerData.id
    })

    while (playerData.accounts == nil) do
        Citizen.Wait(50)
    end

    for _, account in pairs(playerData.accounts) do 
        if account.name == "money" then
            SendNUIMessage({
                action = "setMoney",
                data = account.money,
            })
        end
        if account.name == "bank" then
            SendNUIMessage({
                action = "setBank",
                data = account.money,
            })
        end
        if account.name == "black_money"then
            SendNUIMessage({
                action = "setBlackMoney",
                data = account.money,
            })
        end
    end
end)

CreateThread(function()
    while true do
        SendNUIMessage({
            action = "updateMicrophone",
            microphone = NetworkIsPlayerTalking(PlayerId())
        })
        Wait(125)
    end
end)

Citizen.CreateThread(function()
    local sleep = 0

	while true do
		Citizen.Wait(sleep)
		if IsPauseMenuActive() then
            toggleField(false)
            sleep = 1500
		else
            toggleField(true)
            sleep = 0
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                drink = thirst.getPercent()
                food = hunger.getPercent()
            end)
        end)

        SendNUIMessage({
            action = 'customBars',
            type = Config.FoodBars.bars,
            DataPosition = Config.FoodBars.DataPosition,
            foodInt = food, 
            drinkInt = drink,
        })
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    local sleep = 500
	while true do
		Citizen.Wait(sleep)
        local player = PlayerPedId()
        if IsPedArmed(player, 6) then
            sleep = 250
            local weapon = GetSelectedPedWeapon(player)
            local ammoTotal = GetAmmoInPedWeapon(player,weapon)
            local bool,ammoClip = GetAmmoInClip(player,weapon)
            local ammoRemaining = math.floor(ammoTotal - ammoClip)

            SendNUIMessage({
                action = 'WeaponEquiped',
                type = 'waffe',
                isActive = IsPedArmed(player, 6),
                ammoClip = ammoClip,
                ammoRemaining = ammoRemaining
            })
        else
            SendNUIMessage({action = 'WeaponEquiped'})
            sleep = 1000
        end
    end
end)

Citizen.CreateThread(function()    
    while true do 
        Citizen.Wait(2500)

        local player = PlayerPedId()
        local playerPos = GetEntityCoords(player, true)
        local bool, streetName = GetStreetNameAtCoord(playerPos, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
        local street = GetStreetNameFromHashKey(streetName);
		local zone = GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)

        SendNUIMessage({
            action = 'setPosition',
            street = street,
            zone = GetLabelText(zone),
        })

        local playerData = ESX.GetPlayerData()
        for _, account in pairs(playerData.accounts) do 
            if account.name == "money" then
                SendNUIMessage({
                    action = "setMoney",
                    data = account.money,
                })
            end
            if account.name == "bank" then
                SendNUIMessage({
                    action = "setBank",
                    data = account.money,
                })
            end
            if account.name == "black_money"then
                SendNUIMessage({
                    action = "setBlackMoney",
                    data = account.money,
                })
            end
        end
    end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    for i = 1, #(ESX.PlayerData.accounts) do
		if (ESX.PlayerData.accounts[i].name == "money") then
            SendNUIMessage({
				action = "setMoney",
				data = ESX.PlayerData.accounts[i].money
			})
		elseif (ESX.PlayerData.accounts[i].name == "bank") then
            SendNUIMessage({
				action = "setBank",
				data = ESX.PlayerData.accounts[i].money
			})
        elseif (ESX.PlayerData.accounts[i].name == "black_money") then
            SendNUIMessage({
				action = "black_money",
				data = ESX.PlayerData.accounts[i].money
			})
		end
	end
end)

Citizen.CreateThread(function()
    local sleep = 1500

    while true do
        Citizen.Wait(sleep)
        
        local player = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(player)
        local inVeh = IsPedInAnyVehicle(player, false)

        if inVeh then
            local FuelLevel = GetVehicleFuelLevel(vehicle)
            local MaxFuelLevel = Citizen.InvokeNative(0x642FC12F, vehicle, 'CHandlingData', 'fPetrolTankVolume', Citizen.ReturnResultAnyway(), Citizen.ResultAsFloat())
            local retval, lightsOn, highbeamsOn = GetVehicleLightsState(vehicle)
            local lockStatus = GetVehicleDoorLockStatus(vehicle)
    
            sleep = 1

            SendNUIMessage({
                action = "setSpeed",
                speed = math.floor(GetEntitySpeed(vehicle)*3.6),
                maxkmh = GetVehicleEstimatedMaxSpeed(vehicle) * 5.2
            })

            SendNUIMessage({
                action = "setVehFuel",
                fuel = math.ceil(FuelLevel),
                max = MaxFuelLevel
            })
            
            local locked = false

            if lockStatus == 1 or lockStatus == 0 then
                locked = false
            elseif lockStatus == 2 then
                locked = true
            end

            SendNUIMessage({
                action = "setVehStates",
                locked = locked,
                light = highbeamsOn,
                seatbelt = seatbeltOn,
                engine = GetIsVehicleEngineRunning(vehicle), 
            })
        else
            sleep = 1000
        end

        SendNUIMessage({
            action = "setInVeh",
            state = inVeh, 
        })
    end
end)

AddEventHandler('esx:onPlayerSpawn', function()
    SendNUIMessage({
        action = "setidentifier",
        data = GetPlayerServerId(PlayerId())
    })
    toggleField(true)
end)

if not IsDuplicityVersion() then -- Only register this event for the client
    AddEventHandler('esx:setPlayerData', function(key, val, last)
        if GetInvokingResource() == 'believer' then
            ESX.PlayerData[key] = val
            if OnPlayerData then
                OnPlayerData(key, val, last)
            end
        end
    end)

    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
        ESX.PlayerLoaded = true
    end)

    RegisterNetEvent('esx:onPlayerLogout', function()
        ESX.PlayerLoaded = false
        ESX.PlayerData = {}
    end)
end

RegisterNetEvent('pma-voice:setTalkingOnRadio', function(plySource, enabled)
    if(enabled)then
        isFunk = 2;
    else
        isFunk = 1;
    end
end)

RegisterNetEvent('hud:hide')
AddEventHandler('hud:hide', function(BOOLEAN) -- true or false
    toggleField(BOOLEAN)
end)

RegisterNetEvent('hud:updateplayers')
AddEventHandler('hud:updateplayers', function(players, maxPlayers)    
    SendNUIMessage({
        action = "setplayers",
        players = players,
        maxPlayers = maxPlayers
    })
end)