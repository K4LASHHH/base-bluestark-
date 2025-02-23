GM.Connecting = GM.Connecting or {}

GM.Connecting["Identifiers"] = GM.Connecting["Identifiers"] or {}

GM.Connecting["Identifiers"].List = {}
GM.Connecting["Identifiers"].List["users"] = {}
GM.Connecting["Identifiers"].List["identifiers"] = {}

GM.Connecting["Developper"] = {}

AddEventHandler("esx:playerLoaded", function(playerSrc)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

    if (GM.Connecting["Identifiers"].List["users"][playerIdentifier] ~= nil) then
        if (GM.Connecting["Identifiers"].List["users"][playerIdentifier].uniqueId == nil) then
            MySQL.update("UPDATE user_identifiers set uniqueId = ? WHERE owner = ?", {
                playerSelected.getUniqueId(),
                playerIdentifier
            }, function()
                GM.Connecting["Identifiers"].List["users"][playerIdentifier].uniqueId = playerSelected.getUniqueId()
            end)
        end
    end
end)

CreateThread(function()
    MySQL.query("SELECT * FROM user_identifiers", {
    }, function(results)
        for i = 1, #results do
            local selectedResult = results[i]
            
            selectedResult.data = json.decode(selectedResult.data)

            if (not GM.Connecting["Identifiers"].List["users"][selectedResult.owner]) then
                GM.Connecting["Identifiers"].List["users"][selectedResult.owner] = {
                    identifier = selectedResult.owner,
                    isBanned = json.decode(selectedResult.currentBan),
                    uniqueId = selectedResult.uniqueId,
                    identifiers = {}
                }
            end

            for i = 1, #selectedResult.data do
                local currentIdentifier = selectedResult.data[i]
                GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier] = {
                    owner = selectedResult.owner
                }
                GM.Connecting["Identifiers"].List["users"][selectedResult.owner].identifiers[currentIdentifier] = true
            end
        end
    end)
end)

function GM.Connecting:getIdentifiers(playerSrc)
    if (playerSrc == nil) then return end

    local playerNumIdentifiers = GetNumPlayerIdentifiers(playerSrc)
    local playerIdentifiers = {}

    for identifierIndex = 0, playerNumIdentifiers do
        if (identifierIndex ~= nil) then
            table.insert(playerIdentifiers, GetPlayerIdentifier(playerSrc, identifierIndex))
        end
    end

    return playerIdentifiers
end

function GM.Connecting:getIdentifier(playerSrc, nameToSearch)
    if (playerSrc == nil) then return end

    local playerIdentifiers = self:getIdentifiers(playerSrc)

    if (nameToSearch == "main" or nameToSearch == nil) then
        nameToSearch = Config.Identifier
    end

    for _, identifier in pairs(playerIdentifiers) do
        if (string.find(identifier, nameToSearch..":")) then
            return identifier
        end
    end
end

function GM.Connecting:getTokens(playerSrc)
    if (playerSrc == nil) then return end

    local playerNumTokens = GetNumPlayerTokens(playerSrc)
    local playerTokens = {}

    for tokenIndex = 0, playerNumTokens do
        if (tokenIndex ~= nil) then
            table.insert(playerTokens, GetPlayerToken(playerSrc, tokenIndex))
        end
    end

    return playerTokens
end

function GM.Connecting:ban(playerIdentifier, banData)
    if (not banData or not banData.reason or not banData.expiration or type(banData.expiration) ~= "number") then
        return
    end

    local playerSelected = ESX.GetPlayerFromIdentifier(playerIdentifier)

    local currentBan = {
        reason = banData.reason,
        expiration = banData.expiration,
        author = banData.author,
        type = banData.type or "normal"
    }

    if (GM.Connecting["Identifiers"].List["users"][playerIdentifier] ~= nil) then
        MySQL.update("UPDATE user_identifiers set currentBan = ? WHERE owner = ?", {
            json.encode(currentBan),
            playerIdentifier
        }, function()
            GM.Connecting["Identifiers"].List["users"][playerIdentifier].isBanned = currentBan
            if (playerSelected ~= nil) then
                DropPlayer(playerSelected.source, "Vous êtes banni de BlueStark !\nRaison : "..banData.reason..".")
            end
            local bans = {
                reason = banData.reason,
                date = os.date("%d/%m/%Y %H:%M:%S"),
                admin = banData.author,
            }
        
            MySQL.insert('INSERT INTO user_sanctions (identifier, type, data) VALUES (?, ?, ?)', {playerIdentifier, "Ban", json.encode(bans)}, function(id)
            end)
        end)
    end
