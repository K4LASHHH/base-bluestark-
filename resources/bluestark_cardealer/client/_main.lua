isOpen, TestDriveTime, SpawnCoords, Coords, TestDrive, lastPlayerCoords, ESX = {}, true, nil, nil, nil, nil, nil, nil, nil

RegisterNUICallback("TestDrive",function(data, cb)
    SetEntityVisible(PlayerPedId(), 1)
    local hash = GetHashKey(data.car)
    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    if not HasModelLoaded(hash) then 
        RequestModel(hash) 
        while not HasModelLoaded(hash) do 
            Citizen.Wait(10) 
        end 
    end
    testDriveEntity = CreateVehicle(hash, vector4(TestDrive), 1, 1) -- ? TestDriveSpawnPosition
    SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
    SetVehicleNumberPlateText(testDriveEntity,"TestCar")-- ! TestDrivePlate
    local Plate = GetVehicleNumberPlateText(testDriveEntity)
    Plate = Trim(GetVehicleNumberPlateText(testDriveEntity))
    SetVehicleCustomPrimaryColour(testDriveEntity,  data.color.R, data.color.G, data.color.B)
    SetVehicleCustomSecondaryColour(testDriveEntity, data.color.R, data.color.G, data.color.B)
    Config.Carkeys(Plate)
    startCountDown = true
    local timeGG = GetGameTimer()
    while startCountDown do
    SendNUIMessage({type = "close"})
        Citizen.Wait(1)
        if GetGameTimer() < timeGG + tonumber(1000*TestDriveTime) then
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_THROW_GRENADE~ pour rendre le véhicule.")
            if IsControlJustPressed(0, 58) then
                DeleteEntity(testDriveEntity)
                SetEntityCoords(PlayerPedId(), lastPlayerCoords)
                startCountDown = false
            end
            ESX.ShowDrawNotification("~r~Test du véhicule temps restant : "..math.ceil(TestDriveTime - (GetGameTimer() - timeGG)/1000), 1)
        else
            DeleteEntity(testDriveEntity)
            SetEntityCoords(PlayerPedId(), lastPlayerCoords)
            startCountDown = false
        end
    end
end)

RegisterNUICallback("rotateright", function()
    SetEntityHeading(currentVeh, GetEntityHeading(currentVeh) - 2)
end)

RegisterNUICallback("rotateleft", function()
    SetEntityHeading(currentVeh, GetEntityHeading(currentVeh) + 2)
end)

RegisterNUICallback("Vehicle",function(data, cb)
    local model = GetHashKey(data.vehicle)
    local vehClass = GetVehicleClassFromName(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(7)
    end
    if not DoesEntityExist(currentVeh) then
        currentVeh = CreateVehicle(model, Coords, false, true)
        SetVehicleEngineOn(currentVeh, true, true, false)
        SetVehicleCustomPrimaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
        SetVehicleCustomSecondaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
        if vehClass == 14 then 
            FreezeEntityPosition(currentVeh, true)
        end
        cb({
            maxSpeed = GetVehicleEstimatedMaxSpeed(currentVeh),
            Fuel = Config.GetVehFuel(currentVeh),
            Handling = GetVehicleMaxTraction(currentVeh) *12.6,
            Acceleration = GetVehicleAcceleration(currentVeh) *12.6,
            Brake = GetVehicleMaxBraking(currentVeh) *12.6
        })
    end
end)   

RegisterNUICallback("Delete",function()
    SetEntityAsMissionEntity(currentVeh, true, true)
    DeleteVehicle(currentVeh)
end)

RegisterNUICallback("SelectColor", function(data)
    RGB = data.color
    SetVehicleCustomPrimaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
    SetVehicleCustomSecondaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
end)
      
function OpenNui(data)
    SetDisplay(true, true)
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ,data.NuiCarViewCameraPosition.rotX, data.NuiCarViewCameraPosition.rotY, data.NuiCarViewCameraPosition.rotZ,data.NuiCarViewCameraPosition.fov,true,0)
    RequestCollisionAtCoord(data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ)
    RenderScriptCams(true, true, 1, true, true)
    PointCamAtCoord(cam, data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ)
    SetFocusPosAndVel(data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ, 0.0, 0.0, 0.0)
    CustomizeCamera(isOpen)
end

function CloseNui()
    Citizen.Wait(1)
    CustomizeCamera(isOpen)
    SetDisplay(false)
    DestroyAllCams(true)
    RenderScriptCams(false, true, 75, true, false, false)
    SetFocusEntity(GetPlayerPed(PlayerId()))
    SetEntityAsMissionEntity(currentVeh, true, true)
    DeleteVehicle(currentVeh)
    DisplayRadar(true)
    DisplayHud(true)
end

Citizen.CreateThread(function()
    while ESX == nil do
        ESX = exports['believer']:getSharedObject()
        Citizen.Wait(4)
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local getPed = PlayerPedId()
        local entity = GetEntityCoords(getPed)
        for k,v in pairs(Config.Locations) do
            local dist = #(entity - v.coords)
            if dist < 10 then
                if dist < 3 then
                    x = v.coords[1]
                    y = v.coords[2]
                    z = v.coords[3]
                    if IsControlJustPressed(0,38) then
                        if v.job == ESX.PlayerData.job.name or v.job == 'all' then 
                            SendNUIMessage({
                                type = "ui",
                                vehicle = Config.Vehicles.Car[v.type],
                                color = Config.Vehicles.Color[v.type],
                                category = Config.Vehicles.Category[v.type],
                                shoptype = v.type
                            })
                            Coords = v.NuiCarViewSpawnPosition
                            TestDrive = v.TestDriveSpawnPosition
                            TestDriveTime = v.TestDriveTime
                            SpawnCoords = v.BuyCarSpawnPositions
                            OpenNui(v)
                        end
                    end
                end
            end
        end
    end
end)

RegisterNUICallback("Buy", function(data, cb)
    TriggerServerEvent("Cardealer:buyVehicle", {
        model = data.model,
        price = data.price,
        color = data.color,
        type = data.shoptype
    })
end)

RegisterNetEvent("Cardealer:closeUI", function()
    SendNUIMessage({type = "close"})
end)

function Trim(value)
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))
		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end
	return nearbyEntities
end

function GetVehicles()
	local vehicles = {}
	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end
	return vehicles
end

function konumfor(getkonum)
    for k, v in pairs(getkonum) do
        local konum = EnumerateEntitiesWithinDistance(GetVehicles(), false, v, 2.5)
        Wait(4)
        if konum[1] == nil then
            return v
        end
    end
end
 
local display = false
 
RegisterNUICallback("exit", function(data)
    CloseNui()
end)
 
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
end