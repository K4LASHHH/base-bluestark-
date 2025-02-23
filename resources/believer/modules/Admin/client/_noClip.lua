GM.Admin = GM.Admin or {}
GM.Admin.Noclip = GM.Admin.Noclip or {}
GM.Admin.Noclip.Cam = nil 
GM.Admin.Noclip.InSpec = false
GM.Admin.Noclip.CamCalculate = nil
GM.Admin.Noclip.Timer = 0
GM.Admin.Noclip.Timer2 = 0
GM.Admin.Noclip.CamTarget = {}
GM.Admin.Noclip.Scalform = nil 

GM.Admin.Noclip.DetailsScalform = {
    speed = {
        control = 178,
        label = "Vitesse du noclip"
    },
    spectateplayer = {
        control = 24,
        label = "Spectate le joueur"
    },
    gotopos = {
        control = 51,
        label = "Revenir ici"
    },
    sprint = {
        control = 21,
        label = "Rapide"
    },
    slow = {
        control = 36,
        label = "Lent"
    },
    message = {
        control = 348,
        label = "Annonce de zone"
    },
}

GM.Admin.Noclip.DetailsInSpec = {
    exit = {
        control = 45,
        label = "Sortir du mode"
    },
}

GM.Admin.Noclip.RequestScaleForm = function(scaleform)
	local handle = RequestScaleformMovie(scaleform)
	if handle ~= 0 then
		while not HasScaleformMovieLoaded(handle) do
			Wait(0)
		end
	end
	return handle
end

GM.Admin.Noclip.CreateScaleform = function(name, data)
	if not name or string.len(name) <= 0 then return end
	local scaleform = GM.Admin.Noclip.RequestScaleForm(name)

	GM.Admin.Noclip.SetScaleformParams(scaleform, data)
	return scaleform
end

GM.Admin.Noclip.SetScaleformParams = function(scaleform, data)
	data = data or {}
	for k,v in pairs(data) do
		PushScaleformMovieFunction(scaleform, v.name)
		if v.param then
			for _,par in pairs(v.param) do
				if math.type(par) == "integer" then
					PushScaleformMovieFunctionParameterInt(par)
				elseif type(par) == "boolean" then
					PushScaleformMovieFunctionParameterBool(par)
				elseif math.type(par) == "float" then
					PushScaleformMovieFunctionParameterFloat(par)
				elseif type(par) == "string" then
					PushScaleformMovieFunctionParameterString(par)
				end
			end
		end
		if v.func then v.func() end
		PopScaleformMovieFunctionVoid()
	end
end

function GM.Admin.Noclip:ActiveScalform(bool)
    local dataSlots = {
        {
            name = "CLEAR_ALL",
            param = {}
        }, 
        {
            name = "TOGGLE_MOUSE_BUTTONS",
            param = { 0 }
        },
        {
            name = "CREATE_CONTAINER",
            param = {}
        } 
    }
    local dataId = 0
    for k, v in pairs(bool and GM.Admin.Noclip.DetailsInSpec or GM.Admin.Noclip.DetailsScalform) do
        dataSlots[#dataSlots + 1] = {
            name = "SET_DATA_SLOT",
            param = {dataId, GetControlInstructionalButton(2, v.control, 0), v.label}
        }
        dataId = dataId + 1
    end
    dataSlots[#dataSlots + 1] = {
        name = "DRAW_INSTRUCTIONAL_BUTTONS",
        param = { -1 }
    }
    return dataSlots
end

