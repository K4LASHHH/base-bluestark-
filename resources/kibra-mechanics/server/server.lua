local tamirvar = 0
local vehicle = nil
local plate = "kibrav4"
local platevar = false
local olmasigerekenplate = "kibrav5"
local props = "vehicleprops"
local araba = nil 
local modificationCars = {}
Mechanic = {}
KIBRA = exports["kibra-core"]:GetCore()

StartServer = function()
    for k,v in pairs(Config.Mechanics) do
        local MC_DATA = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = '..k..'')
        if #MC_DATA == 0 then
            MySQL.Async.execute('INSERT into `kibra-mechanics` (id, name, owner, money, wage, discountrate, customers, repairfee) VALUES(@id, @name, @owner, @money, @wage, @dr, @cust, @rpr)', {["@id"] = k, ["@name"] = Config.DefaultMechanicName..' '..k, ["@owner"] = nil, ["@money"] = Config.DefaultMechanicMoney, ["@wage"] = 30, ["@dr"] = 30, ["@cust"] = "[]", ["@rpr"] = 1000})
        end
    end
    Wait(500)
    LoadMechanic()
end

RegisterNetEvent('kibra:Mechanics:Server:ModifiyeEdilenArac', function(vehicleOne, modifiepart, plate, id)
    local get = id..'_'..modifiepart..'_'..plate
    modificationCars[get] = {vehicle = vehicleOne, plate = plate, platevar = false, plateNew = nil}
end)

RegisterNetEvent('kibra:Mechanics:Server:PlateVarMoruk', function(ex, modifiepart, id, plate)
    local get = id..'_'..modifiepart..'_'..ex
    local vehicle = modificationCars[get].vehicle
    modificationCars[get] = {vehicle = vehicle, plate = ex, platevar = true, plateNew = plate}
end)

RegisterNetEvent('ServerDeleteCarMods', function(mod, id, p)
    modificationCars[id..'_'..mod..'_'..p] = {}    
end)

RegisterNetEvent('kibra:Mechanics:Server:Tamir', function(data, mod, id, plate) 
    local getid = id..'_'..mod..'_'..plate
    if(modificationCars[getid].fix) then
        TriggerClientEvent('kibra:Mechanics:Client:Tamir', -1, data)
    end
end)

RegisterNetEvent('SetTamir', function(id, get, plate)
    modificationCars[id..'_'..get..'_'..plate].fix = true
end)

RegisterNetEvent('DelTamir', function(id, get, plate)
    modificationCars[id..'_'..get..'_'..plate].fix = false
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:CheckCar', function(source, cb, plate)
    local getTable = "owned_vehicles"
    if KIBRA.Natives.GetFramework() == "QBCore" then
        getTable = "player_vehicles"
    end
    local allVehicles = MySQL.Sync.fetchAll('SELECT * FROM '..getTable..' WHERE plate = @plt', {["@plt"] = plate})
    if #allVehicles >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('Kibra:Mechanics:ArkadanGuncelle', function(props, plateV)
    local getTable = "owned_vehicles"
    local kolon = "vehicle"
    if KIBRA.Natives.GetFramework() == "QBCore" then
        getTable = "player_vehicles"
        kolon = "mods"
    end    
    props.plate = plateV

    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM '..getTable..' WHERE plate = @plt', {["@plt"] = plateV})
    if #MysqlMechanic >= 1 then
        MySQL.Async.execute('UPDATE '..getTable..' SET '..kolon..' = @mods WHERE plate = @plt', {["@plt"] = plateV, ["@mods"] = json.encode(props)})
    end
end)

RegisterNetEvent('kibra:Mechanics:Server:VehicleUpdateProps', function(modpart, id, plaka)
    local source = source
    local getTable = "owned_vehicles"
    local kolon = "vehicle"
    if KIBRA.Natives.GetFramework() == "QBCore" then
        getTable = "player_vehicles"
        kolon = "mods"
    end    
    local getID = id..'_'..modpart..'_'..plaka
    local plateV = modificationCars[getID].plate
    if modificationCars[getID].platevar then
        props.plate = modificationCars[getID].plateNew
    end
    TriggerClientEvent('Kibra:Mechanic:Client:UpdateClientPlate', source, plateV, modificationCars[getID].vehicle)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM '..getTable..' WHERE plate = @plt', {["@plt"] = plateV})
    if #MysqlMechanic >= 1 then
        MySQL.Async.execute('UPDATE '..getTable..' SET '..kolon..' = @mods WHERE plate = @plt', {["@plt"] = plateV, ["@mods"] = json.encode(props)})
    end
end)

