GM.Personnal = {
    menu = {
        submenus = {}
    },
    data = {
        billing = {},
    },
}

GM.Personnal.menu.main = RageUI.CreateMenu("", "Menu personnel", 0, 0, "banner", "bluestark")
GM.Personnal.menu.main["Closed"] = function()
    -- Todo event when menu closed
end

GM.Personnal.menu.submenus["bills"] = RageUI.CreateSubMenu(GM.Personnal.menu.main, "", "Factures")

GM.Personnal.menu.main:isVisible(function(Items)
    Items:Button("Factures", nil, {}, true, {
        onSelected = function()
            TriggerServerEvent("Billing:requestBills")
        end
    }, GM.Personnal.menu.submenus["bills"])
end)

GM.Personnal.menu.submenus["bills"]:isVisible(function(Items)
    if (GM.Billing.data["list"] ~= nil) then
        for i = 1, #GM.Billing.data["list"] do
            Items:Button(GM.Billing.data["list"][i].label, nil, {RightLabel = "~g~"..GM.Billing.data["list"][i].amount.."$"}, true, {
                onSelected = function()
                    TriggerServerEvent("Billing:pay", i)
                end
            })
        end
    end
end)

RegisterNetEvent("Personnal:openMenu", function()
    GM.Personnal.menu.main:toggle()
end)

RegisterNetEvent("Personnal:updateValue", function(ADMIN_DATA, ADMIN_KEY, ADMIN_VALUE)
    if (not ADMIN_VALUE) then
        GM.Personnal.data[ADMIN_DATA] = ADMIN_KEY
    else
        GM.Personnal.data[ADMIN_DATA][ADMIN_KEY] = ADMIN_VALUE
    end
end)

RegisterNetEvent("Personnal:removeValue", function(ADMIN_DATA, ADMIN_KEY)
    if (not ADMIN_KEY) then
        GM.Personnal.data[ADMIN_DATA] = nil
    else
        GM.Personnal.data[ADMIN_DATA][ADMIN_KEY] = nil
    end
end)