GM.Bank.menu = {
    submenus = {}
}

GM.Bank.data = {}

GM.Bank.menu.main = RageUI.CreateMenu("", "Banque", 0, 0, "banner", "bluestark")
GM.Bank.menu.main["Closed"] = function()
    -- Todo event when menu closed
end

GM.Bank.menu.main:isVisible(function(Items)
    if (GM.Bank.data["money"] == nil) then
        for i = 1, #(ESX.PlayerData.accounts) do
            if (ESX.PlayerData.accounts[i].name == "money") then
                GM.Bank.data["money"] = ESX.PlayerData.accounts[i].money
            end
        end
    end
    if (GM.Bank.data["bank"] == nil) then
        for i = 1, #(ESX.PlayerData.accounts) do
            if (ESX.PlayerData.accounts[i].name == "bank") then
                GM.Bank.data["bank"] = ESX.PlayerData.accounts[i].money
            end
        end
    end
    Items:Button("Argent liquide : ~g~"..GM.Bank.data["money"].."$", nil, {}, true, {})
    Items:Button("Argent en banque : ~g~"..GM.Bank.data["bank"].."$", nil, {}, true, {})
    Items:Button("Déposer de l'argent", nil, {}, true, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Déposer de l'argent",
                submitLabel = "DÉPOSER",
                placeHolders = {
                    {label = "Montant"},
                }
            })

            TriggerServerEvent("bluestark_bank:Deposit", input["0"])
        end
    })
    Items:Button("Retirer de l'argent", nil, {}, true, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Retirer de l'argent",
                submitLabel = "RETIRER",
                placeHolders = {
                    {label = "Montant"},
                }
            })

            TriggerServerEvent("bluestark_bank:Withdraw", input["0"])
        end
    })
end)

RegisterNetEvent("Bank:openMenu", function()
    print(json.encode(ESX.PlayerData.accounts, {indent = true}))
    GM.Bank.menu.main:toggle()
end)

GM:newThread(function()
    local wait = 1250
    while true do
        if (IsNearATM()) then
            wait = 0
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~accéder~s~ à l'ATM.")
            if (IsControlJustPressed(0, 38)) then
                print(json.encode(ESX.PlayerData.accounts, {indent = true}))
                GM.Bank.menu.main:open()
            end
        else
            wait = 1250
        end
        Wait(wait)
    end
end)

GM:newThread(function()
    local wait = 1250
    while true do
        for i = 1, #GM.Bank.Config.Bank do
            local bank = GM.Bank.Config.Bank[i]
            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped)
            local dist = GetDistanceBetweenCoords(coords, bank.x, bank.y, bank.z, true)
            if (dist < 3.0) then
                wait = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~accéder~s~ à votre compte bancaire.")
                if (IsControlJustPressed(0, 38)) then
                    GM.Bank.menu.main:open()
                end
            else
                wait = 1250
            end
        end
        Wait(wait)
    end
end)


function IsNearATM()
	local objects = {}
	for _,v in pairs(GM.Bank.Config.Atm) do
		table.insert(objects, v.prop)
	end
	
	local ped = GetPlayerPed(-1)
	local list = {}
	
	for _,v in pairs(objects) do
		local obj = GetClosestObjectOfType(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, 5.0, GetHashKey(v), false, true ,true)
		local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(obj), true)
		table.insert(list, {object = obj, distance = dist})
	end
	
	local closest = list[1]
	for _,v in pairs(list) do
		if v.distance < closest.distance then
			closest = v
		end
	end
	
	local distance = closest.distance
	local object = closest.object
		
	if distance < 1.8 then
		return true
	end
end

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #(ESX.PlayerData.accounts) do
		if (ESX.PlayerData.accounts[i].name == "money") then
			GM.Bank.data["money"] = ESX.PlayerData.accounts[i].money
		elseif (ESX.PlayerData.accounts[i].name == "bank") then
			GM.Bank.data["bank"] = ESX.PlayerData.accounts[i].money
		end
	end
end)

-- Todo faire un système de radius pour enlever le menu quand on est loin de l'atm ou de la banque
-- Todo remplir le config avec les coordonnées des banques
-- Todo faire les blips des banques et des atm seulement sur la minimap pour les atm