RegisterNetEvent('kibra:Mechanics:Server:VehicleUpdateProps2', function(propsB, plate, modpart, id)
    local getTable = "owned_vehicles"
    local kolon = "vehicle"
    local getID = id..'_'..modpart..'_'..plate
    local plate = modificationCars[getID].plate
    if KIBRA.Natives.GetFramework() == "QBCore" then
        getTable = "player_vehicles"
        kolon =  "mods"
    end    
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM '..getTable..' WHERE plate = @plt', {["@plt"] = plate})
    if #MysqlMechanic >= 1 then
        MySQL.Async.execute('UPDATE '..getTable..' SET '..kolon..' = @mods WHERE plate = @plt', {["@plt"] = plate, ["@mods"] = json.encode(propsB)})
    end
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:BuyMechanic', function(source, cb, id)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = id})
    local xPlayer = KIBRA.Natives.SourceFromPlayer(source)
    local mechanic = Config.Mechanics[id]
    if not mechanic or mechanic.Owner ~= nil then
        cb(false)
        return
    end

    local price = mechanic.Price
    if xPlayer.getPlayerMoney().bank < price then
        cb(false)
        return
    end
    
    KIBRA.Natives.SetJobSQL(mechanic.JobName, Config.DefaultBossRank, xPlayer.identifier)
    xPlayer.setPlayerJob(mechanic.JobName, Config.DefaultBossRank)
    
    xPlayer.removePlayerMoney("bank", price)
    MySQL.Async.execute('UPDATE `kibra-mechanics` SET owner = @owner WHERE id = @id', {["@id"] = id, ["@owner"] = xPlayer.identifier})
    mechanic.Owner = xPlayer.identifier
    TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', -1, Config.Mechanics)
    cb(true) 
end)


AddEmployee = function(ownersrc, source, id, status)
    local xPlayer = KIBRA.Natives.SourceFromPlayer(source)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = id})
    if MysqlMechanic then
        if xPlayer.job.name ~= Config.Mechanics[id].JobName then
            xPlayer.setPlayerJob(Config.Mechanics[id].JobName, Config.DefaultTechRank)
            KIBRA.Natives.SetJobSQL(Config.Mechanics[id].JobName, Config.DefaultTechRank, xPlayer.identifier)
            TriggerClientEvent('kibra:Mechanics:UI:Notify', ownersrc, 'success', Config.Text["SuccessEmployee"])
            TriggerClientEvent('kibra:Mechanics:Client:CloseBossMenu', ownersrc, id)
        else
            TriggerClientEvent('kibra:Mechanics:UI:Notify', ownersrc, 'error', Config.Text["AlreadyWorking"])
        end
    end
end

ElemanIsteVarmi = function(table, identifier, source)
    for k,v in pairs(table) do
        if v.identifier == identifier then
            return true 
        else
            TriggerClientEvent('kibra:Mechanics:UI:Notify', source, 'error', Config.Text["AlreadyWorking"])
        end
    end
end

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:GetPlayerClosest', function(source, cb, serverid)
    local xPlayer = KIBRA.Natives.SourceFromPlayer(serverid)
    if xPlayer then 
        cb(xPlayer.getPlayerName())
    end
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:SellMechanic', function(source, cb, targetID, id)
    local xTarget = KIBRA.Natives.SourceFromPlayer(targetID)
    local xPlayer = KIBRA.Natives.SourceFromPlayer(source)
    local MySQLMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = id})
    if xTarget then
        if MySQLMechanic then
            MySQL.Async.execute('UPDATE `kibra-mechanics` SET owner = @owner WHERE id = @id', {["@owner"] = xTarget.identifier, ["@id"] = id})
            Config.Mechanics[id].Owner = xTarget.identifier
            TriggerClientEvent('kibra:Mechanics:UI:Notify', xPlayer.source, 'success', Config.Text["SuccesTransfer"])
            TriggerClientEvent('kibra:Mechanics:UI:Notify', xTarget.source, 'success', Config.Text["TransferSuccess"])
            TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', xPlayer.source, Config.Mechanics)
            TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', xTarget.source, Config.Mechanics)
            if Config.UseServerJobSystem then
                KIBRA.Natives.SetJobSQL(Config.Mechanics[id].JobName, Config.DefaultBossRank, xTarget.identifier)
                xTarget.setPlayerJob(Config.Mechanics[id].JobName, Config.DefaultBossRank)
                KIBRA.Natives.SetJobSQL("unemployed", 0, xPlayer.identifier)
                xPlayer.setPlayerJob("unemployed", 0)
            end
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
        TriggerClientEvent('kibra:Mechanics:UI:Notify', source, 'error', Config.Text["InNotGame"])
    end
