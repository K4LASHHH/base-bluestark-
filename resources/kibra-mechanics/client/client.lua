local Blips = {}
local cursor = false 
local mechanicId = 0
local pVehicle = nil 
local aracilkplate = nil
local openm = false
local bossMenu = false
local lastVehData = nil
local lastVehMeme = nil
local PlayerName = "Abuzer Kömürcü"
local PlayerData = {}
local plate = nil
local s = {}
local truckmenu = false
local AracCikardim = false
local MechanicAcik = false
local calisanlarTable = {} 
local mevcutColorMenu = nil
local KIBRA = exports["kibra-core"]:GetCore()
local modifiePart = 0 
local currentPlate = nil
local Ahsen = 0
local AdezTR = 0

if Config.UseKibraVehicleShop then
    getVehicleShopVehicles = exports["kibra-vehicleshops"]:GetVehicles()
end

local function parcaUcretEndeksleme(vehicle)
    local modelHash = GetEntityModel(vehicle)
    local modelName = GetDisplayNameFromVehicleModel(modelHash)
    local vehicleFiyat = 0
    vehicle = string.lower(modelName)
    if Config.UseKibraVehicleShop then
        for k,v in pairs(getVehicleShopVehicles) do
            for ercument,cozer in pairs(v.Vehicles) do
                if cozer.Model == vehicle then
                    vehicleFiyat = cozer.Price
                end
            end
        end
    end
    return vehicleFiyat
end

Citizen.CreateThread(function()    
    while true do
        Wait(1000)
        if NetworkIsPlayerActive(PlayerId()) then
            TriggerServerEvent('kibra:Mechanics:Server:RequestMechanicData')
            Wait(2000)
            ClearBlips()
            CreateBlip()
            break
        end
        PlayerData = KIBRA.Natives.GetPlayerData()
    end
end)

RegisterNetEvent('Kibra:Mechanics:Client:SetName', function(name)
    PlayerName = name
end)

if KIBRA.Natives.GetFramework() == "ESX" then
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)
else
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerData.job = JobInfo
    end)
end

RegisterNetEvent('kibra:Mechanics:Client:UpdateMechanics', function(data)
    Config.Mechanics = data
    ClearBlips()
    CreateBlip()
end)

RegisterNetEvent('kibra:Mechanics:Client:CloseOff', function()
    SendNUIMessage{
        type = "Almayacam"
    }
end)

function JobCheck(mechID)
    local check = false

    if not Config.MechanicsCompany or mechID == 0 then
        check = true
    end

    local jobName = Config.Mechanics[mechID].JobName
    local job = KIBRA.Natives.GetPlayerData().job
    if job and job.name == jobName then
        check = true
    end

    return check
end

RegisterNUICallback("ModLoad", function(tbl) UpdateMods(tbl) end)

MekanikUrunSepeti = {}

SepeteUrunEkle = function(info)
    info.modprice = tonumber(info.modprice)
    local modname = ICONS[info.modtype].label
    if MekanikUrunSepeti[info.modtype] then
        MekanikUrunSepeti[info.modtype].mod = info.mod 
        MekanikUrunSepeti[info.modtype].price = info.modprice 
        MekanikUrunSepeti[info.modtype].modname = modname 
    else
        MekanikUrunSepeti[info.modtype] = { mod = info.mod, price = info.modprice, type = info.modtype, modname = ICONS[info.modtype].label}
    end  
end

PlateAddBasket = function(info)
    info.modprice = tonumber(info.modprice)
    local modname = Config.Text["LicensePlate"]
    if MekanikUrunSepeti[info.modtype] then
        MekanikUrunSepeti[info.modtype].mod = info.mod 
        MekanikUrunSepeti[info.modtype].price = info.modprice 
        MekanikUrunSepeti[info.modtype].modname = modname 
    else
        MekanikUrunSepeti[info.modtype] = { mod = info.mod, price = info.modprice, type = info.modtype, modname = Config.Text["LicensePlate"]}
    end  
end

