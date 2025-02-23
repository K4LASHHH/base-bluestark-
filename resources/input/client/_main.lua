local display = false

local result

RegisterNUICallback("input:exit", function()
    result = {}
    SetDisplay(false)
end)


RegisterNUICallback("input:receiveData", function(data)
    result = data
    SetDisplay(false)
end)

function uiInput(data)
    SetDisplay(not display, data)

    while display do
        Wait(0)
        if result ~= nil then
            local BeforeResult = result
            result = nil
            return BeforeResult
        end
    end
end

function SetDisplay(bool, information)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "input",
        action = bool,
        data = information
    })
end

exports("openInput", uiInput)

-- Todo create exports client-side and server-side to check input