function GM.Admin.Noclip:ControlInCam()
    local p10, p11 = IsControlPressed(1, 10), IsControlPressed(1, 11)
    local pSprint, pSlow = IsControlPressed(1, GM.Admin.Noclip.DetailsScalform.sprint.control), IsControlPressed(1, GM.Admin.Noclip.DetailsScalform.slow.control)
    if p10 or p11 then
        GM.Admin.Noclip.SpeedNoclip = math.max(0, math.min(100, round(GM.Admin.Noclip.SpeedNoclip + (p10 and 0.01 or -0.01), 2)))
    end
    if GM.Admin.Noclip.CamCalculate == nil then
        if pSprint then
            GM.Admin.Noclip.CamCalculate = GM.Admin.Noclip.SpeedNoclip * 2.0
        elseif pSlow then
            GM.Admin.Noclip.CamCalculate = GM.Admin.Noclip.SpeedNoclip * 0.1
        end
    elseif not pSprint and not pSlow then
        if GM.Admin.Noclip.CamCalculate ~= nil then
            GM.Admin.Noclip.CamCalculate = nil
        end
    end
    if IsControlJustPressed(0, GM.Admin.Noclip.DetailsScalform.speed.control) then
        local input = exports["input"]:openInput({
            label = "Vitesse NoClip",
            submitLabel = "APPLIQUER",
            placeHolders = {
                {label = "Vitesse"},
            }
        })
        GM.Admin.Noclip.SpeedNoclip = tonumber(input["0"]) or 1.0
        GM.Preferences:Save("admin_noclip_speed", GM.Admin.Noclip.SpeedNoclip)
    end
    if IsControlJustPressed(0, GM.Admin.Noclip.DetailsScalform.message.control) then
        -- local input = exports["input"]:openInput({
        --     label = "Annonce de zone",
        --     submitLabel = "ENVOYER",
        --     placeHolders = {
        --         {label = "Message"},
        --         {label = "Radius"}
        --     }
        -- })
        -- TriggerServerEvent("Admin:sendZoneMessage", input["0"], input["1"])
    end
end

function GM.Admin.Noclip:ManageCam()
    local p32, p33, p35, p34 = IsControlPressed(1, 32), IsControlPressed(1, 33), IsControlPressed(1, 35), IsControlPressed(1, 34)
    local g220, g221 = GetDisabledControlNormal(0, 220), GetDisabledControlNormal(0, 221)
    if g220 ~= 0.0 or g221 ~= 0.0 then
        local cRot = GetCamRot(GM.Admin.Noclip.Cam, 2)
        new_z = cRot.z + g220 * -1.0 * 10.0;
        new_x = cRot.x + g221 * -1.0 * 10.0
        SetCamRot(GM.Admin.Noclip.Cam, new_x, 0.0, new_z, 2)
        SetEntityHeading(PlayerPedId(), new_z)
    end
    if p32 or p33 or p35 or p34 then
        local rightVector, forwardVector, upVector = GetCamMatrix(GM.Admin.Noclip.Cam)
        local cPos = (GetCamCoord(GM.Admin.Noclip.Cam)) + ((p32 and forwardVector or p33 and -forwardVector or vector3(0.0, 0.0, 0.0)) + (p35 and rightVector or p34 and -rightVector or vector3(0.0, 0.0, 0.0))) * (GM.Admin.Noclip.CamCalculate ~= nil and GM.Admin.Noclip.CamCalculate or GM.Admin.Noclip.SpeedNoclip)
        SetCamCoord(GM.Admin.Noclip.Cam, cPos)
        SetEntityCoords(PlayerPedId(),cPos)
        SetFocusPosAndVel(cPos)
    end
end

function GM.Admin.Noclip:ExitSpectate()
    local pPed = PlayerPedId()
    if DoesEntityExist(GM.Admin.Noclip.CamTarget.PedHandle) then
        SetCamCoord(GM.Admin.Noclip.Cam, GetEntityCoords(GM.Admin.Noclip.CamTarget.PedHandle))
    end
    NetworkSetInSpectatorMode(0, pPed)
    SetCamActive(GM.Admin.Noclip.Cam, true)
    RenderScriptCams(true, false, 0, true, true)
    GM.Admin.Noclip.CamTarget = {}
    GM.Admin.Noclip.SetScaleformParams(GM.Admin.Noclip.Scalform, GM.Admin.Noclip:ActiveScalform(false))
end