end)

KIBRA.Natives.CreateCallback('kibra:VehicleShop:Server:GetJobAmount', function(source, cb, id)
    local jobPlayers = {}
    local sayi = 0
    local xPlayerV = KIBRA.Natives.SourceFromPlayer(source)
    local xPlayers = KIBRA.Natives.AllPlayers()
	for i=1, #xPlayers, 1 do
        local xPlayer = KIBRA.Natives.SourceFromPlayer(xPlayers[i])
        if xPlayer.job.name == Config.Mechanics[id].JobName then
            sayi = sayi + 1
            table.insert(jobPlayers, {name = xPlayer.getPlayerName(), permission = xPlayer.job.grade_name, identifier = xPlayer.identifier})
        end
    end
    cb(sayi, jobPlayers, xPlayerV.getPlayerName())
    return sayi
end)


KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:FiredCalisanFakirMalGey', function(source, cb, identifier, id)
    local xPlayer = KIBRA.Natives.SourceFromPlayer(source)
    local xTargetSource = KIBRA.Natives.GetPlayerFromIdentifier(identifier)
    local xTarget = KIBRA.Natives.SourceFromPlayer(xTargetSource)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = id})
    local Employees = json.decode(MysqlMechanic[1].employees)
    if xPlayer.identifier ~= identifier then 
        if xTarget ~= nil then
            xTarget.setPlayerJob("unemployed", 0)
        end
        KIBRA.Natives.SetJobSQL("unemployed", 0, identifier)
        TriggerClientEvent('kibra:Mechanics:Client:CloseBossMenu', source, id)
        TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', -1, Config.Mechanics)
        TriggerClientEvent('kibra:Mechanics:UI:Notify', source, 'success', Config.Text["SuccessFired"])
        cb(true)
    else
        cb(false)
    end
end)

MechanicAddCustomerHistory = function(source, mid, plate, price)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = mid})
    local xPlayer = KIBRA.Natives.SourceFromPlayer(source)
    if #MysqlMechanic > 0 then
        local getCustomers = json.decode(MysqlMechanic[1].customers)
        table.insert(getCustomers, {PlayerName = xPlayer.getPlayerName(), Plate = plate, Price = price})
        Config.Mechanics[mid].Customers = getCustomers
        MySQL.Async.execute('UPDATE `kibra-mechanics` SET customers = @cust WHERE id = @id', {["@id"] = mid, ["@cust"] = json.encode(getCustomers)})
        TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', source, Config.Mechanics)
    end
end

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:ChangeMechanicName', function(source, cb, mid, isim)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = mid})
    if MysqlMechanic then
        MySQL.Async.execute('UPDATE `kibra-mechanics` SET name = @name WHERE id = @id', {["@name"] = isim, ["@id"] = mid})
        Config.Mechanics[mid].MechanicName = isim 
        TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', -1, Config.Mechanics)
        cb(true)
    end
end)


RegisterNetEvent('kibra:Mechanics:Server:GetMyAroundPlayers', MyAroundPlayers)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:AddEmploye', function(source, cb, mid, source2)
    if source ~= source2 then
        local HiredPlayer = KIBRA.Natives.SourceFromPlayer(source2)
        if HiredPlayer then
            AddEmployee(source, source2, mid, Config.Text["Techinician"])
        else
            cb("yokki")
        end
    else
        cb(false)
    end
end)