UpdateMods = function(data)
    PlaySound(PlayerId(), "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local JobCheck = JobCheck(mechanicId)
    if JobCheck then
        if data.modtype then
            if data.modtype == "plate" or data.modtype == "plateIndex" or data.modtype == "wheelcolor" or data.modtype == "tyreSmokeColor" or data.modtype == "neonColor" then
                data.modtype = tostring(data.modtype)
                if data.modtype == "plate" then
                    KIBRA.Natives.TriggerCallback('kibra:Mechanics:CheckPlate', function(export)      
                        if export then 
                            if string.len(data.mod) >= Config.PlateMinimumLetter then 
                                PlateAddBasket(data)
                            else
                                MechNotify('error', Config.Text["YetersizHarf"]..'('..Config.PlateMinimumLetter..')')
                                return 
                            end
                        else
                            MechNotify('error', Config.Text["ThisBelongsAnother"])
                        end
                    end, data.mod)
                end
            else
                data.modtype = tonumber(data.modtype)
            end
            local props = {}
            if data.modtype == 17 then 
                props["modTurbo"] = true
            elseif data.modtype  == 49 then
                props["modXenon"] = true
                props["xenonColor"] = tonumber(data.mod)
            elseif data.modtype == "plate" then
                if string.len(data.mod) >= Config.PlateMinimumLetter then 
                    KIBRA.Natives.SetPlate(vehicle, data.mod)
                else
                    MechNotify('error', Config.Text["YetersizHarf"]..'('..Config.PlateMinimumLetter..')')
                end
            elseif data.modtype == 15677 then
                props["windowTint"] = tonumber(data.mod)
            elseif data.modtype == "tyreSmokeColor" then
                kisattim = Neons[tonumber(data.mod)]
                props['modSmokeEnabled'] = true
                props["tyreSmokeColor"] = {kisattim.r, kisattim.g, kisattim.b}
            elseif data.modtype == "plateIndex" then                 
                SetVehicleNumberPlateTextIndex(vehicle, tonumber(data.mod))
            else
                props[data.modcengiz] = tonumber(data.mod)
            end
            KIBRA.Natives.SetVehicleProps(vehicle, props)
            props = {}
            MechNotify("success", Config.Text["transactionsuccessful"])
            LoadAndRefreshMenu({type = data.modtype})
            if data.modtype == 14 then StartVehicleHorn(vehicle, 500, GetHashKey("normal"), 0) end
            if data.modtype ~= "plate" then SepeteUrunEkle(data) end
        end
    else
        MechNotify("error", Config.Text["YourNotAuthorized"])
    end
end

RegisterNUICallback("LoadMenu", function(data) LoadAndRefreshMenu(data) end)

LoadAndRefreshMenu = function(data)
    PlaySound(PlayerId(), "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    propsVehicle = KIBRA.Natives.GetVehicleProps(vehicle)
    if data.type ~= "plateIndex" then
        data.type = tonumber(data.type)
    end
    if data.type then
        if data.type == 17 then
            icon = ICONS[data.type].icon
            SendNUIMessage({
                type = "LoadMenu",
                menu = 1,
                icon = icon,
                butarzbenim = ICONS,
                lang = Config.Text,
                parcaid = ICONS[data.type].id,
                modType = 17,
                props = propsVehicle,
                kibraSubMenu = kibraSubMenus, 
            })    
        elseif data.type == 2004 then
            SendNUIMessage{
                type = "loadSubMenu",
                subMenu = VehicleColorMenu
            }
        elseif data.type == 1996 then
            mevcutColorMenu = "color1"
            OpenColorMenu(MechanicColors, ICONS[data.type].icon, data.type, "renkturleri", "AnaRenkMenusu", "color1", ICONS[data.type].label)
        elseif data.type == 1997 then
            mevcutColorMenu = "color2"
            OpenColorMenu(MechanicColors, ICONS[data.type].icon, data.type, "renkturleri", "AnaRenkMenusu", "color2", ICONS[data.type].label)
        elseif data.type == 1998 then
            mevcutColorMenu = "pearlescentColor"
            OpenColorMenu(MechanicColors, ICONS[data.type].icon, data.type, "renkturleri", "AnaRenkMenusu", "pearlescentColor", ICONS[data.type].label)
        elseif data.type == 1766  then
            OpenColorMenu(Neons, ICONS[data.type].icon, data.type, "tekerlekmenusu", "RGBRenkler", "tyreSmokeColor", ICONS[data.type].label)
        elseif data.type == 1986 then
            OpenColorMenu(Neons, ICONS[data.type].icon, data.type, "mainmenu", "RGBRenkler", "neonColor", ICONS[data.type].label)
        elseif data.type == 1000 then
            SendNUIMessage{
                type = "loadSubMenu",
                subMenu = BodyParts,
                yukseklik = "0.2vh"
            }
        elseif data.type == 5 or data.type == 8 or data.type == 9 then
            icon = ICONS[data.type].icon
            local cengiz = function(value)
                return GetModTextLabel(vehicle, data.type, value)
            end
            datalar = {}
            local modCount = GetNumVehicleMods(vehicle, data.type)
            for i = 0, modCount, 1 do
                local modName = GetModTextLabel(vehicle, data.type, i) 
                datalar[i] = {label = GetLabelText(modName), modName = modName}
            end
            SendNUIMessage({
                type = "LoadMenu",
                menu = modCount,
                icon = icon,
                tekerlenk = datalar,
                butarzbenim = ICONS,
                lang = Config.Text,
                parcaid = ICONS[data.type].id,
                modType = data.type,
                props = propsVehicle,
                kibraSubMenu = kibraSubMenus, 
            })
        elseif data.type == 23 then
            local props = {}
            props['wheels'] = tonumber(data.whtyp)
            KIBRA.Natives.SetVehicleProps(vehicle, props)
            icon = ICONS[data.type].icon
            SetVehicleModKit(vehicle, 0)
            cengi = function(value)
                return GetModTextLabel(vehicle, data.type, value)
            end
            tekerlenk = {}
            local modCount = GetNumVehicleMods(vehicle, data.type)
            for i = 0, modCount, 1 do
                local modName = GetModTextLabel(vehicle, data.type, i) 
                tekerlenk[i] = {label = GetLabelText(modName), modName = modName}
            end
            SendNUIMessage({
                type = "LoadMenu",
                menu = modCount,
                icon = icon,
                back = ICONS[data.type].menu,
                tekerlenk = tekerlenk,
                butarzbenim = ICONS,
                lang = Config.Text,
                parcaid = ICONS[data.type].id,
                modType = data.type,
                props = propsVehicle,
                kibraSubMenu = kibraSubMenus, 
            })
        elseif data.type == 67000 then
            SendNUIMessage{
                type = "loadSubMenu",
                subMenu = WheelsCategory,
                back = "tekerlekmenusu",
                yukseklik = "0.2vh",
            }
        elseif data.type == 990112 then
            SendNUIMessage{
                type = "loadSubMenu",
                subMenu = Wheels.wheels,
                yukseklik = "0.2vh",
            }
        elseif data.type == 1300 then
            OpenColorMenu(MechanicColors, ICONS[data.type].icon, data.type, "tekerlekmenusu", "AnaRenkMenusu", "wheelColor", ICONS[data.type].label)
        elseif data.type == 11 or data.type == 12 or data.type == 13 or data.type == 15 or data.type == 16 then
            icon = ICONS[data.type].icon
            if data.type == 13 then backx = "back2" else backx = "back" end
            local modCount = GetNumVehicleMods(vehicle, data.type) -- UPGRADES
            SetVehicleModKit(vehicle, 0)
            SendNUIMessage({
                type = "LoadMenu",
                menu = modCount,
                icon = icon,
                back = backx,
                butarzbenim = ICONS,
                lang = Config.Text,
                parcaid = ICONS[data.type].id,
                modType = data.type,
                props = propsVehicle,
                kibraSubMenu = kibraSubMenus, 
            })
        else
            local modCount = GetNumVehicleMods(vehicle, data.type) -- BODYPARTS
            if data.type == 49 then
                SetVehicleLights(pVehicle, 2)
            end
            if data.type == 15677 then modCount = 5 elseif data.type == 49 then modCount = 12 end
            local menu = "back"
            if ICONS[data.type] then
                if ICONS[data.type].menu then
                    menu = ICONS[data.type].menu
                end
            end
            icon = ICONS[data.type].icon
            SendNUIMessage({
                type = "LoadMenu",
                menu = modCount,
                icon = icon,
                butarzbenim = ICONS,
                lang = Config.Text,
                back = menu,
                parcaid = ICONS[data.type].id,
                modType = data.type,
                props = propsVehicle,
                kibraSubMenu = kibraSubMenus, 
            })
        end
        if ICONS[data.type] then
            if ICONS[data.type].kamera then
                camControl(ICONS[data.type].kamera)
            end
        end
    end
end

RegisterNUICallback('SpawnTownTruck', function(data)
    if not AracCikardim then
        if KIBRA.Natives.GetAvailableVehicleSpawnPoint(Config.Mechanics[mechanicId].TownTruckSpawnCoord) then
            if GetVehicleModelValue(data.carmodel) then
                local model = data.carmodel
                RequestModel(GetHashKey(model))
                while not HasModelLoaded(GetHashKey(model)) do
                    Wait(1)
                end
                TowTruckxBaba = CreateVehicle(model, Config.Mechanics[mechanicId].TownTruckSpawnCoord, true, true)
                KIBRA.Natives.SetPlate(TowTruckxBaba, "MECHANIC")
                SetPedIntoVehicle(PlayerPedId(), TowTruckxBaba, -1)
                if Config.UseVehicleKeys then
                    TriggerEvent(Config.VehicleKeysEvent, "MECHANIC")
                end
                MechNotify('success', Config.Text["SuccessIntoOut"])
                SendNUIMessage{type = "Towtruckkapat"}
                SetNuiFocus(false, false)
                TriggerScreenblurFadeOut(150)
                AracCikardim = true
            else
                MechNotify('error', Config.Text["VehicleModelNotFound"])
            end
        else
            MechNotify('error', Config.Text["AnyGetGehicle"])
        end
    else
        MechNotify('error', Config.Text["AlreadyOutVehicle"])
    end
end)

TowTruck = function()
    local alreadyEnteredZone = false 
    while true do
        local Sleep = 2000
        local playerPed = PlayerPedId()
        local inZone = false 
        for k,v in pairs(Config.Mechanics) do
            local c = #(GetEntityCoords(playerPed) - v.VehicleSpawn)
            if c <= 2.0 then
                Sleep = 5
                if JobCheck(k) then
                    if not truckmenu then
                        inZone = true
                        DrawMarker(21, v.VehicleSpawn.x, v.VehicleSpawn.y, v.VehicleSpawn.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.55, 10, 223, 216, 155, false, false, false, 1, false, false, false)
                        if IsControlJustReleased(0, Config.TowTruckSpawnKey) then
                            OpenTowTruckMenu(k)
                        end
                    end
                end
            elseif c <= 7.0 then
                Sleep = 5
                DrawMarker(21, v.VehicleSpawn.x, v.VehicleSpawn.y, v.VehicleSpawn.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.55, 10, 223, 216, 155, false, false, false, 1, false, false, false)
            end
        end

        if not alreadyEnteredZone and inZone then
            alreadyEnteredZone = true 
            Config.Show(Config.Opens["VehicleSpawn"][1], Config.Opens["VehicleSpawn"][2])
        end

        if alreadyEnteredZone and not inZone then
            alreadyEnteredZone = false 
            Config.Hide()
        end

        Citizen.Wait(Sleep)
    end
end

TowTruckEnter = function()
    local alreadyEnteredZone = false 
    while true do
        local Sleep = 2000
        local playerPed = PlayerPedId()
        local inZone = false 
        for k,v in pairs(Config.Mechanics) do
            local c = GetDistanceBetweenCoords(GetEntityCoords(playerPed), v.TownTruckSpawnCoord, false)
            if IsPedInAnyVehicle(PlayerPedId(),false) then
                if c <= 2.0 then
                    Sleep = 5
                    if JobCheck(k) then
                        inZone = true
                        DrawMarker(21, v.TownTruckSpawnCoord.x, v.TownTruckSpawnCoord.y, v.TownTruckSpawnCoord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.55, 10, 223, 216, 155, false, false, false, 1, false, false, false)
                        if IsControlJustReleased(0, Config.TowTruckSpawnKey) then
                            if KIBRA.Natives.GetPlate(GetVehiclePedIsIn(playerPed, false)) == 'MECHANIC' then
                                TaskLeaveVehicle(playerPed, GetVehiclePedIsIn(playerPed, false), 64)
                                Wait(3400)
                                DeleteVehicle(TowTruckxBaba)
                                truckmenu = false
                                AracCikardim = false
                            else
                                MechNotify('error', Config.Text["ThisVehicleNotBelongMechanic"])
                            end
                        end
                    end
                elseif c <= 7.0 then 
                    Sleep = 5
                    DrawMarker(21, v.TownTruckSpawnCoord.x, v.TownTruckSpawnCoord.y, v.TownTruckSpawnCoord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.55, 10, 223, 216, 155, false, false, false, 1, false, false, false)
                end
            end
        end

        if not alreadyEnteredZone and inZone then
            alreadyEnteredZone = true 
            Config.Show(Config.Opens["EnterTowTruck"][1], Config.Opens["EnterTowTruck"][2])
        end

        if alreadyEnteredZone and not inZone then
            alreadyEnteredZone = false 
            Config.Hide()
        end

        Citizen.Wait(Sleep)
    end
end

OpenTowTruckMenu = function(id)
    mechanicId = id
    truckmenu = true
    SendNUIMessage{
        type = "OpenTowTruckMenu",
        vehicles = Config.TowTrucks,
    }
    TriggerScreenblurFadeIn(150)
    SetNuiFocus(true, true)
end

RegisterNUICallback('NeonRemove', function()
    local props = {}
    props["neonColor"] = {0, 0, 0}
    KIBRA.Natives.SetVehicleProps(pVehicle, props)
    MechNotify('success', Config.Text["RemovedNeon"])
end)

RegisterNUICallback("MenuBack", function()
    ResetCam()
    SendNUIMessage({
        type = "RefreshMenu",
        mechanicmenu = kibraMechanicMenu
    })
end)

RegisterNUICallback("MenuBack2", function()
    ResetCam()
    SendNUIMessage({
        type = "LoadSubMenuV",
        mechanicmenu = BodyParts
    })
end)

RegisterNUICallback("TekerlekMenusu", function()
    ResetCam()
    SendNUIMessage{
        type = "loadSubMenu",
        subMenu = Wheels.wheels,
        yukseklik = "0.2vh"
    }
end)

RegisterNUICallback("RenkTurleri", function()
    ResetCam()
    SendNUIMessage{
        type = "loadSubMenu",
        subMenu = VehicleColorMenu,
        yukseklik = "0.2vh",
    }
end)


RegisterNUICallback("MenuBack3", function()
    SendNUIMessage{
        type = "loadSubMenu",
        subMenu = WheelsCategory,
        yukseklik = "0.2vh"
    }
end)

RegisterNUICallback("MenuBack4", function()
    ResetCam()
    SendNUIMessage{
        type = "loadSubMenu",
        subMenu = Wheels.wheels,
        yukseklik = "0.2vh",
    }
end)

RegisterNUICallback("UstRenkleriYukle", function()
    ResetCam()
    OpenColorMenu(MechanicColors, ICONS[1996].icon, 1996, "renkturleri", "AnaRenkMenusu", "color1", ICONS[1996].label)
end)


RegisterNUICallback('AltRenkMenusuSec', function(data)
    data.modtype = tonumber(data.modtype)
    OpenColorMenu(
        GetColors(data.color),
        ICONS[data.modtype].icon,
        data.modtype,
        data.backmenu,
        "AltRenkMenusu",
        data.menuStringID,
        ICONS[data.modtype].label
    )
end)

OpenColorMenu = function(table, icon, modtype, backMenu, menutype, stringMenuID, modname)
    SendNUIMessage{
        type = "requestColorTable",
        table = table,
        icon = icon, 
        modtype = modtype,
        modname = modname,
        backMenu = backMenu,
        menuType = menutype,
        menuStringID = stringMenuID
    }
end

RegisterNUICallback('RenkUpload', function(data)
    local PlayerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local jsonModName = ICONS[tonumber(data.modtype)].id
    local pVehProps = KIBRA.Natives.GetVehicleProps(PlayerVehicle)
    -- SetVehicleModColor_1(PlayerVehicle, 0, 0, 0)
    local modprice = tonumber(data.renkFiyat)
    local props = {}
    local JobCheck = JobCheck(mechanicId)
    if JobCheck then
        if jsonModName == "wheelColor" then
            props[jsonModName] = tonumber(data.color)
        elseif jsonModName == "tyreSmokeColor" then
            kisattim = Neons[tonumber(data.color)]
            props['modSmokeEnabled'] = true
            props["tyreSmokeColor"] = {kisattim.r, kisattim.g, kisattim.b}
        elseif jsonModName == "neonColor" then
            kisattim = Neons[tonumber(data.color)]
            if kisattim.r == 0 and kisattim.g == 0 and kisattim.b == 0 then
                props['neonEnabled'] = {false, false, false, false}
            else
                props['neonEnabled'] = {true, true, true, true}
            end
            props["neonColor"] = {kisattim.r, kisattim.g, kisattim.b}
        elseif jsonModName == "color1" then
            SetVehicleModKit(PlayerVehicle, 1)
            Wait(500)
            props["color1"] = data.color
            KIBRA.Natives.SetVehicleProps(PlayerVehicle, props)
        end
        KIBRA.Natives.SetVehicleProps(PlayerVehicle, props)
        props = {}
        SepeteUrunEkle({modtype = tonumber(data.modtype),mod = tonumber(data.color),modprice = modprice, modname = data.modname})
        MechNotify("success", Config.Text["transactionsuccessful"])
    else
        MechNotify("error", Config.Text["YourNotAuthorized"])
    end
end)

exColor = {}
newColor = {}

getvehiclecolor = nil

OpenMechanic = function(id, modifiedPart)
    modifiePart = modifiedPart
    BEN = tonumber(GetPlayerServerId(PlayerId()))
    local PlayerPed = PlayerPedId()
    Close = false
    Config.HideHud()
    DisplayRadar(false)
    mechanicId = id
    MechanicAcik = true
    if not IsPedInAnyVehicle(PlayerPed, false) then return end
    local PlayerVehicle = GetVehiclePedIsIn(PlayerPed, false)
    pVehicle = PlayerVehicle
    SetVehicleRadioEnabled(pVehicle, false)
    plate = KIBRA.Natives.GetPlate(pVehicle)
    TriggerServerEvent('kibra:Mechanics:Server:ModifiyeEdilenArac', PlayerVehicle, modifiedPart, plate, id)
    local VehicleP = KIBRA.Natives.GetVehicleProps(PlayerVehicle)
    currentPlate = VehicleP.plate
    getvehiclecolor = {VehicleP.color1, VehicleP.color2}
    if GetIsVehiclePrimaryColourCustom(PlayerVehicle) then
        exColor  = {r = VehicleP["customPrimaryColor"][1], g = VehicleP["customPrimaryColor"][2], b = VehicleP["customPrimaryColor"][3]}
    end
    local speed = GetVehicleHandlingFloat(PlayerVehicle,"CHandlingData","fInitialDriveMaxFlatVel")
    -- if speed < 0 then speed = GetVehicleModelEstimatedMaxSpeed(GetEntityModel(PlayerVehicle)) end
    local acceleration = GetVehicleHandlingInt(PlayerVehicle, "CHandlingData", "fSteeringLock")
    local brake = GetVehicleMaxBraking(PlayerVehicle)
    local maxspeed = nil 
    SetEntityMaxSpeed(PlayerPedId(), 500.0)
    brake = math.ceil(brake * 50.6)
    ms = math.ceil(speed * 2.23693629)
    mph = math.ceil(speed * 2.23693629)
    kmh = math.ceil(speed * 1)
    if Config.VehicleSpeedUnit == "km/h" then maxspeed = kmh elseif Config.VehicleSpeedUnit == "mph" then maxspeed = mph else maxspeed = ms end
    local carinfo = {
        maxspeed = maxspeed,
        carweight = GetVehicleHandlingInt(PlayerVehicle, "CHandlingData", "fMass"),
        brake = brake,
        handling = GetVehicleHandlingInt(PlayerVehicle, "CHandlingData", "fInitialDriveMaxFlatVel"),
        accelerationx = acceleration*2
    }
    local ucret = Calculator(id)
    SendNUIMessage({
        type = "OpenMechanic",
        data = VehicleP,
        cfg = Config.Text,
        company = Config.MechanicsCompany,
        mousetext = Config.MouseActiveKeyText,
        kibraSubMenu = kibraSubMenus, 
        lang = Config.Text,
        vehicleshop = Config.UseKibraVehicleShop,
        id = id,
        colorType = colorTypeMenu,
        plateDegistirilebilemez = Config.PlateInterchangeability,
        vehicleColor1 = 1,
        vehiclePrice = parcaUcretEndeksleme(PlayerVehicle),
        aracparcaoran = Config.VehicleBodyPartsPriceRatio,
        aracOran = Config.VehiclePriceToPartPriceRatio,
        rgbColorPrice = Config.RGBColorPrice,
        vehicleColor2 = 2,
        vehicleColor3 = 3,
        freeEmployee = Config.EmployeesFreeDiscount,
        mech = ICONS,
        rgbColor = Config.UseRGBColor,
        plate = plate,
        fixucret = ucret,
        plateSpace = Config.PlateSpace,
        plateprice = Config.PlateReplacementFee,
        modelname = GetDisplayNameFromVehicleModel(VehicleP.model),
        CarInfo = carinfo,        
        imdat = Config.VehicleSpeedUnit,
        mechanicmenu = kibraMechanicMenu
    })
    -- Cam
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    gameplaycam = GetRenderingCam()
    
    -- Cam
    lastVehData = VehicleP
    local primaryColor, secondaryColor = GetVehicleColours(pVehicle)
    local r, g, b = GetVehicleCustomPrimaryColour(pVehicle)
    lastVehMeme = {
        model = VehicleP.model,
        plate = VehicleP.plate,
        color1 = primaryColor,
        color2 = secondaryColor,
        fuel = GetVehicleFuelLevel(pVehicle),
        r = r,
        g = g,
        b = b
    }
    Config.Hide()
    FreezeEntityPosition(PlayerVehicle, true)
    SetNuiFocus(true, true) 
end

RegisterNUICallback('LoadColorType', function(data)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if not DoesEntityExist(vehicle) or not IsEntityAVehicle(vehicle) then
        return
    end 

    local props = {}

    if tonumber(data.type) == 1996 then
        SetVehicleModColor_1(vehicle, tonumber(data.typeV1))
    elseif tonumber(data.type) == 1997 then
        SetVehicleModColor_2(vehicle, tonumber(data.typeV1))
    end
 
    props.color1, props.color2 = GetVehicleColours(vehicle)
    KIBRA.Natives.SetVehicleProps(vehicle, props)
end)

RegisterNUICallback('RGBLoad', function(data)
    if not data then
        return
    end
    
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if not DoesEntityExist(vehicle) or not IsEntityAVehicle(vehicle) then
        return
    end

    local propsRa = {}
    local getcolor = "color1"
    SetVehicleModKit(vehicle, 0)
    data.type = tonumber(data.type)
    local r, g, b = tonumber(data.r), tonumber(data.g), tonumber(data.b)
    if data.type == 1996 then
        propsRa.customPrimaryColor = {r, g, b}
        SetVehicleCustomPrimaryColour(vehicle, r, g, b)
    elseif data.type == 1997 then
        propsRa.customSecondaryColor = {r, g, b}
        getcolor = "color2"
        SetVehicleCustomSecondaryColour(vehicle, r, g, b)
    elseif data.type == 1998 then
        SetVehicleExtraColours(vehicle, r, g, b)
        getcolor = "pearlescentColor"
    elseif data.type == 1986 then
        propsRa['neonEnabled'] = {true, true, true, true}
        propsRa["neonColor"] = {r, g, b}
    elseif data.type == 1766 then
        propsRa['modSmokeEnabled'] = true
        propsRa["tyreSmokeColor"] = {r, g, b}
    end
    
    SepeteUrunEkle({
        modtype = tonumber(data.type),
        mod = "RGB Color",
        modprice = kibraSubMenus[getcolor].priceDefault,
        modname = ICONS[tonumber(data.type)].label
    })
    
    KIBRA.Natives.SetVehicleProps(vehicle, propsRa)
end)


function GetRGBFromHex(hex)
    hex = hex:gsub("#","")
    local r = tonumber(hex:sub(1,2), 16)
    local g = tonumber(hex:sub(3,4), 16)
    local b = tonumber(hex:sub(5,6), 16)
    return r, g, b
end

Calculator = function(id)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local props = KIBRA.Natives.GetVehicleProps(vehicle)
    local Tank = props.tankHealth
    local Motor = props.engineHealth
    local Body = props.bodyHealth
    local NetMotor = 1000.0 - Motor
    local NetTank = 1000.0 - Tank 
    local NetBody = 1000.0 - Body 
    local Total = (NetMotor + NetTank + NetBody) * 3.5 + (Config.Mechanics[id].VehicleRepairAndCleaningLaborPrice)
    return math.floor(Total)
end

RegisterNUICallback("CursorActive", function()
    if MechanicAcik then
        if not cursor then
            cursor = true
            SetNuiFocusKeepInput(true)
            MechNotify("success", Config.Text["ActivateMouse"])
        else
            cursor = false
            SetNuiFocusKeepInput(false)
            MechNotify("success", Config.Text["DisableMouse"])
        end
    end
end)

RegisterNUICallback("BireyselOdeme", function(data)
    KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:CheckPMoney', function(export)
        if export then
            if Config.AutoPropsUpdate then
                vehicleJ = KIBRA.Natives.GetVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                TriggerServerEvent('kibra:Mechanics:Server:VehicleUpdateProps2', vehicleJ, currentPlate, modifiePart, mechanicId)
            end
            if data.mod == "CarFixClean" then
                TriggerServerEvent('kibra:Mechanics:Server:Tamir', pVehicle, modifiePart, mechanicId, currentPlate)
            elseif data.mod == "plate" then
                TriggerServerEvent('kibra:Mechanics:Server:PlateVar', data.icerik, currentPlate)
            end
            MechanicAcik = false
            MechNotify('success', Config.Text["SuccessKanks"])
            TriggerServerEvent('PlayerMoneyRemove', tonumber(data.TotalUcret))
            BasariliMuck()
        else
            MechNotify('error', Config.Text["YouHaveEnoughMoney"])
        end
    end, GetPlayerServerId(PlayerId()), tonumber(data.TotalUcret), true)
end)

RegisterNUICallback("BireyselFatura", function()
    if next(MekanikUrunSepeti) ~= nil then
        for k,v in pairs(MekanikUrunSepeti) do
            table.insert(s, {ModName = MekanikUrunSepeti[k].modname, Mod = MekanikUrunSepeti[k].mod, Price = MekanikUrunSepeti[k].price, Type = MekanikUrunSepeti[k].type})
        end
        TriggerScreenblurFadeIn(150)
        local datax = {
            sepet = s, 
            PlayerName = PlayerName, 
            mechanicName = Config.Mechanics[mechanicId].MechanicName,
        }
        SendNUIMessage({type = "OpenBireyselFatura", data = datax})
    else
        MechNotify('error', Config.Text["NotChanges"])        
    end
end)

RegisterNUICallback('OpenPlate', function()
    SendNUIMessage{
        type = "PlateChangeTemplate",
        plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
    }
end)

RegisterCommand('caradmin', function()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    TriggerServerEvent('kibra:SetVehicleOwner', KIBRA.Natives.GetVehicleProps(veh))
end)

MechNotify = function(typex, text)
    SendNUIMessage({
        type = "Notify",
        text = text,
        typex = typex
    })
end

RegisterNetEvent('kibra:Mechanics:UI:Notify', function(typex, text)
    MechNotify(typex, text)
end)

RegisterNUICallback("OpenAllDoors", function()
    local doors = {0,1,2,3,4,5,6,7}
    local PlayerPed = PlayerPedId()
    if not IsPedInAnyVehicle(PlayerPed, false) then return end
    local playerVeh = GetVehiclePedIsIn(PlayerPed, false)
    for k,v in pairs(doors) do
        if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
            SetVehicleDoorShut(playerVeh, 5, false)        
            SetVehicleDoorShut(playerVeh, 4, false)
            SetVehicleDoorShut(playerVeh, 3, false)
            SetVehicleDoorShut(playerVeh, 2, false)
            SetVehicleDoorShut(playerVeh, 1, false)
            SetVehicleDoorShut(playerVeh, 0, false)         
          else
            SetVehicleDoorOpen(playerVeh, 5, false)        
            SetVehicleDoorOpen(playerVeh, 4, false)
            SetVehicleDoorOpen(playerVeh, 3, false)
            SetVehicleDoorOpen(playerVeh, 2, false)
            SetVehicleDoorOpen(playerVeh, 1, false)
            SetVehicleDoorOpen(playerVeh, 0, false)  
         end
    end
end)

RegisterNUICallback("CloseMechanic", function()
    freeCam()
    camControl("reset")
    MechanicAcik = false
    Config.OpenHud()
    SetNuiFocus(false, false)
    Close = true
    openm = false
    truckmenu = false
    MekanikUrunSepeti = {}
    TriggerServerEvent('ServerDeleteCarMods', modifiePart, mechanicId, currentPlate)
    mechanicId = 0
    DisplayRadar(true)
    s = {}
    local PlayerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    local r, g, b = GetVehicleCustomPrimaryColour(PlayerVehicle)
    if r ~= lastVehMeme.r or g ~= lastVehMeme.g or b ~= lastVehMeme.b then
        SetVehicleCustomPrimaryColour(PlayerVehicle, lastVehMeme.r, lastVehMeme.g, lastVehMeme.b)
    end
   
    FreezeEntityPosition(PlayerVehicle, false)
    KIBRA.Natives.SetVehicleProps(PlayerVehicle, lastVehData)
    KIBRA.Natives.SetVehicleProps(PlayerVehicle, lastVehMeme)
    TriggerScreenblurFadeOut(150)
    lastVehData = nil
    lastVehMeme = nil
end)

function RestoreVehicleColor(vehicle, color1, color2)
    local primaryRed = color1.r
    local primaryGreen = color1.g
    local primaryBlue = color1.b

    local secondaryRed = color2.r
    local secondaryGreen = color2.g
    local secondaryBlue = color2.b

    SetVehicleCustomPrimaryColour(vehicle, primaryRed, primaryGreen, primaryBlue)
    SetVehicleCustomSecondaryColour(vehicle, secondaryRed, secondaryGreen, secondaryBlue)
end


RegisterNUICallback('CloseMechanicBaba', function()
    freeCam()
    camControl("reset")
    MechanicAcik = false
    SetNuiFocus(false, false)
    Close = true
    Config.OpenHud()
    openm = false
    mechanicId = 0
    truckmenu = false
    MekanikUrunSepeti = {}
    DisplayRadar(true)
    s = {}
    FreezeEntityPosition(PlayerVehicle, false)
    TriggerScreenblurFadeOut(150)
end)

RegisterNUICallback("Klose", function()
    camControl("close")
    camControl("close")
    freeCam()
    ResetCam()
    Config.OpenHud()
    SetNuiFocus(false, false)
    Close = true
    openm = false
    mechanicId = 0
    MekanikUrunSepeti = {}
    DisplayRadar(true)
    s = {}
    local PlayerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    FreezeEntityPosition(PlayerVehicle, false)
    TriggerScreenblurFadeOut(150)
end)

BasariliMuck = function()
    camControl("close")
    SetNuiFocus(false, false)
    Close = true
    MechanicAcik = false
    Config.OpenHud()
    mechanicId = 0
    openm = false
    SendNUIMessage({type = "UiKapat"})
    MekanikUrunSepeti = {}
    DisplayRadar(true)
    s = {}
    local PlayerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    FreezeEntityPosition(PlayerVehicle, false)
    TriggerScreenblurFadeOut(150)
end

RegisterNUICallback('CloseBossMenu', function ()
    TriggerScreenblurFadeOut(150)
    Config.OpenHud()
    SetNuiFocus(false, false)
    bossMenu = false
    DisplayRadar(true)
end)

local function CheckMechanicDistance()
    local alreadyEnteredZone = false
    while true do
        local playerPed = PlayerPedId()
        local Sleep = 2000
        local inZone = false
        local playerCoord = GetEntityCoords(playerPed)
        local playerVehicle = GetVehiclePedIsIn(playerPed, false)
        for mechanicNo, mechanic in ipairs(Config.Mechanics) do
            local jobCheck = JobCheck(mechanicNo)
            for areaNo, area in ipairs(mechanic.ModifiedAreas) do
                local coordFark = #(playerCoord - area.Coord)
                if coordFark <= 2 then
                    Sleep = 5
                    if jobCheck then
                        inZone = true
                        if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(playerVehicle, -1) then
                            if IsControlJustReleased(0, Config.ModifiedAccessKey) then
                                if Config.OnlyCarsInTheDatabase then
                                    KIBRA.Natives.TriggerCallback("kibra:Mechanics:Server:CheckCar", function(export) 
                                        if export then
                                            OpenMechanic(mechanicNo, areaNo)
                                        else
                                            Config.Notify(Config.Text["NotRegistered"])
                                        end
                                    end, KIBRA.Natives.GetPlate(playerVehicle))
                                else
                                    OpenMechanic(mechanicNo, areaNo)
                                end
                            end
                        end
                    end
                end
            end
        end

        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            Config.Show(Config.Opens["Modify"][1], Config.Opens["Modify"][2])
        end

        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            Config.Hide()
        end

        Citizen.Wait(Sleep)
    end
end

DistanceCheck = function(coord, distance)
    if #(GetEntityCoords(PlayerPedId()) - coord) <= distance then
        return true
    else
        return false
    end
end

ClearBlips = function()
    for k,v in pairs(Blips) do
        RemoveBlip(v)
    end
end

CreateBlip = function()
    for k,v in pairs(Config.Mechanics) do
        if not v.BlipShow then return end
        local BlipV = AddBlipForCoord(v.CenterCoord)
        SetBlipSprite(BlipV, v.Blip.Id)
        SetBlipDisplay(BlipV, 4)
        SetBlipAsShortRange(BlipV, true)
        SetBlipScale(BlipV, v.Blip.Scale)
        SetBlipColour(BlipV, v.Blip.Color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.MechanicName)
        EndTextCommandSetBlipName(BlipV)
        table.insert(Blips, BlipV)
    end
end

local function MechanicOwnerCheck(id)
    local auth = false 
    if Config.MechanicsCompany then
        local pData = KIBRA.Natives.GetPlayerData()
        local pJob = pData.job

        if pJob.name == Config.Mechanics[id].JobName and pJob.grade == Config.DefaultBossRank then
            auth = true
        end
    else
        auth = true
    end
    return auth
end

Citizen.CreateThread(function()
    local text = ""
    local PlayerAlreadyZone = false
    while true do
        local Sleep = 2000
        local inZone = false
        if not bossMenu then
            for k,v in pairs(Config.Mechanics) do
                if DistanceCheck(v.BossMenuCoord, 2) then
                    Sleep = 5
                    if Config.Mechanics[k].Owner ~= nil then
                        if MechanicOwnerCheck(k) then
                            inZone = true 
                            DrawMarker(21, v.BossMenuCoord.x, v.BossMenuCoord.y, v.BossMenuCoord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.55, 10, 223, 216, 155, false, false, false, 1, false, false, false)
                            if IsControlJustReleased(0, Config.BossMenuOpenKey) then
                                OpenMechanicBossMenu(k)
                            end
                        end
                    else
                        if Config.MechanicsCompany then
                            DrawMarker(21, v.BossMenuCoord.x, v.BossMenuCoord.y, v.BossMenuCoord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.55, 10, 223, 216, 155, false, false, false, 1, false, false, false)
                            DrawText3D(v.BossMenuCoord.x, v.BossMenuCoord.y, v.BossMenuCoord.z, Config.Text["MechanicBuyText"]..' ~y~[$'..Config.Mechanics[k].Price..']')
                            if IsControlJustReleased(0, Config.BossMenuOpenKey) then
                                BuyMechanic(k)
                            end
                        end
                    end
                end
            end
        end
        if not PlayerAlreadyZone and inZone then
            PlayerAlreadyZone = true
            Config.Show(Config.Opens["BossMenu"][1], Config.Opens["BossMenu"][2])
        end

        if PlayerAlreadyZone and not inZone then
            PlayerAlreadyZone = false 
            inZone = false 
            Config.Hide()
        end
        Citizen.Wait(Sleep)
    end
end)

BuyMechanic = function(id)
    KIBRA.Natives.TriggerCallback("kibra:Mechanics:Server:BuyMechanic", function(export) 
        if export then
            MechNotify('success', Config.Text["SuccessBuyMechanic"])
        else
            MechNotify('error', Config.Text["YouHaveEnoughMoney"])
        end
    end, id)    
end

DrawText3D = function (x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
  end

RegisterNUICallback('MekanikSell', function(data)
    local Player, Dist = KIBRA.Natives.GetClosestPlayer()
	if Player ~= -1 and Dist <= 2.0 then
        local cPlayer = GetPlayerServerId(Player) 
        KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:SellMechanic', function(export)
            if export then
                SendNUIMessage({type = "ZorlaKapat"})
            end
        end, tonumber(cPlayer), tonumber(data.mekanikId))
    else
        MechNotify('error', Config.Text["NoNearOne"])
    end
end)

RegisterNUICallback('UsagiIseAl', function(data)
    KIBRA.Natives.TriggerCallback('kibra:Mechanics:New:addEmployee', function(export)
        if export == "yok" then
            KIBRA.Natives.Notify('error', Config.Lang["kimseyok"])
        else
            SendNUIMessage{
                type = "YanimdakileriYukle",
                Table = export
            }
        end
    end, tonumber(data.mekanikID))
end)

RegisterNUICallback('UsagiAlIse', function(data)
    KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:AddEmploye', function(export)
        if export then
            OpenMechanicBossMenu(tonumber(data.mekanikID))
            MechNotify('success', Config.Text["SuccessHasJobNew"])
        elseif export == "yokki" then
            MechNotify('error', Config.Text["InNotGame"])
        elseif export == "oc" then
            MechNotify('error', Config.Text["HasInJob"])
        else
            MechNotify('error', Config.Text["NotYourselfHire"])
        end
    end, tonumber(data.mekanikID), tonumber(data.source))
end)

