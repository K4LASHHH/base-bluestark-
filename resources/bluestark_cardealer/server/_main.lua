ESX = exports['believer']:getSharedObject()

function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if MySQL == nil then
        exports.oxmysql:execute(query, function(data)
            result = data
            IsBusy = false
        end)
    else
        MySQL.query(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    end
    
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(3) .. GetRandomNumber(3))

        local result = ExecuteSql("SELECT 1 FROM owned_vehicles WHERE plate = '"..generatedPlate.."'")
        if result[1] == nil then 
            doBreak = true
        end

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

RegisterServerEvent("Cardealer:buyVehicle", function(vehicle)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    for i = 1, #Config.Vehicles.Car[vehicle.type] do
        if (Config.Vehicles.Car[vehicle.type][i].model == vehicle.model) then
            if (Config.Vehicles.Car[vehicle.type][i].restricted) then
                
            end
            if (playerSelected.getMoney() >= Config.Vehicles.Car[vehicle.type][i].price) then
                playerSelected.removeMoney(Config.Vehicles.Car[vehicle.type][i].price)
                local plate = GeneratePlate()

                newVehicle = {
                    model = vehicle.model,
                    plate = plate,
                    customPrimaryColor = {vehicle.color["R"], vehicle.color["G"], vehicle.color["B"]},
                    customSecondaryColor = {vehicle.color["R"], vehicle.color["G"], vehicle.color["B"]},
                }

                MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored) VALUES (@owner, @plate, @vehicle, @type, @stored)', {
                    ["@owner"] = playerSelected.getIdentifier(),
                    ["@plate"] = plate,
                    ["@vehicle"] = json.encode(newVehicle),
                    ["@type"] = vehicle.type,
                    ["@stored"] = 1
                },function(outfitId)
                    local upgrades = {
                        plate = plate, 
                        customPrimaryColor = {vehicle.color["R"], vehicle.color["G"], vehicle.color["B"]},
                        customSecondaryColor = {vehicle.color["R"], vehicle.color["G"], vehicle.color["B"]},
                    }
            
                    local playerPed = playerSelected.getPed()
                    if (not playerPed) then return end
            
                    local playerPosition = playerSelected.getCoords(true)
                    if (not playerPosition) then return end
            
                    ESX.OneSync.SpawnVehicle(vehicle.model, vector3(-23.875314712524,-1094.9291992188,26.678476333618), 340.15, upgrades, false, function(networkId)
                        if networkId then
                            local vehicle = NetworkGetEntityFromNetworkId(networkId)
                            for i = 1, 20 do
                                Wait(0)
                                SetPedIntoVehicle(playerPed, vehicle, -1)
                        
                                if GetVehiclePedIsIn(playerPed, false) == vehicle then
                                    break
                                end
                            end
                            if GetVehiclePedIsIn(playerPed, false) ~= vehicle then
                                playerSelected.showNotification("~r~Impossible de rentrer dans le véhicule !")
                            end
                            TriggerClientEvent("Cardealer:closeUI", playerSrc)
                        end
                    end)
                end)
                return
            elseif (playerSelected.getAccount("bank") >= Config.Vehicles.Car[vehicle.type][i].price) then
                playerSelected.removeAccountMoney("bank", Config.Vehicles.Car[vehicle.type][i].price, true)
                
                return
            else
                playerSelected.showNotification("~r~Vous n'avez pas assez d'argent pour vous acheter ce véhicule.")
                TriggerClientEvent("Cardealer:closeUI", playerSrc)
                return
            end
        end
    end
end)