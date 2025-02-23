local b='ALfWtSmdaIZrkDhBuczTgObyUYJxjVKHMEoQCsRnFlXvwGPepqiN0123456789+/' -- You will need this for encoding/decoding
local function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

local function Equate(x)
    x = x + 62 ^ 2 - 12 + 2
    return ((x ^ 3 + 3169) + (69 * x ^ 3) + 31 + ((((x % 16) ^ 12) + ((x % 11) ^ 5)) * x + 69420)) % 99999
end

local function GetToken()
    if (IsDuplicityVersion()) then
        minSec = os.date("%Y") ..os.date("%m") .. os.date("%M")

        realtoken = Equate(minSec)

        return realtoken
    else
        local year, month, day, hour, minute, second = GetPosixTime()

        local fuckingminute = tostring(minute):len()
        if fuckingminute == 1 then minute = "0"..minute end

        local fuckingmonth = tostring(month):len()
        if fuckingmonth == 1 then month = "0"..month end

        minSec = year .. month .. minute

        realtoken = Equate(minSec)

        return realtoken
    end
end

-- Server side
if (IsDuplicityVersion()) then
    local eventToleranceRate = {}
    
    RSE = RegisterServerEvent
    RNE = RegisterNetEvent
    RegisterServerEvent = function(name, cb)
        if (cb) then
            RSE(name, cb)
        else
            RSE(name)
        end

        cb = function(...)
            if eventToleranceRate[source] == nil then eventToleranceRate[source] = 0 end
            local args = table.pack(...)
            local tokenarg = args[#args]
            local verifiedtoken = GetToken()

            if not (tokenarg == verifiedtoken) then
                eventToleranceRate[source] = eventToleranceRate[source] + 1
            else
                eventToleranceRate[source] = 0
            end
            
            if eventToleranceRate[source] >= 3 then
                TriggerEvent("Anticheat:detectionTrigger", enc(tostring(source)), enc("Anti Event Trigger"), enc("Player tried to execute a event with executor. Event: " .. name .. " Tolerance: " .. eventToleranceRate[source] .. " Args: " ..json.encode(args)..")"))
            end
        end

        AddEventHandler(name, cb)
    end
    RegisterNetEvent = function(name, cb)
        if (cb) then
            RNE(name, cb)
        else
            RNE(name)
        end

        cb = function(...)
            if eventToleranceRate[source] == nil then eventToleranceRate[source] = 0 end
            local args = table.pack(...)
            local tokenarg = args[#args]
            local verifiedtoken = GetToken()

            if not (tokenarg == verifiedtoken) then
                eventToleranceRate[source] = eventToleranceRate[source] + 1
            else
                eventToleranceRate[source] = 0
            end
            
            if eventToleranceRate[source] >= 3 then
                TriggerEvent("Anticheat:detectionTrigger", enc(tostring(source)), enc("Anti Event Trigger"), enc("Player tried to execute a event with executor. Event: " .. name .. " Tolerance: " .. eventToleranceRate[source] .. " Args: " ..json.encode(args)..")"))
            end
        end

        AddEventHandler(name, cb)
    end

    TS = TriggerEvent
    TriggerEvent = function(name, ...)
        local args = table.pack(...)
        table.insert(args, GetToken())
        TS(name, table.unpack(args))
    end

    CreateThread(function()
        while true do
            Wait(30000)
            eventToleranceRate = {}
        end
    end)
end

_BelieverServerEvent = TriggerServerEvent
TriggerServerEvent = function(name, ...)
    local args = table.pack(...)
    table.insert(args, GetToken())
    _BelieverServerEvent(name, table.unpack(args))
end