RegisterNUICallback('FixCleanCar', function(data)
    local modprice = tonumber(data.ucret)
    TriggerServerEvent('SetTamir', modifiePart, mechanicId, currentPlate)
    MekanikUrunSepeti["CarFixClean"] = { mod = "fix/clean", price = modprice, type = "CarFixClean", modname = Config.Text["VehicleRepairFee"]}
    MechNotify('success', Config.Text["VehicleRepairWill"])
end)

RegisterNUICallback('UpdateWage', function(data)
    if data.yuzde ~= "" then
        KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:UpdateWage', function(export)
            if export then
                MechNotify('success', Config.Text["Guncelledin"])
                OpenMechanicBossMenu(tonumber(data.mekanikID))
            end
        end, tonumber(data.yuzde), tonumber(data.mekanikID))
    else
        MechNotify("error", Config.Text["NotBlank"])
    end
end)

RegisterNUICallback('ParaIslemleri', function(data)
    if data.cekilecekMiktar ~= "" and tonumber(data.cekilecekMiktar) > 0 then
        DepositWithdraw(data.mekanikID, data.cekilecekMiktar, data.type)
    else
        MechNotify("error", Config.Text["NotBlank"])
    end
end)

DepositWithdraw = function(mekanik, money, type)
    KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:DepositWithdrawMoney', function(export)
        if export then
            OpenMechanicBossMenu(tonumber(mekanik))
        end
        if type == "cekBank" then
            if export then
                MechNotify("succes", Config.Text["SuccessWithdraw"])
            else
                MechNotify("error", Config.Text["EnoughMoneyCompany"])
            end
        elseif type == "yatirBank" then
            if export then
                MechNotify("succes", Config.Text["SuccessDeposit"])
            else
                MechNotify("error", Config.Text["EnoughMoneyYou"])
            end
        end
    end, tonumber(mekanik), tonumber(money), type)
