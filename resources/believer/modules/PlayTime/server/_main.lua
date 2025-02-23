GM.PlayTime = GM.PlayTime or {}

GM.PlayTime.List = {}

AddEventHandler("esx:playerLoaded", function(playerSrc)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

    MySQL.query('SELECT * FROM user_playtime WHERE identifier = ?', {playerIdentifier}, function(result)
        if (result[1] == nil) then
            MySQL.insert('INSERT INTO user_playtime (identifier, time) VALUES (@identifier, @time)', {
                ['@identifier'] = playerIdentifier,
                ['@time'] = 0
            }, function()
                if (GM.PlayTime.List[playerIdentifier] == nil) then
                    GM.PlayTime.List[playerIdentifier] = {
                        ["time"] = 0,
                        ["joinTime"] = os.time(os.date("!*t"))
                    }
                end
            end)
        else
            if (GM.PlayTime.List[playerIdentifier] == nil) then
                GM.PlayTime.List[playerIdentifier] = {
                    ["time"] = result[1].time,
                    ["joinTime"] = os.time(os.date("!*t"))
                }
            end
        end
    end)
end)

AddEventHandler("playerDropped", function(reason)
	local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

	local timeNow = os.time(os.date("!*t"))

    if (GM.PlayTime.List[playerIdentifier] ~= nil) then
        local storedTime = GM.PlayTime.List[playerIdentifier].time
        local joinTime = GM.PlayTime.List[playerIdentifier].joinTime

        local playTime = timeNow - joinTime

        MySQL.update('UPDATE user_playtime SET time = @time WHERE identifier = @identifier', {
            ['@time'] = storedTime + playTime,
            ['@identifier'] = playerIdentifier
        }, function()
            GM.PlayTime.List[playerIdentifier] = nil
        end)
    end
end)

function GM.PlayTime:SecondsToClock(seconds, restricted)
	local days = math.floor(seconds / 86400)
	seconds = seconds - days * 86400
	local hours = math.floor(seconds / 3600 )
	seconds = seconds - hours * 3600
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

    if (restricted) then
        return string.format("%d jours, %d heures", days, hours)
    end

	if days == 0 and hours == 0 and minutes == 0 then
		return string.format("%d secondes.", seconds)
	elseif days == 0 and hours == 0 then
		return string.format("%d minutes, %d secondes", minutes, seconds)
	elseif days == 0 then
		return string.format("%d heures, %d minutes, %d secondes", hours, minutes, seconds)
	else
		return string.format("%d jours, %d heures, %d minutes, %d secondes", days, hours, minutes, seconds)
	end
	return string.format("%d jours, %d heures, %d minutes, %d secondes", days, hours, minutes, seconds)
end

function GM.PlayTime:getActualTime(playerIdentifier, restricted)
    if (GM.PlayTime.List[playerIdentifier] ~= nil) then
        local storedTime = GM.PlayTime.List[playerIdentifier].time
        local joinTime = GM.PlayTime.List[playerIdentifier].joinTime

        local timeNow = os.time(os.date("!*t"))
        local playTime = timeNow - joinTime

        return GM.PlayTime:SecondsToClock(storedTime + playTime, restricted or false)
    end
    return "Nouveau"
end

exports("getActualTime", function(playerIdentifier, restricted)
    return GM.PlayTime:getActualTime(playerIdentifier, restricted)
end)

function GM.PlayTime:convertTimestampToDate(time)
    local date = os.date("%d/%m/%Y", time)
    return date
end