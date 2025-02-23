GM.Visual = GM.Visual or {}

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.012, titleOffsetY = -0.012, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035, timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 }
local textColor = { 200, 100, 100 }
local activeBars = {}

function GM.Visual:requestStreamedTextureDict(name)
    if (not name) then return end

    if (not HasStreamedTextureDictLoaded(name)) then
        RequestStreamedTextureDict(name)
        while not HasStreamedTextureDictLoaded(name) do
            Wait(50)
        end
    end
end

function GM.Visual:addlongString(txt)
    if (not txt) then return end

    local maxLength = 100

    for i = 0, string.len(txt), maxLength do
        local sub = string.sub(txt, i, math.min(i + maxLength, string.len(txt)))
		AddTextComponentSubstringPlayerName(sub)
    end
end

function GM.Visual:addBar(title, barData)
    if (not barData) then return end

    GM.Visual:requestStreamedTextureDict("timerbars")

    local barIndex = #activeBars + 1
    if (not barIndex) then return end

    activeBars[barIndex] = {
        type = barData.type,
		title = title,
		text = barData.text,
		textColor = barData.color or { 255, 255, 255, 255 },
		percentage = barData.percentage,
        container = barData.container,
		endTime = barData.endTime,
		pbarBgColor = barData.bg or { 155, 155, 155, 255 },
		pbarFgColor = barData.fg or { 255, 255, 255, 255 }
	}

	return barIndex
end

function GM.Visual:deleteBar(barIndex)
    SetStreamedTextureDictAsNoLongerNeeded("timerbars")
    if (barIndex) then
        activeBars[barIndex] = nil
        return
    end

    activeBars = {}
end

function GM.Visual:updateBar(barIndex, barData)
    if (not activeBars[barIndex] or not barData) then return end

	for dataIndex, dataValues in pairs(barData) do
		activeBars[barIndex][dataIndex] = dataValues
	end
end

function GM.Visual:secondsToClock(seconds)
    if (not seconds) then return end
    seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		mins = string.format("%02.f", math.floor(seconds / 60))
		secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function GM.Visual:draxText(intFont, strText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
    SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)

	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end

	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end

	SetTextEntry("jamyfafi")
	GM.Visual:addlongString(strText)

	DrawText(intPosX, intPosY)
end

GM:newThread(function()
    while true do
        local attente = 1250
        local safeZone = GetSafeZoneSize()
        local safeZoneX = (1.0 - safeZone) * 0.5
        local safeZoneY = (1.0 - safeZone) * 0.5

        if #activeBars > 0 then
            attente = 1
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)

            for i,v in pairs(activeBars) do
                local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
                DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
                GM.Visual:draxText(0, v.title, 0.3, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

                if (v.percentage) then
                    local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
                    local pbarY = drawY + ScreenCoords.pbarOffsetY;
                    local width = Sizes.pbarWidth * v.percentage;

                    DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

                    DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
                end

                if (v.container) then
                    local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
                    local pbarY = drawY + ScreenCoords.pbarOffsetY;
                    local width = Sizes.pbarWidth * v.container;
                    
                    DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, 87, 87, 87, 255) -- Background
                    DrawRect((pbarX - Sizes.pbarWidth / 2) + (width / 2), pbarY, width, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4]) -- Value
                    local firstValue = (Sizes.pbarWidth/5)
                    for i = 1, 4 do
                        DrawRect((pbarX - Sizes.pbarWidth / 2) + (firstValue*i), pbarY, 0.0015, Sizes.pbarHeight, 0, 0, 0, 170) -- Divider
                    end
                end

                if (v.text) then
                    GM.Visual:draxText(0, v.text, 0.400, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
                end

                if (v.endTime) then
                    local remainingTime = math.floor(v.endTime - GetGameTimer())
                    GM.Visual:draxText(0, GM.Visual:secondsToClock(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
                end
            end
        end
        Wait(attente)
    end
end)