end

OpenMechanicBossMenu = function(no)
    local data = {}
    KIBRA.Natives.TriggerCallback('kibra:VehicleShop:Server:GetJobAmount', function(export, the, name)
        Config.HideHud()
        data = {
            playerName = name,
            mId = no,
            mekanik = Config.Mechanics[no],
            lang = Config.Text,
            calisanlar = the,
            mechanicname = Config.Mechanics[no].MechanicName,
            customers = Config.Mechanics[no].Customers,
            calisaniscisayisi = export
        }
        if not bossMenu then TriggerScreenblurFadeIn(150) end
        bossMenu = true
        SetNuiFocus(true, true)
        Config.HideHud()
        SendNUIMessage{type = "OpenBossMenu", data = data}
    end, no)
end

RegisterNetEvent('kibra:Mechanics:Client:CloseBossMenu', function(id)
    OpenMechanicBossMenu(id)
end)

RegisterNUICallback("MechanicNameUpdate", function(data)
    data.mekanikID = tonumber(data.mekanikID)
    local GetMechanicName = Config.Mechanics[data.mekanikID].MechanicName 
    if GetMechanicName ~= data.yazilanIsim and "" ~= data.yazilanIsim then
        KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:ChangeMechanicName', function(export)
            if export then
                OpenMechanicBossMenu(tonumber(data.mekanikID))
                MechNotify('success', Config.Text["SuccessNameChange"])
            end
        end, data.mekanikID, data.yazilanIsim)
    else
        MechNotify('error', Config.Text["NotBlankBro"])
    end
