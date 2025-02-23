local UUID = 0
local notifications = {}

RegisterNUICallback('nui_ready', function(data, cb)
    cb('ok')
end)

function Send(message, timeout, position, progress, theme, exitAnim, flash, pinned, group, hideStack)

    if type(message) == 'table' then
        return SendCustom(message)
    end

    if message == nil then
        return PrintError("^1BULLETIN ERROR: ^7Notification message is nil")
    end

    message = tostring(message)

    if not tonumber(timeout) then
        timeout = Config.Timeout
    end

    if position == nil then
        position = Config.Position
    end

    if progress == nil then
        if not pinned then
            progress = Config.Progress
        end
    end

    local notif = {
        type        = "standard",
        message     = message,
        timeout     = timeout,
        position    = position,
        progress    = progress,
        theme       = theme,
        exitAnim    = exitAnim,
        flash       = flash,
        pinned      = pinned,
        group       = group,
        hideStack   = hideStack,
    }

    AddNotification(notif)

    return notif.id
end

function SendAdvanced(message, title, subject, icon, timeout, position, progress, theme, exitAnim, flash, pinned, group, hideStack)

    if type(message) == 'table' then
        return SendCustom(message, true)
    end

    if message == nil then
        return PrintError("^1BULLETIN ERROR: ^7Notification message is nil")
    end

    message = tostring(message)

    if title == nil then
        return PrintError("^1BULLETIN ERROR: ^7Notification title is nil")
    end

    if subject == nil then
        return PrintError("^1BULLETIN ERROR: ^7Notification subject is nil")
    end

    if not tonumber(timeout) then
        timeout = Config.Timeout
    end

    if position == nil then
        position = Config.Position
    end

    if progress == nil then
        if not pinned then
            progress = Config.Progress
        end
    end

    if Config.Pictures[icon] then
        icon = 'images/'..Config.Pictures[icon]
    end

    local notif = {
        type        = "advanced",
        message     = message,
        title       = title,
        subject     = subject,
        icon        = icon,
        timeout     = timeout,
        position    = position,
        progress    = progress,
        theme       = theme,
        exitAnim    = exitAnim,
        flash       = flash,
        pinned      = pinned,
        group       = group,
        hideStack   = hideStack,
    }

    AddNotification(notif)

    return notif.id
end

function Remove(uuid)
    if not notifications[uuid] then
        return
    end
    SendNUIMessage({
        type = 'remove',
        id = uuid
    })
end

function Update(uuid, options)
    if not notifications[uuid] then
        return
    end

    for k, v in pairs(options) do
        notifications[uuid][k] = v
    end

    if Config.Pictures[options.icon] then
        options.icon = 'images/'..Config.Pictures[options.icon]
    end

    SendNUIMessage({
        type = 'update',
        id = uuid,
        options = options
    })
end

function SendCustom(options, advanced)
    if type(options) ~= 'table' then
        error("BULLETIN ERROR: options passed to `SendCustom` must be a table")
    end
    if options.type == "standard" or options.type == nil and not advanced then
        return Send(options.message, options.timeout, options.position, options.progress, options.theme, options.exitAnim, options.flash, options.pinned, options.group, options.hideStack)
    elseif advanced ~= nil or options.type == "advanced" then
        return SendAdvanced(options.message, options.title, options.subject, options.icon, options.timeout, options.position, options.progress, options.theme, options.exitAnim, options.flash, options.pinned, options.group, options.hideStack)
    end
end

function AddNotification(notif)
    notif.config = Config

    local id

    if not pinned and notif.group then
        local gid = CheckGroup(notif)
        if gid then
            id = gid
            notif.updateGroup = true
        end
    end

    if not notif.updateGroup and Config.Stacking and not pinned then
        local sid = CheckDuplicate(notif)
        if sid then
            id = sid
            notif.stack = true
        end
    end

    notif.id = id or uuid()

    notifications[notif.id] = notif
    SendNUIMessage(notif)
end

function CheckDuplicate(data)
    for id, notif in pairs(notifications) do
        if not notif.pinned and not notif.hiding and notif.message == data.message and notif.position == data.position then
            return id
        end
    end
end

function CheckGroup(data)
    for id, notif in pairs(notifications) do
        if not notif.pinned and not notif.hiding and notif.group == data.group and notif.position == data.position then
            return id
        end
    end
end

function PrintError(message)
    local s = string.rep("=", string.len(message))
    print(s)
    print(message)
    print(s)
end

function uuid()
    UUID = UUID + 1
    return UUID
end

function SetHUDVisibility(visible)
    SendNUIMessage({
		type = "hud_visible",
		visible = visible
	})
end

RegisterNetEvent("notification:send")
AddEventHandler("notification:send", Send)

RegisterNetEvent("notification:sendAdvanced")
AddEventHandler("notification:sendAdvanced", SendAdvanced)

RegisterNetEvent("notification:sendSuccess")
AddEventHandler("notification:sendSuccess", SendSuccess)

RegisterNetEvent("notification:sendInfo")
AddEventHandler("notification:sendInfo", SendInfo)

RegisterNetEvent("notification:sendWarning")
AddEventHandler("notification:sendWarning", SendWarning)

RegisterNetEvent("notification:sendError")
AddEventHandler("notification:sendError", SendError)

RegisterNetEvent("notification:sendPinned")
AddEventHandler("notification:sendPinned", SendPinned)

RegisterNetEvent("notification:unpin")
AddEventHandler("notification:unpin", Unpin)

RegisterNetEvent("notification:updatePinned")
AddEventHandler("notification:updatePinned", UpdatePinned)

RegisterNUICallback('nui_removed', function(data, cb)
    notifications[data.id] = nil
    cb('ok')
end)

RegisterNUICallback('nui_hiding', function(data, cb)
    notifications[data.id].hiding = true
    cb('ok')
end)