function GM.Admin.Noclip:ScalformSpectate()
    if IsControlJustPressed(0, GM.Admin.Noclip.DetailsInSpec.exit.control) then
        GM.Admin.Noclip:ExitSpectate()
    end
    if GetGameTimer() > GM.Admin.Noclip.Timer then
        GM.Admin.Noclip.Timer = GetGameTimer() + 1000
        SetFocusPosAndVel(GetEntityCoords(GetPlayerPed(GM.Admin.Noclip.CamTarget.id)))
    end
end

function GM.Admin.Noclip:SpecAndPos()
    if not GM.Admin.Noclip.CamTarget.id and IsControlJustPressed(0, GM.Admin.Noclip.DetailsScalform.spectateplayer.control) then
        local qTable = {}
        local CamCoords = GetCamCoord(GM.Admin.Noclip.Cam)
        local pId = PlayerId()
        for k, v in pairs(GetActivePlayers()) do
            local vPed = GetPlayerPed(v)
            local vPos = GetEntityCoords(vPed)
            local vDist = GetDistanceBetweenCoords(vPos, CamCoords)
            if v ~= pId and vPed and vDist <= 20 and (not qTable.pos or GetDistanceBetweenCoords(qTable.pos, CamCoords) > vDist) then
                qTable = {
                    id = v,
                    pos = vPos
                }
            end
        end
        if qTable and qTable.id then
            GM.Admin.Noclip:StartSpectate(qTable)
        end
    end
    if IsControlJustPressed(1, GM.Admin.Noclip.DetailsScalform.gotopos.control) then
        local camActive = GetCamCoord(GM.Admin.Noclip.Cam)
        GM.Admin.Noclip:Spectate(camActive)
    end
end

function GM.Admin.Noclip:RenderCam()
    if not NetworkIsInSpectatorMode() then
        GM.Admin.Noclip:ControlInCam()
        GM.Admin.Noclip:ManageCam()
        GM.Admin.Noclip:SpecAndPos()
    else
        GM.Admin.Noclip:ScalformSpectate()
    end
    if GM.Admin.Noclip.Scalform then
        DrawScaleformMovieFullscreen(GM.Admin.Noclip.Scalform, 255, 255, 255, 255, 0)
    end
    if GetGameTimer() > GM.Admin.Noclip.Timer2 then
        GM.Admin.Noclip.Timer2 = GetGameTimer() + 15000
    end
end

function GM.Admin.Noclip:StartSpectate(player)
    GM.Admin.Noclip.CamTarget = player
    GM.Admin.Noclip.CamTarget.PedHandle = GetPlayerPed(player.id)
    if not DoesEntityExist(GM.Admin.Noclip.CamTarget.PedHandle) then
        ESX.ShowNotification("~r~Vous etes trop loin de la cible.")
        return
    end
    NetworkSetInSpectatorMode(1, GM.Admin.Noclip.CamTarget.PedHandle)
    SetCamActive(GM.Admin.Noclip.Cam, false)
    RenderScriptCams(false, false, 0, false, false)
    GM.Admin.Noclip.SetScaleformParams(GM.Admin.Noclip.Scalform, GM.Admin.Noclip:ActiveScalform(true))
    ClearFocus()
end

function GM.Admin.Noclip:CreateCam()
    GM.Admin.Noclip.Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(GM.Admin.Noclip.Cam, true)
    RenderScriptCams(true, false, 0, true, true)
    GM.Admin.Noclip.Scalform = GM.Admin.Noclip.CreateScaleform("INSTRUCTIONAL_BUTTONS", GM.Admin.Noclip:ActiveScalform())
end

function GM.Admin.Noclip:DestroyCam()
    DestroyCam(GM.Admin.Noclip.Cam)
    RenderScriptCams(false, false, 0, false, false)
    ClearFocus()
    SetScaleformMovieAsNoLongerNeeded(GM.Admin.Noclip.Scalform)
    if NetworkIsInSpectatorMode() then
        NetworkSetInSpectatorMode(false, GM.Admin.Noclip.CamTarget.id and GetPlayerPed(GM.Admin.Noclip.CamTarget.id) or 0)
    end
    GM.Admin.Noclip.Scalform = nil
    GM.Admin.Noclip.Cam = nil
    lockEntity = nil
    GM.Admin.Noclip.CamTarget = {}
