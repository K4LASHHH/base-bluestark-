function ESX.Trace(msg)
  if Config.EnableDebug then
    print(('[^2TRACE^7] %s^7'):format(msg))
  end
end

function ESX.RegisterCommand(name, group, cb, allowConsole, suggestion)
  if type(name) == 'table' then
    for k, v in ipairs(name) do
      ESX.RegisterCommand(v, group, cb, allowConsole, suggestion)
    end

    return
  end

  if Core.RegisteredCommands[name] then
    print(('[^3WARNING^7] Command ^5"%s" ^7already registered, overriding command'):format(name))

    if Core.RegisteredCommands[name].suggestion then
      TriggerClientEvent('chat:removeSuggestion', -1, ('/%s'):format(name))
    end
  end

  if suggestion then
    if not suggestion.arguments then
      suggestion.arguments = {}
    end
    if not suggestion.help then
      suggestion.help = ''
    end

    TriggerClientEvent('chat:addSuggestion', -1, ('/%s'):format(name), suggestion.help, suggestion.arguments)
  end

  Core.RegisteredCommands[name] = {group = group, cb = cb, allowConsole = allowConsole, suggestion = suggestion}

  RegisterCommand(name, function(playerId, args, rawCommand)
    local command = Core.RegisteredCommands[name]

    if not command.allowConsole and playerId == 0 then
      print(('[^3WARNING^7] ^5%s'):format(TranslateCap('commanderror_console')))
    else
      local xPlayer, error = ESX.Players[playerId], nil

      if command.suggestion then
        if command.suggestion.validate then
          if #args ~= #command.suggestion.arguments then
            error = TranslateCap('commanderror_argumentmismatch', #args, #command.suggestion.arguments)
          end
        end

        if not error and command.suggestion.arguments then
          local newArgs = {}

          for k, v in ipairs(command.suggestion.arguments) do
            if v.type then
              if v.type == 'number' then
                local newArg = tonumber(args[k])

                if newArg then
                  newArgs[v.name] = newArg
                else
                  error = TranslateCap('commanderror_argumentmismatch_number', k)
                end
              elseif v.type == 'player' or v.type == 'playerId' then
                local targetPlayer = tonumber(args[k])

                if args[k] == 'me' then
                  targetPlayer = playerId
                end

                if targetPlayer then
                  local xTargetPlayer = ESX.GetPlayerFromId(targetPlayer)

                  if xTargetPlayer then
                    if v.type == 'player' then
                      newArgs[v.name] = xTargetPlayer
                    else
                      newArgs[v.name] = targetPlayer
                    end
                  else
                    error = TranslateCap('commanderror_invalidplayerid')
                  end
                else
                  error = TranslateCap('commanderror_argumentmismatch_number', k)
                end
              elseif v.type == 'string' then
                newArgs[v.name] = args[k]
              elseif v.type == 'item' then
                if ESX.Items[args[k]] then
                  newArgs[v.name] = args[k]
                else
                  error = TranslateCap('commanderror_invaliditem')
                end
              elseif v.type == 'weapon' then
                if ESX.GetWeapon(args[k]) then
                  newArgs[v.name] = string.upper(args[k])
                else
                  error = TranslateCap('commanderror_invalidweapon')
                end
              elseif v.type == 'any' then
                newArgs[v.name] = args[k]
              end
            end

            if not v.validate then
              error = nil
            end

            if error then
              break
            end
          end

          args = newArgs
        end
      end

      if error then
        if playerId == 0 then
          print(('[^3WARNING^7] %s^7'):format(error))
        else
          xPlayer.showNotification(error)
        end
      else
        cb(xPlayer or false, args, function(msg)
          if playerId == 0 then
            print(('[^3WARNING^7] %s^7'):format(msg))
          else
            xPlayer.showNotification(msg)
          end
        end)
      end
    end
  end, true)

  if type(group) == 'table' then
    for k, v in ipairs(group) do
      ExecuteCommand(('add_ace group.%s command.%s allow'):format(v, name))
    end
  else
    ExecuteCommand(('add_ace group.%s command.%s allow'):format(group, name))
  end
end

function Core.SavePlayer(xPlayer, cb)
  local parameters <const> = {
    json.encode(xPlayer.getAccounts(true)),
    xPlayer.job.name,
    xPlayer.job.grade,
    json.encode(xPlayer.getCoords()),
    xPlayer.getDead(),
    json.encode(xPlayer.getMeta()),
    xPlayer.identifier
  }

  MySQL.prepare(
    'UPDATE `users` SET `accounts` = ?, `job` = ?, `job_grade` = ?, `position` = ?, `is_dead` = ?,  `metadata` = ? WHERE `identifier` = ?',
    parameters,
    function(affectedRows)
      if affectedRows == 1 then
        print(('[^2INFO^7] Saved player ^5"%s^7"'):format(xPlayer.name))
        TriggerEvent('esx:playerSaved', xPlayer.playerId, xPlayer)
      end
      if cb then
        cb()
      end
    end
  )
end

function Core.SavePlayers(cb)
  local xPlayers <const> = ESX.Players
  if not next(xPlayers) then
    return
  end
  
  local startTime <const> = os.time()
  local parameters = {}

  for _, xPlayer in pairs(ESX.Players) do
    parameters[#parameters + 1] = {
      json.encode(xPlayer.getAccounts(true)),
      xPlayer.job.name,
      xPlayer.job.grade,
      json.encode(xPlayer.getCoords()),
      xPlayer.getDead(),
      json.encode(xPlayer.getMeta()),
      xPlayer.identifier
    }
  end

  MySQL.prepare(
    "UPDATE `users` SET `accounts` = ?, `job` = ?, `job_grade` = ?, `position` = ?, `is_dead` = ?, `metadata` = ? WHERE `identifier` = ?",
    parameters, 
    function(results)
      if not results then
        return
      end

      if type(cb) == 'function' then
        return cb()
      end
      
      print(('[^2INFO^7] Saved ^5%s^7 %s over ^5%s^7 ms'):format(#parameters, #parameters > 1 and 'players' or 'player', ESX.Math.Round((os.time() - startTime) / 1000000, 2)))
    end
  )
end

ESX.GetPlayers = GetPlayers

function ESX.GetExtendedPlayers(key, val)
  local xPlayers = {}
  for k, v in pairs(ESX.Players) do
    if key then
      if (key == 'job' and v.job.name == val) or v[key] == val then
        xPlayers[#xPlayers + 1] = v
      end
    else
      xPlayers[#xPlayers + 1] = v
    end
  end
  return xPlayers
end

function ESX.GetPlayerFromId(source)
  return ESX.Players[tonumber(source)]
end

function ESX.GetPlayerFromIdentifier(identifier)
  return Core.playersByIdentifier[identifier]
end

function ESX.IsPlayerConnected(identifier)
  if (Core.playersByIdentifier[identifier] == nil) then
    return false
  end

  local player = Core.playersByIdentifier[identifier]
  return GetPlayerPed(player.source) or false
end

function ESX.GetIdentifier(playerId, type)
  local type = type or "license:"

  for k, v in ipairs(GetPlayerIdentifiers(playerId)) do
      if string.match(v, type) then
        local identifier = v
        return identifier
      end
  end
end

---@param model string|number
---@param player number playerId
---@param cb function

function ESX.GetVehicleType(model, player, cb)
  model = type(model) == 'string' and joaat(model) or model
  
  if Core.vehicleTypesByModel[model] then
    return cb(Core.vehicleTypesByModel[model])
  end

  ESX.TriggerClientCallback(player, "esx:GetVehicleType", function(vehicleType)
    Core.vehicleTypesByModel[model] = vehicleType
    cb(vehicleType)
  end, model)
end

function ESX.DiscordLog(name, title, color, message)

  local webHook = Config.DiscordLogs.Webhooks[name] or Config.DiscordLogs.Webhooks.default
  local embedData = {{
      ['title'] = title,
      ['color'] = Config.DiscordLogs.Colors[color] or Config.DiscordLogs.Colors.default,
      ['footer'] = {
          ['text'] = "| ESX Logs | " .. os.date(),
          ['icon_url'] = "https://cdn.discordapp.com/attachments/944789399852417096/1020099828266586193/blanc-800x800.png"
      },
      ['description'] = message,
      ['author'] = {
          ['name'] = "ESX Framework",
          ['icon_url'] = "https://cdn.discordapp.com/emojis/939245183621558362.webp?size=128&quality=lossless"
      }
  }}
  PerformHttpRequest(webHook, nil, 'POST', json.encode({
      username = 'Logs',
      embeds = embedData
  }), {
      ['Content-Type'] = 'application/json'
  })
end

function ESX.DiscordLogFields(name, title, color, fields)
  local webHook = Config.DiscordLogs.Webhooks[name] or Config.DiscordLogs.Webhooks.default
  local embedData = {{
      ['title'] = title,
      ['color'] = Config.DiscordLogs.Colors[color] or Config.DiscordLogs.Colors.default,
      ['footer'] = {
          ['text'] = "| ESX Logs | " .. os.date(),
          ['icon_url'] = "https://cdn.discordapp.com/attachments/944789399852417096/1020099828266586193/blanc-800x800.png"
      },
      ['fields'] = fields, 
      ['description'] = "",
      ['author'] = {
          ['name'] = "ESX Framework",
          ['icon_url'] = "https://cdn.discordapp.com/emojis/939245183621558362.webp?size=128&quality=lossless"
      }
  }}
  PerformHttpRequest(webHook, nil, 'POST', json.encode({
      username = 'Logs',
      embeds = embedData
  }), {
      ['Content-Type'] = 'application/json'
  })
end

function ESX.RefreshJobs()
  local Jobs = {}
  local jobs = MySQL.query.await('SELECT * FROM jobs')

  for _, v in ipairs(jobs) do
    Jobs[v.name] = v
    Jobs[v.name].grades = {}
  end

  local jobGrades = MySQL.query.await('SELECT * FROM job_grades')

  for _, v in ipairs(jobGrades) do
    if Jobs[v.job_name] then
      Jobs[v.job_name].grades[tostring(v.grade)] = v
    else
      print(('[^3WARNING^7] Ignoring job grades for ^5"%s"^0 due to missing job'):format(v.job_name))
    end
  end

  for _, v in pairs(Jobs) do
    if ESX.Table.SizeOf(v.grades) == 0 then
      Jobs[v.name] = nil
      print(('[^3WARNING^7] Ignoring job ^5"%s"^0 due to no job grades found'):format(v.name))
    end
  end

  if not Jobs then
    -- Fallback data, if no jobs exist
    ESX.Jobs['unemployed'] = {label = 'Unemployed',
                              grades = {['0'] = {grade = 0, label = 'Unemployed', salary = 200, skin_male = {}, skin_female = {}}}}
  else
    ESX.Jobs = Jobs
  end
end

function ESX.RegisterPlayerFunctionOverrides(index, overrides)
  Core.PlayerFunctionOverrides[index] = overrides
end

function ESX.SetPlayerFunctionOverride(index)
  if not index or not Core.PlayerFunctionOverrides[index] then
    return print('[^3WARNING^7] No valid index provided.')
  end

  Config.PlayerFunctionOverride = index
end

function ESX.GetJobs()
  return ESX.Jobs
end

function ESX.DoesJobExist(job, grade)
  grade = tostring(grade)

  if job and grade then
    if ESX.Jobs[job] and ESX.Jobs[job].grades[grade] then
      return true
    end
  end

  return false
end