end)

RegisterNUICallback('UsagiKov', function(data)
    KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:FiredCalisanFakirMalGey', function(export, tablo)
        if export then
            MechNotify('success', Config.Text["SuccessFired"])
            OpenMechanicBossMenu(tonumber(data.mekanikID))
        else
            MechNotify('error', Config.Text["YourselfNotFire"])
        end
    end, data.ident, tonumber(data.mekanikID))
end)


RegisterNUICallback('FaturaKesilebilecekAdamlar', function()
    s = {}
    if next(MekanikUrunSepeti) ~= nil then
        TriggerServerEvent('kibra:Mechanics:Server:GetMyAreaPlayers', plate)
    else
        MechNotify('error', Config.Text["NotChanges"])        
    end
end)

RegisterNetEvent('kibra:Mechanics:Client:SendFaturaTable', function(export, owner)
    local data = {tablo = export, vehicleplate = plate, owner = owner}
    SendNUIMessage({
        type = "FaturaKesilecekler",
        tablo = data
    })
end)

RegisterNUICallback('FaturaKesMenusu', function(data) TRYAGAINTRYAGAIN(data) end)

TRYAGAINTRYAGAIN = function(data)
    for k,v in pairs(MekanikUrunSepeti) do
        table.insert(s, {ModName = MekanikUrunSepeti[k].modname, Mod = MekanikUrunSepeti[k].mod, Price = MekanikUrunSepeti[k].price, Type = MekanikUrunSepeti[k].type})
    end
    TriggerScreenblurFadeIn(150)
    local datax = {
        sepet = s, 
        PlayerName = data.playerName, 
        identifier = data.identifier, 
        mekanikID = tonumber(data.mekanikID), 
        source = tonumber(data.playerSource), 
        mechanicName = Config.Mechanics[mechanicId].MechanicName,
        mechanicPay = Config.Mechanics[mechanicId].SalaryPerMod,
        discount = Config.Mechanics[mechanicId].DiscountRate
    }
    SendNUIMessage({type = "OpenBillingPanel", data = datax})