LoadMechanic = function()
    local McData = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics`')
    if #McData > 0 then
        for k,v in pairs(McData) do
            v.id = tonumber(v.id)
            Config.Mechanics[v.id].Owner = v.owner
            Config.Mechanics[v.id].MechanicName = v.name 
            Config.Mechanics[v.id].Money = v.money 
            Config.Mechanics[v.id].SalaryPerMod = v.wage
            Config.Mechanics[v.id].DiscountRate = v.discountrate
            Config.Mechanics[v.id].Employees = json.decode(v.employees)
            Config.Mechanics[v.id].Customers = json.decode(v.customers)
            Config.Mechanics[v.id].VehicleRepairAndCleaningLaborPrice = v.repairfee
        end
    end
    print("^2[Kibra Mechanics]^7 Mechanics Loaded")
end

KIBRA.Natives.CreateCallback("kibra:Mechanics:Server:UpdateDiscount", function(source, cb, id, yuzde)
    if yuzde ~= "" and yuzde >= 0 and yuzde <= 100 then
        MySQL.Async.execute('UPDATE `kibra-mechanics` SET discountrate = @disc WHERE id = @id', {["@id"] = id, ["@disc"] = yuzde})
        Config.Mechanics[id].DiscountRate = yuzde 
        TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', source, Config.Mechanics)
        cb(true)
    else
        cb(false)
    end
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:UpdateWage', function(source, cb, yuzde, mID)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = mID})
    if #MysqlMechanic >= 1 then
        MySQL.Async.execute('UPDATE `kibra-mechanics` SET wage = @wage WHERE id = @id', {["@wage"] = yuzde, ["@id"] = mID})
        Config.Mechanics[mID].SalaryPerMod = yuzde 
        TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', source, Config.Mechanics)
        cb(true)
    end
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:DepositWithdrawMoney', function(source, cb, mid, money, type)
    local RequestMoney = tonumber(money)
    local xPlayer = KIBRA.Natives.SourceFromPlayer(source)
    local PlayerCash = xPlayer.getPlayerMoney().cash
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = mid})
    local MechanicMoney = tonumber(MysqlMechanic[1].money)

    if type == "cekBank" then
        if MechanicMoney >= RequestMoney then
            Mechanic.AddMoney("removeMoney", mid, RequestMoney, source)
            xPlayer.giveAccountMoney("cash", RequestMoney)
            cb(true)
        else
            cb(false)
        end
    else 
        if PlayerCash >= RequestMoney then
            Mechanic.AddMoney("addMoney", mid, RequestMoney, source)
            xPlayer.removePlayerMoney("cash", RequestMoney)
            cb(true)
        else
            cb(false)
        end
    end
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:UpdateRepairFee', function(source, cb, id, fee)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = id})
    if MysqlMechanic then
        if fee > 0 and fee ~= "" then
            MySQL.Async.execute('UPDATE `kibra-mechanics` SET repairfee = @rpr WHERE id = @id', {["@rpr"] = fee, ["@id"] = id})
            Config.Mechanics[id].VehicleRepairAndCleaningLaborPrice = fee
            TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', -1, Config.Mechanics)
            cb(true)
        else
            cb(false)
        end
    end
end)

Mechanic.AddMoney = function(type, id, money, source)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = id})
    local mechanicMoney = tonumber(MysqlMechanic[1].money)
    local addedMoney = tonumber(money)
    if type == "addMoney" then
        mechanicMoney = mechanicMoney+addedMoney
        Config.Mechanics[id].Money = mechanicMoney+addedMoney
    else
        mechanicMoney = mechanicMoney-money
        Config.Mechanics[id].Money = mechanicMoney-addedMoney
    end
    Config.Mechanics[id].Money = mechanicMoney
    MySQL.Async.execute('UPDATE `kibra-mechanics` SET money = @money WHERE id = @id', {["@money"] = mechanicMoney, ["@id"] = id})
    TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', source, Config.Mechanics)
end

AddRemoveMoneyMechanic = function(bla, money, mid, source)
    local ThePlayer = KIBRA.Natives.SourceFromPlayer(source)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {["@id"] = mid})
    local MechanicMoney = tonumber(MysqlMechanic[1].money)
    if bla == "ekle" then

        -- TotalMoney = MechanicMoney+money
        -- MySQL.Async.execute('UPDATE `kibra-mechanics` SET money = @money WHERE id = @id', {["@money"] = TotalMoney, ["@id"] = mid})
        -- ThePlayer.removePlayerMoney("cash", money)
        -- Config.Mechanics[mid].Money = TotalMoney 
        -- TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', source, Config.Mechanics)
    elseif bla == "cikart" then
        TotalMoney = MechanicMoney-money
        ThePlayer.giveAccountMoney("cash", money)
        MySQL.Async.execute('UPDATE `kibra-mechanics` SET money = @money WHERE id = @id', {["@money"] = TotalMoney, ["@id"] = mid})
        Config.Mechanics[mid].Money = TotalMoney 
        TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', source, Config.Mechanics)
    elseif bla == "amcik" then
        MySQL.Async.execute('UPDATE `kibra-mechanics` SET money = @money WHERE id = @id', {["@money"] = MechanicMoney+money, ["@id"] = mid})
        Config.Mechanics[mid].Money = MechanicMoney+money
        TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', source, Config.Mechanics)
    end
end

RegisterNetEvent('kibra:Mechanics:Server:SendInvoiceRequest', function(data, table, mod, id, plate)
    local mysource = source
    local Customer = KIBRA.Natives.SourceFromPlayer(tonumber(data.MusteriSource))
    if Customer then
        TriggerClientEvent('kibra:Mechanics:UI:Notify', mysource, 'success', Config.Text["InvoiceStart"])
        TriggerClientEvent('kibra:Mechanics:Client:ShowRequestScreen', tonumber(data.MusteriSource), data, table, mysource, mod, id, plate)
    else
        TriggerClientEvent('kibra:Mechanics:UI:Notify', mysource, 'error', Config.Text["InNotGame"])
    end
end)

RegisterNetEvent('kibra:Mechanics:Server:GetMyAreaPlayers', function(plate)
    local source = source
    local getTable = "owned_vehicles"
    if KIBRA.Natives.GetFramework() == "QBCore" then
        getTable = "player_vehicles"
    end    
    local m = MySQL.Sync.fetchAll('SELECT * FROM '..getTable..' WHERE plate = @plate', {["@plate"] = plate})
    if #m >= 1 then
        cex = m[1].owner
    else
        cex = "Abuzer"
    end
    local myAround = NearbyPlayers(source)
    TriggerClientEvent('kibra:Mechanics:Client:SendFaturaTable', source, myAround, cex)
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:Verified', function(source, cb, data)
    data.MusteriSource = tonumber(data.MusteriSource)
    local Customer = KIBRA.Natives.SourceFromPlayer(tonumber(data.MusteriSource))
    Isci = KIBRA.Natives.SourceFromPlayer(tonumber(data.CalisanSrc))
    local totalucret = math.abs(tonumber(data.Total) - tonumber(data.CalisanPara))
    if Customer then
        if Customer.getPlayerMoney().bank >= tonumber(data.Total) then
            Mechanic.AddMoney("addMoney", tonumber(data.MechanicId), totalucret, tonumber(data.CalisanSrc))
            Isci.giveAccountMoney("cash", tonumber(data.CalisanPara))
            Customer.removePlayerMoney("bank", data.Total)
            TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', -1, Config.Mechanics)
            TriggerClientEvent('kibra:Mechanics:Client:CloseOff', Customer.source)
            TriggerClientEvent('kibra:Mechanics:UI:Notify', tonumber(data.CalisanSrc), 'success', Config.Text["SuccessCustomerPayment"])
            TriggerClientEvent('kibra:Mechanics:UI:Notify', tonumber(data.MusteriSource), 'success', Config.Text["SuccessKanks"])
            TriggerClientEvent('kibra:Mechanics:Client:VerifiedSuccess', tonumber(data.CalisanSrc))
            MechanicAddCustomerHistory(tonumber(data.MusteriSource), tonumber(data.MechanicId), data.Plate, tonumber(data.Total))
            cb(true)
        else
            fark = data.Total - Customer.getPlayerMoney().bank
            TriggerClientEvent('kibra:Mechanics:UI:Notify', Customer.source, 'error', '($'..fark..') '..Config.Text["YouHaveEnoughMoney"])
            cb(false)
        end
    end
end)

function NearbyPlayers(source)
    local players = {}
    local source = source
    local sourcePos = GetEntityCoords(GetPlayerPed(source), true)
    local oyuncular = KIBRA.Natives.AllPlayers()
    for _, player in pairs(oyuncular) do
        local targetPos = GetEntityCoords(GetPlayerPed(player), true)
        local distance = #(sourcePos - targetPos)
        local zPlayer = KIBRA.Natives.SourceFromPlayer(player)
        if distance <= 30.0 then 
            table.insert(players, {
                Source = zPlayer.source,
                PlayerName = zPlayer.getPlayerName()
            })
        end
    end
    return players
end

RegisterNetEvent('kibra:Mechanics:ListOfAroundPlayers', function()
    local source = source
    local players = NearbyPlayers(source)

    TriggerClientEvent('Kibra:Mechanics:Client:SendIbneler', source, players)
end) 

KIBRA.Natives.CreateCallback('kibra:Mechanics:New:addEmployee', function(source, cb, data)
    local GET = Config.Mechanics[data] 
    local players = NearbyPlayers(source) 
    if players then
        cb(players)
    end
end)

RegisterNetEvent('PlayerMoneyRemove', function(money)
    local source = source 
    KIBRA.Natives.SourceFromPlayer(source).removePlayerMoney("bank", money)
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:CheckPMoney', function(source, cb, src, money, d)
    local xPlayer = KIBRA.Natives.SourceFromPlayer(src)
    if xPlayer.getPlayerMoney().bank >= money then
        cb(true)
    else
        cb(false)
    end    
end)

RegisterNetEvent('SetLatestProps', function(data)
    props = data
end)


RegisterNetEvent('kibra:Mechanics:Server:PropsUpdate', function(props, plate)
    local getTable = "owned_vehicles"
    local kolon = "vehicle"
    if KIBRA.Natives.GetFramework() == "QBCore" then
        getTable = "player_vehicles"
        kolon = "mods"
    end    
    MySQL.Async.execute('UPDATE '..getTable..' SET '..kolon..' = @mod WHERE plate = @plate', {
        ["@mod"] = props,
        ["@plate"] = plate
    })
end)

KIBRA.Natives.CreateCallback('kibra:Mechanics:Server:DeleteCustomerTable', function(source, cb, id)
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM `kibra-mechanics` WHERE id = @id', {id})
    if MysqlMechanic then
        MySQL.Async.execute('UPDATE `kibra-mechanics` SET customers = @c WHERE id = @id', {["@id"] = id, ["@c"] = "[]"})
        Config.Mechanics[id].Customers = {}
        TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', source, Config.Mechanics)
        cb(true)
    else
        cb(false) 
    end
end)

RegisterNetEvent('kibra:Mechanics:Server:SendCalisanUI', function(ben)
    local source = ben
    TriggerClientEvent('kibra:Mechanics:UI:Notify', source, 'error', Config.Text["RefusedCustomer"])
end)

RegisterNetEvent('kibra:Mechanics:Server:RequestMechanicData', function()
    local src = source
    local xPlayer = KIBRA.Natives.SourceFromPlayer(src)
    if xPlayer then
        TriggerClientEvent('Kibra:Mechanics:Client:SetName', src, xPlayer.getPlayerName())
    end
    TriggerClientEvent('kibra:Mechanics:Client:UpdateMechanics', src, Config.Mechanics)
end)

RegisterNetEvent('kibra:Mechanics:Server:PlateVar', function(e, f)
    local g = "owned_vehicles"
    if KIBRA.Natives.GetFramework() == "QBCore" then
        g = "player_vehicles"
    end
    local getVehicle = MySQL.Sync.fetchAll('SELECT * FROM '..g..' WHERE plate = ?', {f})
    if #getVehicle >= 1 then
        MySQL.update('UPDATE '..g..' SET plate = ? WHERE plate = ?', {e,f})
    end
end)

RegisterNetEvent('Kibra:Mechanics:Server:CheckPlateVar', function(id)
    local source = source
    local getTable = "owned_vehicles"
    if KIBRA.Natives.GetFramework() == "QBCore" then
        getTable = "player_vehicles"
    end    
    local get = id
    if modificationCars[get].platevar then
        pilate = modificationCars[get].plate
        newolan = modificationCars[get].plateNew
        local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM '..getTable..' WHERE plate = @plt', {["@plt"] = pilate})
        if #MysqlMechanic >= 1 then
            TriggerClientEvent('Kibra:Mechanic:Client:UpdateClientPlate', source, newolan, modificationCars[get].vehicle)
            MySQL.Async.execute('UPDATE '..getTable..' SET plate = @plate WHERE plate = @plt', {["@plt"] = pilate, ["@plate"] = newolan})
            if Config.UseVehicleKeys then
                TriggerClientEvent(Config.VehicleKeysEvent, source, newolan)
                TriggerClientEvent(Config.VehicleAddKeyEvent, source, newolan)
            end
        end
    end
end)


KIBRA.Natives.CreateCallback('kibra:Mechanics:CheckPlate', function(source, cb, plate)
    local getTable = "owned_vehicles"
    if KIBRA.Natives.GetFramework() == "QBCore" then
        getTable = "player_vehicles"
    end    
    local MysqlMechanic = MySQL.Sync.fetchAll('SELECT * FROM '..getTable..' WHERE plate = @plt', {["@plt"] = plate})
    if #MysqlMechanic <= 0 then
        cb(true)
    else
        cb(false)
    end
end)

KIBRA.Natives.CreateCallback('getKibraName', function(source, cb)
    local xPlayer = KIBRA.Natives.SourceFromPlayer(source)
    if xPlayer then
        cb(xPlayer.getPlayerName())
    end
end)

RegisterNetEvent('')

Citizen.CreateThread(StartServer)