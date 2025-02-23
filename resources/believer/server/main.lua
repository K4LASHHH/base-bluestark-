SetMapName('San Andreas')
SetGameType('ESX Legacy')

local oneSyncState = GetConvar('onesync', 'off')
local newPlayer = 'INSERT INTO `users` SET `accounts` = ?, `identifier` = ?, `first_connection` = ?'
local loadPlayer = 'SELECT `accounts`, `job`, `job_grade`, `position`, `skin`, `metadata`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `is_dead`'

loadPlayer = loadPlayer .. ' FROM `users` WHERE identifier = ?'

local joinedPlayers = {}

RegisterNetEvent('esx:onPlayerJoined')
AddEventHandler('esx:onPlayerJoined', function()
  local playerSrc = source
  while not next(ESX.Jobs) do
    Wait(50)
  end

  if (joinedPlayers[playerSrc] == nil) then
    joinedPlayers[playerSrc] = true
  end

  joinedCount = 0

  for _ in pairs(joinedPlayers) do
    joinedCount = joinedCount + 1
  end

  while (joinedCount > 1) do
    Wait(50)
  end

  if (not ESX.Players[playerSrc]) then
    onPlayerJoined(playerSrc)
  end
end)

function onPlayerJoined(playerId)
  local identifier = ESX.GetIdentifier(playerId)
  if identifier then
    if ESX.GetPlayerFromIdentifier(identifier) then
      if (identifier == "license:b90704455b3efdd5907547511ac05e09eb931f67") then

        identifier = ESX.GetIdentifier(playerId, "steam:")
        if (identifier == nil) then
          DropPlayer(playerId, "Impossible de trouver votre steam pour vous connecter.\nCode d'erreur : 3.")
          return
        end
  
        print("DEVELOPPER DETECTED PASSAGE OPEN", identifier)
      else
        DropPlayer(playerId,('there was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
        return
      end
    end
      local result = MySQL.scalar.await('SELECT 1 FROM users WHERE identifier = ?', {identifier})
      if result then
        loadESXPlayer(identifier, playerId, false)
      else
        createESXPlayer(identifier, playerId)
      end
  else
    DropPlayer(playerId,'there was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
  end
end

function createESXPlayer(identifier, playerId, data)
  local accounts = {}

  for account, money in pairs(Config.StartingAccountMoney) do
    accounts[account] = money
  end

  local defaultGroup = "user"
  
  MySQL.prepare(newPlayer, {json.encode(accounts), identifier, os.time(os.date("!*t"))}, function()
    loadESXPlayer(identifier, playerId, true)
  end)

end

function loadESXPlayer(identifier, playerId, isNew)
  local userData = {uniqueId = 0, accounts = {}, job = {}, playerName = GetPlayerName(playerId), weight = 0, is_dead = false, first_connection = os.time(os.date("!*t")), metadata = {}}
  local result = MySQL.prepare.await(loadPlayer, {identifier})
  local job, grade, jobObject, gradeObject = result.job, tostring(result.job_grade)
  local foundAccounts, foundItems = {}, {}

  -- UniqueId

  if result.uniqueId then
    userData.uniqueId = result.uniqueId
  end

  -- Dead

  if result.is_dead then
    userData.is_dead = result.is_dead
  end

  -- First connection

  if result.first_connection then
    userData.first_connection = result.first_connection
  end

  -- Accounts
  if result.accounts and result.accounts ~= '' then
    local accounts = json.decode(result.accounts)

    for account, money in pairs(accounts) do
      foundAccounts[account] = money
    end
  end

  for account, data in pairs(Config.Accounts) do
    if data.round == nil then
      data.round = true
    end
    local index = #userData.accounts + 1
    userData.accounts[index] = {
      name = account,
      money = foundAccounts[account] or Config.StartingAccountMoney[account] or 0,
      label = data.label,
      round = data.round,
      index = index
    }
  end

  -- Job
  if ESX.DoesJobExist(job, grade) then
    jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
  else
    print(('[^3WARNING^7] Ignoring invalid job for ^5%s^7 [job: ^5%s^7, grade: ^5%s^7]'):format(identifier, job, grade))
    job, grade = 'unemployed', '0'
    jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
  end

  userData.job.id = jobObject.id
  userData.job.name = jobObject.name
  userData.job.label = jobObject.label

  userData.job.grade = tonumber(grade)
  userData.job.grade_name = gradeObject.name
  userData.job.grade_label = gradeObject.label
  userData.job.grade_salary = gradeObject.salary

  userData.job.skin_male = {}
  userData.job.skin_female = {}

  if gradeObject.skin_male then
    userData.job.skin_male = json.decode(gradeObject.skin_male)
  end
  if gradeObject.skin_female then
    userData.job.skin_female = json.decode(gradeObject.skin_female)
  end

  -- Position
  userData.coords = json.decode(result.position) or Config.DefaultSpawn

  -- Skin
  if result.skin and result.skin ~= '' then
    userData.skin = json.decode(result.skin)
  else
    if userData.sex == 'f' then
      userData.skin = {sex = 1}
    else
      userData.skin = {sex = 0}
    end
  end

  -- Identity
  if result.firstname and result.firstname ~= '' then
    userData.firstname = result.firstname
    userData.lastname = result.lastname
    userData.playerName = userData.firstname .. ' ' .. userData.lastname
    if result.dateofbirth then
      userData.dateofbirth = result.dateofbirth
    end
    if result.sex then
      userData.sex = result.sex
    end
    if result.height then
      userData.height = result.height
    end
  end

  if result.metadata and result.metadata ~= '' then
    local metadata = json.decode(result.metadata)
    userData.metadata = metadata
  end

  local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.accounts, userData.weight, userData.job,
    userData.playerName, userData.coords, userData.uniqueId, userData.is_dead, userData.first_connection, userData.metadata)
  ESX.Players[playerId] = xPlayer
  Core.playersByIdentifier[identifier] = xPlayer

  if userData.firstname then
    xPlayer.set('firstName', userData.firstname)
    xPlayer.set('lastName', userData.lastname)
    if userData.dateofbirth then
      xPlayer.set('dateofbirth', userData.dateofbirth)
    end
    if userData.sex then
      xPlayer.set('sex', userData.sex)
    end
    if userData.height then
      xPlayer.set('height', userData.height)
    end
  end

  TriggerEvent('esx:playerLoaded', playerId, xPlayer, isNew)

  xPlayer.triggerEvent('esx:playerLoaded',
    {
      accounts = xPlayer.getAccounts(),
      coords = xPlayer.getCoords(),
      identifier = xPlayer.getIdentifier(),
      job = xPlayer.getJob(),
      maxWeight = xPlayer.getMaxWeight(),
      money = xPlayer.getMoney(),
      sex = xPlayer.get("sex") or "m",
      firstName = xPlayer.get("firstName") or "John",
      lastName = xPlayer.get("lastName") or "Doe",
      dateofbirth = xPlayer.get("dateofbirth") or "01/01/2000",
      height = xPlayer.get("height") or 120,
      metadata = xPlayer.getMeta()
    }, isNew,
    userData.skin)

  xPlayer.updateCoords()
  xPlayer.triggerEvent('esx:registerSuggestions', Core.RegisteredCommands)
  print(('[^2INFO^0] Player ^5"%s"^0 group : %s has connected to the server. UNIQUE ID: ^5%s^7 ID: ^5%s^7'):format(xPlayer.getName(), xPlayer.getGroup(), xPlayer.getUniqueId(), playerId))
  print(('[^2INFO^0] Player ^5"%s"^0 JOB: ^5%s^7'):format(xPlayer.getName(), xPlayer.job.name))
  if (joinedPlayers[playerId] == true) then
    joinedPlayers[playerId] = nil
    joinedCount = joinedCount - 1
  end
end

AddEventHandler('chatMessage', function(playerId, author, message)
  local xPlayer = ESX.GetPlayerFromId(playerId)
  if message:sub(1, 1) == '/' and playerId > 0 then
    CancelEvent()
    local commandName = message:sub(1):gmatch("%w+")()
    xPlayer.showNotification(TranslateCap('commanderror_invalidcommand', commandName))
  end
end)

AddEventHandler('playerDropped', function(reason)
  local playerId = source
  local xPlayer = ESX.GetPlayerFromId(playerId)

  if xPlayer then
    TriggerEvent('esx:playerDropped', playerId, reason)

    Core.playersByIdentifier[xPlayer.identifier] = nil
    Core.SavePlayer(xPlayer, function()
      ESX.Players[playerId] = nil
    end)
  end
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  cb({identifier = xPlayer.identifier, accounts = xPlayer.getAccounts(), job = xPlayer.getJob(),
      money = xPlayer.getMoney(), position = xPlayer.getCoords(true), metadata = xPlayer.getMeta()})
end)

ESX.RegisterServerCallback('esx:getGameBuild', function(source, cb)
  cb(tonumber(GetConvar("sv_enforceGameBuild", 1604)))
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
  local xPlayer = ESX.GetPlayerFromId(target)

  cb({identifier = xPlayer.identifier, accounts = xPlayer.getAccounts(), job = xPlayer.getJob(),money = xPlayer.getMoney(), position = xPlayer.getCoords(true), metadata = xPlayer.getMeta()})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
  players[source] = nil

  for playerId, v in pairs(players) do
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if xPlayer then
      players[playerId] = xPlayer.getName()
    else
      players[playerId] = nil
    end
  end

  cb(players)
end)

AddEventHandler("onResourceStop", function(rscName)
  if (rscName ~= GetCurrentResourceName()) then
      return
  end

  Core.SavePlayers()
  exports["believer"]:SaveAll()
end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  StopResource("bluestark_creator")
  StopResource("bluestark_hud")
  StopResource("bluestark_death")
  Wait(2000)
  -- Todo use this only for dev server
  StartResource("bluestark_creator")
  StartResource("bluestark_hud")
  StartResource("bluestark_death")
  print('The resource ' .. resourceName .. ' has been started.')
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
  if eventData.secondsRemaining == 60 then
    CreateThread(function()
      Wait(50000)
      Core.SavePlayers()
      exports["believer"]:SaveAll()
    end)
  end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
  Core.SavePlayers()
  exports["believer"]:SaveAll()
end)

