
-- Made By 0Resmon.

local ScriptName = GetInvokingResource() or GetCurrentResourceName()

Version = {
    DB = "https://raw.githubusercontent.com/0resmon/0r-core/main/versions.json",
    Loop = false,
    LoopTime = 1000
}

SetTimeout(1000, function()
    VersionCheck()
end)

NeedUpdate = "^2[Kibra Mechanics]^1 A new update is available for this script. discord.gg/0resmon"

VersionCheck = function()
    ver = GetResourceMetadata(ScriptName, "version")
    PerformHttpRequest(Version.DB, function (err, data, headers)
        local versions = json.decode(data)
        for k,v in pairs(versions) do
            if v.script == ScriptName and ver ~= v.version then 
                print(NeedUpdate..' ^2[New Version: '..v.version..']')
                while Version.Loop do 
                    print(NeedUpdate..'^2[New Version: '..v.version..']')
                    Citizen.Wait(Version.LoopTime)
                end
               break
            end
        end
    end)
end