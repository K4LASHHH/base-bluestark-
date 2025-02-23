GM.Jail = GM.Jail or {}

GM.Jail.current = {}

RegisterNetEvent("Jail:sendInJail", function(time)
    GM.Jail.current.time = time
	
    TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1']  = 146, ['torso_2']  = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms']     = 0,   ['pants_1']  = 3,
				['pants_2']  = 7,   ['shoes_1']  = 12,
				['shoes_2']  = 12,  ['chain_1']  = 50,
				['chain_2']  = 0
			})
		else
			TriggerEvent('skinchanger:loadClothes', skin, {
				['tshirt_1'] = 3,   ['tshirt_2'] = 0,
				['torso_1']  = 38,  ['torso_2']  = 3,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms']     = 2,   ['pants_1']  = 3,
				['pants_2']  = 15,  ['shoes_1']  = 66,
				['shoes_2']  = 5,   ['chain_1']  = 0,
				['chain_2']  = 2
			})
		end
	end)
	GM:newThread(function()
		while true do
			if (GM.Jail.current.time == nil) then break end
			if GM.Jail.current.time ~= 0 then
				GM.Jail.current.time = GM.Jail.current.time - 1
			elseif (GM.Jail.current.time == 0) then
				TriggerServerEvent("Jail:isJailFinish")
			else
				break
			end
			Wait(1000)
		end
	end)
	GM:newThread(function()
		while true do
			if (GM.Jail.current.time == nil) then break end
			if GM.Jail.current.time ~= 0 then
				local currentTime = GM.PlayTime:SecondsToClock(GM.Jail.current.time)
                ESX.ShowDrawNotification("~r~Vous êtes actuellement en prison !\nTemps restant : "..currentTime, 1)
                if (#(GetEntityCoords(GetPlayerPed(-1)) - vector3(1728.492, 2532.91, 43.58)) > 1000) then
                    SetEntityCoords(GetPlayerPed(-1), 1728.492, 2532.91, 43.58, false, false, false, true)
                end
			else
				break
			end
			Wait(0)
		end
	end)
end)

RegisterNetEvent("Jail:sendOutJail", function()
    GM.Jail.current = {}
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)