end

RegisterNUICallback("TabloBosalt", function()
    TriggerScreenblurFadeOut(150)
    s = {}
end)

RegisterNUICallback('TablodanSil', function(data)
    s = {}
    if data.modtype ~= "plateIndex" then
        data.modtype = tonumber(data.modtype)
    end
    if data.modtype == "CarFixClean" then
        MekanikUrunSepeti["CarFixClean"] = nil
        TriggerServerEvent('DelTamir', modifiePart, mechanicId, currentPlate)
        local props = {}
        props["tankHealth"] = lastVehData["tankHealth"]
        props["bodyHealth"] = lastVehData["bodyHealth"]
        props["engineHealth"] = lastVehData["engineHealth"]
        KIBRA.Natives.SetVehicleProps(pVehicle, props)
        props = {} 
    else
        MekanikUrunSepeti[data.modtype] = nil
        local props = {}
        props[ICONS[data.modtype].id] = lastVehData[ICONS[data.modtype].id]
        KIBRA.Natives.SetVehicleProps(pVehicle, props)
        props = {} 
    end
    for k,v in pairs(MekanikUrunSepeti) do
        table.insert(s, {ModName = MekanikUrunSepeti[k].modname, Mod = MekanikUrunSepeti[k].mod, Price = MekanikUrunSepeti[k].price, Type = MekanikUrunSepeti[k].type})
    end
    data = {tablo = s, pay = Config.Mechanics[mechanicId].SalaryPerMod, discount = Config.Mechanics[mechanicId].DiscountRate}
    SendNUIMessage{
        type = "Refo",
        data = data
    }
    MechNotify('success', Config.Text["DeletedBasket"])
end)

