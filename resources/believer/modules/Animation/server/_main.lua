GM.Animation = GM.Animation or {}

GM.Animation.Favorite = {}

RegisterServerEvent('Animation:saveEmote')
AddEventHandler('Animation:saveEmote', function(dict, anim,name, param)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    MySQL.query('SELECT * FROM user_animation WHERE licence = ? AND dict = ? AND anim = ?', {playerSelected.identifier, dict, anim}, function(result)
        if (result[1] ~= nil) then
            playerSelected.showNotification("~r~Vous avez déjà cet emote enregistré sous le nom de "..anim..".")
            return
        else
            MySQL.insert('INSERT INTO user_animation (licence, dict, anim, param, name) VALUES (@licence, @dict, @anim, @param, @name)', {
                ['@licence'] = playerSelected.identifier, 
                ['@dict'] = dict, 
                ['@anim'] = anim, 
                ['@param'] = json.encode(param), 
                ['@name'] = name
            }, function(emoteId)
                GM.Animation.Favorite[playerSelected.source][emoteId] = {
                    ['id'] = emoteId, 
                    ['name'] = name, 
                    ['dict'] = dict, 
                    ['anim'] = anim, 
                    ['param'] = param
                }
                playerSelected.showNotification("~g~Vous avez bien enregistré votre emote sous le nom de "..GM.Animation.Favorite[playerSelected.source][emoteId].name..".")
                TriggerClientEvent("Animation:updateValue", playerSelected.source, "favorite", emoteId, GM.Animation.Favorite[playerSelected.source][emoteId])
            end)
        end
    end)
end)

AddEventHandler("esx:playerLoaded", function(playerSrc)
    local playerSrc = playerSrc
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    GM.Animation.Favorite[playerSelected.source] = {}

    MySQL.query("SELECT * FROM user_animation WHERE licence = @licence", {
        ['@licence'] = playerSelected.identifier,
    }, function(animations)

        animationsCount = 0

        for _,v in pairs(animations) do
            animationsCount = animationsCount + 1
            GM.Animation.Favorite[playerSelected.source][v['id']] = {
                ['id'] = v['id'], 
                ['name'] = v['name'], 
                ['dict'] = v['dict'], 
                ['anim'] = v['anim'], 
                ['param'] = v['param']
            }
        end

        TriggerClientEvent("Animation:updateValue", playerSelected.source, "favorite", GM.Animation.Favorite[playerSelected.source])
        print(('[^2INFO^0] Player ^5"%s"^0 animation modules has load ^5%s^7 animations to the server'):format(playerSelected.getName(), animationsCount))
    end)
end)

RegisterServerEvent("Animations:removeFavorite", function(emoteId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Animation.Favorite[playerSelected.source][emoteId] == nil) then
        playerSelected.showNotification("~r~Vous n'avez pas cet emote enregistré.")
        return
    end

    MySQL.Async.execute("DELETE FROM user_animation WHERE licence = @licence AND id = @id", {
        ['@licence'] = playerSelected.identifier,
        ['@id'] = emoteId
    }, function()
        GM.Animation.Favorite[playerSelected.source][emoteId] = nil
        playerSelected.showNotification("~r~Vous avez bien supprimé votre emote enregistré ("..emoteId..").")
        TriggerClientEvent("Animation:removeValue", playerSelected.source, "favorite", emoteId)
    end)
end)

RegisterServerEvent("Animation:renameFavorite", function(emoteId, newName)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Animation.Favorite[playerSelected.source][emoteId] == nil) then
        playerSelected.showNotification("~r~Vous n'avez pas cet emote enregistré.")
        return
    end

    GM.Animation.Favorite[playerSelected.source][emoteId].name = newName

    MySQL.Async.execute("UPDATE user_animation SET name = @name WHERE licence = @licence AND id = @id", {
        ['@licence'] = playerSelected.identifier,
        ['@id'] = emoteId,
        ['@name'] = GM.Animation.Favorite[playerSelected.source][emoteId].name
    }, function()
        playerSelected.showNotification("~g~Vous avez bien renommé votre emote enregistré ("..emoteId..") en "..newName..".")
        TriggerClientEvent("Animation:updateValue", playerSelected.source, "favorite", emoteId, GM.Animation.Favorite[playerSelected.source][emoteId])
    end)
end)

RegisterServerEvent('Animations:syncAccepted')
AddEventHandler('Animations:syncAccepted', function(targetSrc, animationId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerCoords = playerSelected.getCoords(true)

    local targetSelected = ESX.GetTargetFromId(targetSrc)
    if (not targetSelected) then return end

    local targetCoords = targetSelected.getCoords(true)

    if #(playerCoords-targetCoords) > 5.0 then
        playerSelected.showNotification("~r~Vous êtes trop loin de la personne.")
        -- Todo suspect this cause maybe cheater
        return
    end


    TriggerClientEvent('Animations:playSynced', playerSelected.source, targetSelected.source, animationId, 'Accepter')
    TriggerClientEvent('Animations:playSynced', targetSelected.source, playerSelected.source, animationId, 'Requester')
end)

RegisterServerEvent('Animations:requestSynced')
AddEventHandler('Animations:requestSynced', function(target, animationId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerCoords = playerSelected.getCoords(true)

    local targetSelected = ESX.GetPlayerFromId(target)
    if (not targetSelected) then return end

    local targetCoords = targetSelected.getCoords(true)

    if #(playerCoords-targetCoords) > 5.0 then
        playerSelected.showNotification("~r~Vous êtes trop loin de la personne.")
        -- Todo suspect this cause maybe cheater
        return
    end

    local firstName = playerSelected.get('firstname')

    TriggerClientEvent('Animations:syncRequest', target, playerSelected.source, animationId, firstName)
end)