end

function GM.Admin.Noclip:Spectate(pPos)
    local player = PlayerPedId()
    local pPed = player
    GM.Admin.Noclip.InSpec = not GM.Admin.Noclip.InSpec
    GM.Admin.Noclip.SpeedNoclip = tonumber(GM.Preferences:loadPreferences("admin_noclip_speed")) or 0.6
    ESX.ShowNotification("~b~Vitesse du noclip définie à ("..GM.Admin.Noclip.SpeedNoclip..") d'après vos préférences.")
    Wait(0)
    if not GM.Admin.Noclip.InSpec then
        GM.Admin.NoclipActive = false
        GM.Admin.Noclip:DestroyCam()
        if GM.Admin.Noclip.Invisiblity then
            SetEntityVisible(pPed, false)
        else
            SetEntityVisible(pPed, true)
        end
        SetEntityInvincible(pPed, false)
        SetEntityCollision(pPed, true, true)
        FreezeEntityPosition(pPed, false)
        if pPos then
            local pPed = PlayerPedId()
            local pCoords = GetEntityCoords(pPed)
            local get, z = GetGroundZFor_3dCoord(pCoords.x, pCoords.y, pCoords.z, true, 0)
            if get then
                SetEntityCoordsNoOffset(PlayerPedId(), pCoords.x, pCoords.y, z + 1.0, 0.0, 0.0, 0.0)
            end
        end
    else
        GM.Admin.NoclipActive = true
        GM.Admin.Noclip:CreateCam()
        SetEntityVisible(pPed, false, false)
        SetEntityInvincible(pPed, true)
        SetEntityCollision(pPed, false, false)
        FreezeEntityPosition(pPed, true)
        SetCamCoord(GM.Admin.Noclip.Cam, GetEntityCoords(player))
        CreateThread(function()
            while GM.Admin.Noclip.InSpec do
                if (not GM.Admin.inAdmin) then
                    GM.Admin.Noclip.InSpec = false
                    GM.Admin.NoclipActive = false
                    GM.Admin.Noclip:DestroyCam()
                    if GM.Admin.Noclip.Invisiblity then
                        SetEntityVisible(pPed, false)
                    else
                        SetEntityVisible(pPed, true)
                    end
                    SetEntityInvincible(pPed, false)
                    SetEntityCollision(pPed, true, true)
                    FreezeEntityPosition(pPed, false)
                    break
                end
                Wait(0)
                GM.Admin.Noclip:RenderCam()
            end
        end)
    end
end

RegisterNetEvent("Admin:noClip", function()
    print("Admin:noClip")
    GM.Admin.Noclip:Spectate()
end)

function GetSpecateBoolStaff()
    return GM.Admin.NoclipActive
end

RegisterNetEvent("Admin:setCameraCoords", function(coords)
    if (GetSpecateBoolStaff()) then
        SetCamCoord(Admin.Cam, coords)
    end
end)

RegisterNetEvent("Admin:spectatePlayer", function(player)
    if (not GM.Admin.NoclipActive) then
        GM.Admin.Noclip:Spectate()
    end
    GM.Admin.Noclip.CamTarget = player
    GM.Admin.Noclip.CamTarget.PedHandle = GetPlayerPed(player.id)
    if not DoesEntityExist(GM.Admin.Noclip.CamTarget.PedHandle) then
        ESX.ShowNotification("~r~Vous etes trop loin de la cible.")
        return
    end
    NetworkSetInSpectatorMode(1, GM.Admin.Noclip.CamTarget.PedHandle)
    SetCamActive(GM.Admin.Noclip.Cam, false)
    RenderScriptCams(false, false, 0, false, false)
    GM.Admin.Noclip.SetScaleformParams(GM.Admin.Noclip.Scalform, GM.Admin.Noclip:ActiveScalform(true))
    ClearFocus()
end)