RegisterNetEvent('kibra:Mechanics:Client:ShowRequestScreen', function(export, table, mysource, oc, id, pipi)
    Ahsen = id
    AdezTR = oc
    currentPlate = pipi
    SendNUIMessage({
        type = "ShowReqScreen",
        data = export,
        table = table,
        mysource = mysource
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent('kibra:Mechanics:Client:UseFixKit', function()
    local playerPed = PlayerPedId()
    local vehicle   = KIBRA.Natives.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)
    local isBusy    = false 

    if IsPedSittingInAnyVehicle(playerPed) then
        MechNotify('error', Config.Text["YouCanNotRepair"])
        return
    end

    if DoesEntityExist(vehicle) then
        isBusy = true
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
        CreateThread(function()
            SetVehicleDoorOpen(vehicle, 4, false)        
            Wait(Config.RepairTime*1000)
            local props = {}
            props["engineHealth"] = 1000.0 
            KIBRA.Natives.SetVehicleProps(vehicle, props)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
            ClearPedTasksImmediately(playerPed)
            MechNotify('success', Config.Text["VehicleSuccessRepaired"])
            isBusy = false
        end)
    else
        MechNotify('error', Config.Text["NoNearOne"])
    end
end)

RegisterNUICallback('BuyModifiye', function(data)
    KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:CheckPMoney', function(export)
        getLatestProps = KIBRA.Natives.GetVehicleProps(pVehicle)
        TriggerServerEvent('SetLatestProps', getLatestProps)
        if export then
            s = {}
            if data.mod == "CarFixClean" then
                TriggerServerEvent('kibra:Mechanics:Server:Tamir', pVehicle, modifiePart, mechanicId, currentPlate)
            elseif data.mod == "plate" then
                TriggerServerEvent('kibra:Mechanics:Server:PlateVarMoruk', plate, modifiePart, mechanicId, data.icerik)
            end
            for k,v in pairs(MekanikUrunSepeti) do
                table.insert(s, {ModName = MekanikUrunSepeti[k].modname, Mod = MekanikUrunSepeti[k].mod, Price = MekanikUrunSepeti[k].price, Type = MekanikUrunSepeti[k].type})
            end
            TriggerServerEvent('kibra:Mechanics:Server:SendInvoiceRequest', data, s, modifiePart, mechanicId, currentPlate)
        else
            MechNotify('error', Config.Text["CustomerEnoughMoney"])
        end
    end, tonumber(data.MusteriSource), tonumber(data.TotalUcret), false)
end)

RegisterNUICallback("AlmayacamBaba", function(data)
    TriggerServerEvent('kibra:Mechanics:Server:SendCalisanUI', tonumber(data.calisanID))
    SendNUIMessage({type = "Almayacam"})
    SetNuiFocus(false, false)
end)

RegisterNetEvent('kibra:Mechanics:Client:Tamir', function(data)
    RepairVehicle(data) 
    CleanVehicle(data)
    TriggerEvent("fixVehicle")
end)

function RepairVehicle(vehicle)
    local isRepairing = true
    while isRepairing do
        Citizen.Wait(0)
        SetVehicleUndriveable(vehicle, true)
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        if IsVehicleEngineOn(vehicle) then
            SetVehicleEngineOn(vehicle, false, true, false)
            Citizen.Wait(1000)
            SetVehicleEngineOn(vehicle, true, true, false)
        end
        if IsVehicleDamaged(vehicle) == false then
            isRepairing = false
        end
    end
end

function CleanVehicle(vehicle)
    local isCleaning = true
    while isCleaning do
        Citizen.Wait(0)
        SetVehicleDirtLevel(vehicle, 0.0)
        if GetVehicleDirtLevel(vehicle) == 0.0 then
            isCleaning = false
        end
    end
end

RegisterNUICallback("Verified", function(data)
    local info = {
        MusteriSource = tonumber(data.source),
        CalisanSrc = tonumber(data.calisansrc),
        CalisanPara = tonumber(data.calisan),
        Total = tonumber(data.total),
        MechanicId = tonumber(data.mekid),
        Plate = data.plate
    }
    if Config.AutoPropsUpdate then
        TriggerServerEvent('kibra:Mechanics:Server:VehicleUpdateProps', Ahsen, AdezTR, currentPlate)
    end
    TriggerServerEvent('Kibra:Mechanics:Server:CheckPlateVar', Ahsen..'_'..AdezTR..'_'..currentPlate)
    KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:Verified', function(export)
        if export then
            SendNUIMessage({
                type = "KapatBan"
            })
            SetNuiFocus(false, false)
        else
            SendNUIMessage({
                type = "KapatBan"
            })
            SetNuiFocus(false, false)
        end 
    end, info)
    MechanicAcik = false
end)

