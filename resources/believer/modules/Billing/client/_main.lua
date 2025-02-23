GM.Billing.data = {}

GM.Billing = {
    menu = {
        submenus = {}
    },
    data = {
    },
}

RegisterNetEvent("Billing:updateValue", function(BILLING_DATA, BILLING_KEY, BILLING_VALUE)
    if (not BILLING_VALUE) then
        GM.Billing.data[BILLING_DATA] = BILLING_KEY
    else
        GM.Billing.data[BILLING_DATA][BILLING_KEY] = BILLING_VALUE
    end
end)

RegisterNetEvent("Billing:removeValue", function(BILLING_DATA, BILLING_KEY)
    if (not BILLING_KEY) then
        GM.Billing.data[BILLING_DATA] = nil
    else
        GM.Billing.data[BILLING_DATA][BILLING_KEY] = nil
    end
end)

RegisterCommand("billing_self", function()
    TriggerServerEvent("Billing:addBill", {
        ["label"] = "Test",
        ["amount"] = 100,
        ["job"] = "police",
    })
end)

RegisterCommand("billing_player", function()
    TriggerServerEvent("Billing:send", {
        ["label"] = "Test",
        ["amount"] = 100,
        ["job"] = "police",
        ["target"] = GetPlayerServerId(PlayerId())
    })
end)