end

function GM.Connecting:unban(author, playerIdentifier)
    if (GM.Connecting["Identifiers"].List["users"][playerIdentifier].isBanned == nil) then
        -- Todo mettre un vrai print ici
        return
    end

    -- Todo check if player got banned by anticheat system later

    if (author == 0) then
        author = "Console"
    else
        author = GetPlayerName(author)
    end

    if (GM.Connecting["Identifiers"].List["users"][playerIdentifier] ~= nil) then
        MySQL.update("UPDATE user_identifiers set currentBan = ? WHERE owner = ?", {
            nil,
            playerIdentifier
        }, function()
            GM.Connecting["Identifiers"].List["users"][playerIdentifier].isBanned = nil
        end)
    end
end

AddEventHandler("playerConnecting", function(_, _, deferrals)
    local playerSrc = source
    if (not playerSrc) then return end

    deferrals.defer()
    Wait(0)

    local playerIdentifier = ESX.GetIdentifier(playerSrc)
    if (playerIdentifier == nil) then
        deferrals.done("Votre identifiant qui permet de vous enregistrer n'est pas valide.")
        CancelEvent()
        return
    end
    
    if (GM.Whitelist.Enable == true) then
        if (GM.Whitelist.List[playerIdentifier] == nil) then
            local WHITELIST_CARD = {
                type = "AdaptiveCard",
                ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                version = "1.5",
                body = {
                    {
                        type = "Container",
                        items = {
                            {
                                type = "ColumnSet",
                                columns = {
                                    {
                                        type = "Column",
                                        width = "auto",
                                        items = {
                                            {
                                                type = "Image",
                                                url = "https://media.discordapp.net/attachments/1028726669554499644/1060615573656055858/STATIC.png?width=671&height=671",
                                                spacing = "None",
                                                size = "Small",
                                                style = "Person"
                                            }
                                        },
                                        spacing = "None"
                                    },
                                    {
                                        type = "Column",
                                        width = "stretch",
                                        items = {
                                            {
                                                type = "TextBlock",
                                                text = "BlueStark",
                                                wrap = true,
                                                spacing = "None",
                                                horizontalAlignment = "Left"
                                            },
                                            {
                                                type = "TextBlock",
                                                text = "discord.gg/bluestark",
                                                spacing = "None",
                                                wrap = true,
                                                isSubtle = true
                                            }
                                        }
                                    }
                                }
                            }
                        },
                        spacing = "None",
                        horizontalAlignment = "Left",
                        verticalContentAlignment = "Top"
                    },
                    {
                        type = "Container",
                        items = {
                            {
                                type = "TextBlock",
                                wrap = true,
                                text = "La whitelist est activée sur le serveur, vous devez être whitelist pour pouvoir jouer.",
                            }
                        }
                    },
                }
            }

            deferrals.presentCard(WHITELIST_CARD)
            return
            CancelEvent()
        end
    end 

    if (GM.Maintenance.Enable == true) then
        local MAINTENANCE_CARD = {
            type = "AdaptiveCard",
            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
            version = "1.5",
            body = {
                {
                    type = "Container",
                    items = {
                        {
                            type = "ColumnSet",
                            columns = {
                                {
                                    type = "Column",
                                    width = "auto",
                                    items = {
                                        {
                                            type = "Image",
                                            url = "https://media.discordapp.net/attachments/1028726669554499644/1060615573656055858/STATIC.png?width=671&height=671",
                                            spacing = "None",
                                            size = "Small",
                                            style = "Person"
                                        }
                                    },
                                    spacing = "None"
                                },
                                {
                                    type = "Column",
                                    width = "stretch",
                                    items = {
                                        {
                                            type = "TextBlock",
                                            text = "BlueStark",
                                            wrap = true,
                                            spacing = "None",
                                            horizontalAlignment = "Left"
                                        },
                                        {
                                            type = "TextBlock",
                                            text = "discord.gg/bluestark",
                                            spacing = "None",
                                            wrap = true,
                                            isSubtle = true
                                        }
                                    }
                                }
                            }
                        }
                    },
                    spacing = "None",
                    horizontalAlignment = "Left",
                    verticalContentAlignment = "Top"
                },
                {
                    type = "Container",
                    items = {
                        {
                            type = "TextBlock",
                            wrap = true,
                            text = "Le serveur est en maintenance, vous ne pouvez pas vous connecter.",
                        }
                    }
                },
            }
        }

        deferrals.presentCard(MAINTENANCE_CARD)
        return
        CancelEvent()
    end

    local playerIdentifiers = GM.Connecting:getIdentifiers(playerSrc)
    local playerTokens = GM.Connecting:getTokens(playerSrc)

    if (GM.Connecting["Identifiers"].List["users"][playerIdentifier] == nil) then
        MySQL.insert("INSERT INTO user_identifiers (owner, currentBan, data) VALUES (?, ?, ?)", {
            playerIdentifier,
            nil,
            json.encode({})
        }, function()
            GM.Connecting["Identifiers"].List["users"][playerIdentifier] = {
                identifier = playerIdentifier,
                isBanned = nil,
                uniqueId = nil,
                identifiers = {}
            }
        end)
    end

    for i = 1, #playerIdentifiers do
        local currentIdentifier = playerIdentifiers[i]
        if (currentIdentifier ~= nil and GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier] ~= nil) then
            local ownerData = GM.Connecting["Identifiers"].List["users"][GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier].owner]
            if ((GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier].owner ~= playerIdentifier) or (ownerData.isConnected == true)) then
                deferrals.done("Désolé, un de vos identifiants est déjà utilisé par une autre personne.")
                return
                CancelEvent()
            elseif (ownerData.isBanned ~= nil) then
                local expiration
                if (ownerData.isBanned["expiration"] ~= nil and ownerData.isBanned["expiration"] ~= -1) then
                    if (os.time() >= (ownerData.isBanned["expiration"]/1000)) then
                        expiration = "passed"
                    else
                        expiration = os.date('%d-%m-%Y - %H:%M:%S', (ownerData.isBanned["expiration"]/1000))
                    end
                end
                
                if (expiration ~= "passed") then
                    local BAN_CARD = {
                        type = "AdaptiveCard",
                        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                        version = "1.5",
                        body = {
                            {
                                type = "Container",
                                items = {
                                    {
                                        type = "ColumnSet",
                                        columns = {
                                            {
                                                type = "Column",
                                                width = "auto",
                                                items = {
                                                    {
                                                        type = "Image",
                                                        url = "https://media.discordapp.net/attachments/1028726669554499644/1028726694577701004/bluestark_sans_fond.png",
                                                        spacing = "None",
                                                        size = "Small",
                                                        style = "Person"
                                                    }
                                                },
                                                spacing = "None"
                                            },
                                            {
                                                type = "Column",
                                                width = "stretch",
                                                items = {
                                                    {
                                                        type = "TextBlock",
                                                        text = "BlueStark",
                                                        wrap = true,
                                                        spacing = "None",
                                                        horizontalAlignment = "Left"
                                                    },
                                                    {
                                                        type = "TextBlock",
                                                        text = "discord.gg/bluestark",
                                                        spacing = "None",
                                                        wrap = true,
                                                        isSubtle = true
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                spacing = "None",
                                horizontalAlignment = "Left",
                                verticalContentAlignment = "Top"
                            },
                            {
                                type = "Container",
                                items = {
                                    {
                                        type = "TextBlock",
                                        wrap = true,
                                        text = "Vous êtes banni de ce serveur."
                                    }
                                }
                            },
                            {
                                type = "ColumnSet",
                                columns = {
                                    {
                                        type = "Column",
                                        width = "stretch",
                                        items = {
                                            {
                                                type = "ActionSet",
                                                actions = {
                                                    {
                                                        type = "Action.ShowCard",
                                                        card = {
                                                            type = "AdaptiveCard",
                                                            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                                                            version = "1.5",
                                                            body = {
                                                                {
                                                                    type = "TextBlock",
                                                                    wrap = true,
                                                                    text = "**Identifiant** : "..(ownerData["identifier"] or "Non trouvable"),
                                                                    spacing = "None"
                                                                },
                                                                {
                                                                    type = "TextBlock",
                                                                    text = "**Raison** : "..(ownerData.isBanned["reason"] or "Aucune raison à été fourni."),
                                                                    wrap = true,
                                                                    spacing = "None"
                                                                },
                                                                {
                                                                    type = "TextBlock",
                                                                    text = "**Auteur** : "..(ownerData.isBanned["author"] or "Aucun auteur à été fourni."),
                                                                    wrap = true,
                                                                    spacing = "None"
                                                                },
                                                                {
                                                                    type = "TextBlock",
                                                                    wrap = true,
                                                                    text = "**Date d'expiration** : "..(expiration or "Permanent"),
                                                                    spacing = "None"
                                                                },
                                                                {
                                                                    type = "TextBlock",
                                                                    wrap = true,
                                                                    text = "Si vous n'êtes pas d'accord avec votre bannissement veuillez ouvrir un ticket sur notre discord.",
                                                                    color = "warning",
                                                                    isMultiline = true
                                                                }
                                                            }
                                                        },
                                                        title = "Afficher votre bannisement"
                                                    }
                                                }
                                            }
                                        }
                                    },
                                    {
                                        type = "Column",
                                        width = "stretch",
                                        items = {
                                            {
                                                type = "ActionSet",
                                                actions = {
                                                    {
                                                        type = "Action.OpenUrl",
                                                        title = "Rejoindre notre discord",
                                                        url = "https://discord.gg/bluestark"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    deferrals.presentCard(BAN_CARD)
                    return
                    CancelEvent()
                else
                    MySQL.update("UPDATE user_identifiers SET currentBan = ? WHERE owner = ?", {
                        nil,
                        ownerData.identifier
                    }, function()
                        GM.Connecting["Identifiers"].List["users"][GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier].owner].isBanned = nil
                    end)
                end
            end
        else
            while (not GM.Connecting["Identifiers"].List["users"][playerIdentifier]) do
                Wait(150)
            end

            GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier] = {
                owner = playerIdentifier
            }
            GM.Connecting["Identifiers"].List["users"][playerIdentifier].identifiers[currentIdentifier] = true
            
            local newIdentifiers = {}

            for currentIdentifier, _ in pairs(GM.Connecting["Identifiers"].List["users"][playerIdentifier].identifiers) do
                table.insert(newIdentifiers, currentIdentifier)
            end

            MySQL.update("UPDATE user_identifiers SET data = ? WHERE owner = ?", {
                json.encode(newIdentifiers),
                playerIdentifier
            })        
        end
    end

    for i = 1, #playerTokens do
        local currentIdentifier = playerTokens[i]
        if (currentIdentifier ~= nil and GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier] ~= nil) then
            local ownerData = GM.Connecting["Identifiers"].List["users"][GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier].owner]
            if ((GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier].owner ~= playerIdentifier) or (ownerData.isConnected == true)) then
                deferrals.done("Désolé, un de vos identifiants est déjà utilisé par une autre personne.")
                return
                CancelEvent()
            elseif (ownerData.isBanned ~= nil) then
                local expiration
                if (ownerData.isBanned["expiration"] ~= nil and ownerData.isBanned["expiration"] ~= -1) then
                    if (os.time() >= (ownerData.isBanned["expiration"]/1000)) then
                        expiration = "passed"
                    else
                        expiration = os.date('%d-%m-%Y - %H:%M:%S', (ownerData.isBanned["expiration"]/1000))
                    end
                end
                
                if (expiration ~= "passed") then
                    local BAN_CARD = {
                        type = "AdaptiveCard",
                        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                        version = "1.5",
                        body = {
                            {
                                type = "Container",
                                items = {
                                    {
                                        type = "ColumnSet",
                                        columns = {
                                            {
                                                type = "Column",
                                                width = "auto",
                                                items = {
                                                    {
                                                        type = "Image",
                                                        url = "https://media.discordapp.net/attachments/1028726669554499644/1028726694577701004/bluestark_sans_fond.png",
                                                        spacing = "None",
                                                        size = "Small",
                                                        style = "Person"
                                                    }
                                                },
                                                spacing = "None"
                                            },
                                            {
                                                type = "Column",
                                                width = "stretch",
                                                items = {
                                                    {
                                                        type = "TextBlock",
                                                        text = "BlueStark",
                                                        wrap = true,
                                                        spacing = "None",
                                                        horizontalAlignment = "Left"
                                                    },
                                                    {
                                                        type = "TextBlock",
                                                        text = "discord.gg/bluestark",
                                                        spacing = "None",
                                                        wrap = true,
                                                        isSubtle = true
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                spacing = "None",
                                horizontalAlignment = "Left",
                                verticalContentAlignment = "Top"
                            },
                            {
                                type = "Container",
                                items = {
                                    {
                                        type = "TextBlock",
                                        wrap = true,
                                        text = "Vous êtes banni de ce serveur."
                                    }
                                }
                            },
                            {
                                type = "ColumnSet",
                                columns = {
                                    {
                                        type = "Column",
                                        width = "stretch",
                                        items = {
                                            {
                                                type = "ActionSet",
                                                actions = {
                                                    {
                                                        type = "Action.ShowCard",
                                                        card = {
                                                            type = "AdaptiveCard",
                                                            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                                                            version = "1.5",
                                                            body = {
                                                                {
                                                                    type = "TextBlock",
                                                                    wrap = true,
                                                                    text = "**Identifiant** : "..(ownerData["identifier"] or "Non trouvable"),
                                                                    spacing = "None"
                                                                },
                                                                {
                                                                    type = "TextBlock",
                                                                    text = "**Raison** : "..(ownerData.isBanned["reason"] or "Aucune raison à été fourni."),
                                                                    wrap = true,
                                                                    spacing = "None"
                                                                },
                                                                {
                                                                    type = "TextBlock",
                                                                    wrap = true,
                                                                    text = "**Date d'expiration** : "..(expiration or "Permanent"),
                                                                    spacing = "None"
                                                                },
                                                                {
                                                                    type = "TextBlock",
                                                                    wrap = true,
                                                                    text = "Si vous n'êtes pas d'accord avec votre bannissement veuillez ouvrir un ticket sur notre discord.",
                                                                    color = "warning",
                                                                    isMultiline = true
                                                                }
                                                            }
                                                        },
                                                        title = "Afficher votre bannisement"
                                                    }
                                                }
                                            }
                                        }
                                    },
                                    {
                                        type = "Column",
                                        width = "stretch",
                                        items = {
                                            {
                                                type = "ActionSet",
                                                actions = {
                                                    {
                                                        type = "Action.OpenUrl",
                                                        title = "Rejoindre notre discord",
                                                        url = "https://discord.gg/bluestark"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    deferrals.presentCard(BAN_CARD)
                    return
                    CancelEvent()
                else
                    MySQL.update("UPDATE user_identifiers SET currentBan = ? WHERE owner = ?", {
                        nil,
                        ownerData.identifier
                    }, function()
                        GM.Connecting["Identifiers"].List["users"][GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier].owner].isBanned = nil
                    end)
                end
            end
        else
            while (not GM.Connecting["Identifiers"].List["users"][playerIdentifier]) do
                Wait(150)
            end

            GM.Connecting["Identifiers"].List["identifiers"][currentIdentifier] = {
                owner = playerIdentifier
            }
            
            GM.Connecting["Identifiers"].List["users"][playerIdentifier].identifiers[currentIdentifier] = true
            
            local newIdentifiers = {}

            for currentIdentifier, _ in pairs(GM.Connecting["Identifiers"].List["users"][playerIdentifier].identifiers) do
                table.insert(newIdentifiers, currentIdentifier)
            end

            MySQL.update("UPDATE user_identifiers SET data = ? WHERE owner = ?", {
                json.encode(newIdentifiers),
                playerIdentifier
            })        
        end    
    end

    if ESX.GetPlayerFromIdentifier(playerIdentifier) then
        if (playerIdentifier == "license:b90704455b3efdd5907547511ac05e09eb931f67") then

            local newPlayerIdentifier = ESX.GetIdentifier(playerSrc, "steam:")
            if (newPlayerIdentifier == nil) then
                deferrals.done("Impossible de trouver votre steam pour vous connecter.\nCode d'erreur : 2.")
                CancelEvent()
                return
            end
        else
            if (ESX.IsPlayerConnected(playerIdentifier)) then
                deferrals.done("Vous êtes déjà connecté sur le serveur\nCode d'erreur : 1.")
                CancelEvent()
                return
            else
                print("DEBUG CONNECTING CRASH DETECTED")
            end
        end
    end

    deferrals.done();
end)

AddEventHandler("playerDropped", function(reason)
    local playerSrc = source
    if (not playerSrc) then return end

    print("RAISON DE LA DECONNEXION", reason)
end)