RegisterNetEvent('Kibra:Mechanic:Client:UpdateClientPlate', function(plate, vehicle)
    KIBRA.Natives.SetPlate(vehicle, plate)
    local props = {}
    props.plate = plate
    KIBRA.Natives.SetVehicleProps(vehicle, props)
    TriggerServerEvent('Kibra:Mechanics:ArkadanGuncelle', KIBRA.Natives.GetVehicleProps(vehicle), plate)
end)

RegisterNetEvent('kibra:Mechanics:Client:VerifiedSuccess', function()
    SendNUIMessage({
        type = "OdemeBasarili",
    })
    s = {}
    MekanikUrunSepeti = {}
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(150)
    ResetCam()
    MechanicAcik = false
end)

RegisterNUICallback("MechanicDiscountRate", function(data)
    if data.yuzde ~= "" then
        KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:UpdateDiscount', function(export)
            if export then
                MechNotify('succes', Config.Text["UpdateDiscountRate"])
                OpenMechanicBossMenu(tonumber(data.mekanikID))
            else
                MechNotify('error', Config.Text["SifirdanKucukOlamaz"])
            end
        end, tonumber(data.mekanikID), tonumber(data.yuzde))
    else
        MechNotify('error', Config.Text["SifirdanKucukOlamaz"])
    end
end)

RegisterNUICallback("SilTabloyu", function(data)
    KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:DeleteCustomerTable', function(export)
        if export then
            OpenMechanicBossMenu(tonumber(data.id))
            MechNotify('success' , Config.Text["DeletedCustomerTable"])
        else
            MechNotify('error', Config.Text["Error"])
        end
    end, tonumber(data.id))
end)

RegisterNUICallback("MechanicRepairFee", function(data)
    if data.fee ~= "" then  
        KIBRA.Natives.TriggerCallback('kibra:Mechanics:Server:UpdateRepairFee', function(export)
            if export then
                MechNotify('succes', Config.Text["RepairFeeSuccessUpdate"])
                OpenMechanicBossMenu(tonumber(data.mekanikID))
            else
                MechNotify('error', Config.Text["SifirdanKucukOlamaz"])
            end
        end, tonumber(data.mekanikID), tonumber(data.fee))
    else
        MechNotify('error', Config.Text["SifirdanKucukOlamaz"])
    end
end)

AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    TriggerScreenblurFadeOut(150)
end)

Citizen.CreateThread(TowTruckEnter)
Citizen.CreateThread(TowTruck)
Citizen.CreateThread(CheckMechanicDistance)
