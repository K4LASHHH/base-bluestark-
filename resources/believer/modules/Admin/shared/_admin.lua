GM.Admin = GM.Admin or {}

GM.Admin.ReportCooldown = 10 -- Minutes

GM.Admin.Permissions = {
    ["CREATE_RANK"] = {
        label = "Créer un rank",
        description = "Permet de créer un rank",
        error = "~r~Vous n'avez pas la permission de créer un nouveau rank.",
        value = false
    },
    ["RECRUIT_PLAYER_RANK"] = {
        label = "Recruter un joueur",
        description = "Permet de recruter un joueur dans un rank",
        error = "~r~Vous n'avez pas la permission de recruter un joueur dans un rank.",
        value = false
    },
    ["KICK_PLAYER_RANK"] = {
        label = "Expulser un joueur d'un rank",
        description = "Permet d'expulser un joueur d'un rank",
        error = "~r~Vous n'avez pas la permission d'expulser un joueur d'un rank.",
        value = false
    },
    ["MANAGE_RANK_COMMANDS"] = {
        label = "Gérer les commandes d'un rank",
        description = "Permet de gérer les commandes d'un rank",
        error = "~r~Vous n'avez pas la permission de gérer les commandes d'un rank.",
        value = false
    },
    ["MANAGE_RANK_PERMISSIONS"] = {
        label = "Gérer les permissions d'un rank",
        description = "Permet de gérer les permissions d'un rank",
        error = "~r~Vous n'avez pas la permission de gérer les permissions d'un rank.",
        value = false
    },
    ["MY_PLAYER_GIVEALLWEAPONS"] = {
        label = "Donner toutes les armes",
        description = "Permet de donner toutes les armes",
        error = "~r~Vous n'avez pas la permission de donner toutes les armes.",
        value = false
    },
    ["MY_PLAYER_REMOVEALLWEAPONS"] = {
        label = "Retirer toutes les armes",
        description = "Permet de retirer toutes les armes",
        error = "~r~Vous n'avez pas la permission de retirer toutes les armes.",
        value = false
    },
    ["MY_PLAYER_GAMERTAG"] = {
        label = "Afficher les gamertags",
        description = "Permet d'afficher les gamertags",
        error = "~r~Vous n'avez pas la permission d'afficher les gamertags.",
        value = false
    },
    ["MY_PLAYER_BLIPS"] = {
        label = "Afficher les blips",
        description = "Permet d'afficher les blips",
        error = "~r~Vous n'avez pas la permission d'afficher les blips.",
        value = false
    },
    ["MY_PLAYER_INVISIBLESTAFF"] = {
        label = "Invisible par les admins",
        description = "Permet de ne pas être vu par les admins",
        error = "~r~Vous n'avez pas la permission d'être invisible par les admins.",
        value = false
    },
    ["CREATE_DRUGS"] = {
        label = "Créer une drogue",
        description = "Permet de créer une drogue",
        error = "~r~Vous n'avez pas la permission de créer une drogue.",
        value = false
    },
    ["DELETE_DRUGS"] = {
        label = "Supprimer une drogue",
        description = "Permet de créer des drogues",
        error = "~r~Vous n'avez pas la permission de créer des drogues.",
        value = false
    },
    ["MODIFY_DRUGS"] = {
        label = "Modifié une drogue",
        description = "Permet de modifié une drogue",
        error = "~r~Vous n'avez pas la permission de modifié une drogue.",
        value = false
    },
    ["SEND_ALL_CHAT"] = {
        label = "Envoyer des chat (ALL)",
        description = "Permet d'envoyer des chat (ALL)",
        error = "~r~Vous n'avez pas la permission d'envoyer des chat (ALL).",
        value = false
    },
    ["MODIFY_ARENAWARS"] = {
        label = "Modifier ArenaWars",
        description = "Permet de modifier ArenaWars",
        error = "~r~Vous n'avez pas la permission de modifier ArenaWars.",
        value = false
    },
    ["CREATE_ENTERPRISE"] = {
        label = "Créer une entreprise",
        description = "Permet de créer une entreprise",
        error = "~r~Vous n'avez pas la permission de créer une entreprise.",
        value = false
    },
    ["CREATE_ENTERPRISE_RANK"] = {
        label = "Créer un grade d'entreprise",
        description = "Permet de créer un grade d'entreprise",
        error = "~r~Vous n'avez pas la permission de créer un grade d'entreprise.",
        value = false
    },
    ["UPDATE_ENTERPRISE_PERMISSIONS"] = {
        label = "Modifier les permissions d'une entreprise",
        description = "Permet de modifier les permissions d'une entreprise",
        error = "~r~Vous n'avez pas la permission de modifier les permissions d'une entreprise.",
        value = false
    },
    ["DELETE_ENTERPRISE_RANK"] = {
        label = "Supprimer un rank d'entreprise",
        description = "Permet de supprimer un rank d'entreprise",
        error = "~r~Vous n'avez pas la permission de supprimer un rank d'entreprise.",
        value = false
    },
    ["RECRUIT_ENTERPRISE_PLAYER"] = {
        label = "Recruter un joueur dans l'entreprise",
        description = "Permet de recruter un joueur dans l'entreprise",
        error = "~r~Vous n'avez pas la permission de recruter un joueur dans l'entreprise.",
        value = false
    },
    ["KICK_ENTERPRISE_PLAYER"] = {
        label = "Virer un joueur de l'entreprise",
        description = "Permet de virer un joueur de l'entreprise",
        error = "~r~Vous n'avez pas la permission de virer un joueur de l'entreprise.",
        value = false
    },
    ["DELETE_ENTERPRISE"] = {
        label = "Supprimer une entreprise",
        description = "Permet de supprimer une entreprise",
        error = "~r~Vous n'avez pas la permission de supprimer une entreprise.",
        value = false
    },
    ["CHANGE_ENTERPRISE_RANK_ID"] = {
        label = "Changer la hiéarchie d'un grade d'entreprise",
        description = "Permet de changer la hiéarchie d'un grade d'entreprise",
        error = "~r~Vous n'avez pas la permission de changer la hiéarchie d'un grade d'entreprise.",
        value = false
    },
    ["CHANGE_ENTERPRISE_ZONE_POSITION"] = {
        label = "Changer la position d'une zone d'entreprise",
        description = "Permet de changer la position d'une zone d'entreprise",
        error = "~r~Vous n'avez pas la permission de changer la position d'une zone d'entreprise.",
        value = false
    },
    ["CHANGE_MAZE_BANK_ARENA"] = {
        label = "Changer l'arène de Maze Bank",
        description = "Permet de changer l'arène de Maze Bank",
        error = "~r~Vous n'avez pas la permission de changer l'arène de Maze Bank.",
        value = false
    },
    ["BOUTIQUE_ADDVEHICLE"] = {
        label = "Ajouter un véhicule à la boutique",
        description = "Permet d'ajouter un véhicule à la boutique",
        error = "~r~Vous n'avez pas la permission d'ajouter un véhicule à la boutique.",
        value = false
    },
    ["AROUND_ME_VEHICLES"] = {
        label = "Supprimer des véhicules",
        description = "Permet de supprimer des véhicules",
        error = "~r~Vous n'avez pas la permission de supprimer des véhicules.",
        value = false
    },
    ["AROUND_ME_PNJS"] = {
        label = "Supprimer des PNJs",
        description = "Permet de supprimer des PNJs",
        error = "~r~Vous n'avez pas la permission de supprimer des PNJs.",
        value = false
    },
    ["AROUND_ME_OBJECTS"] = {
        label = "Supprimer des props",
        description = "Permet de supprimer des props",
        error = "~r~Vous n'avez pas la permission de supprimer des props.",
        value = false
    },
    ["AROUND_ME_REVIVE"] = {
        label = "Réanimer des joueurs (zone)",
        description = "Permet de réanimer des joueurs (zone)",
        error = "~r~Vous n'avez pas la permission de réanimer des joueurs (zone).",
        value = false
    },
    ["AROUND_ME_HEAL"] = {
        label = "Heal des joueurs (zone)",
        description = "Permet de heal des joueurs (zone)",
        error = "~r~Vous n'avez pas la permission de heal des joueurs (zone).",
        value = false
    },
    -- VEHICLES
    ["VEHICLES_REPAIR"] = {
        label = "Réparer un véhicule",
        description = "Permet de réparer un véhicule",
        error = "~r~Vous n'avez pas la permission de réparer un véhicule.",
        value = false
    },
    -- PLAYERS
    ["PLAYER_INFORMATIONS"] = {
        label = "Informations d'un joueur",
        description = "Permet d'obtenir les informations d'un joueur",
        error = "~r~Vous n'avez pas la permission d'obtenir les informations d'un joueur.",
        value = false
    },
    ["PLAYER_WARNING"] = {
        label = "Avertir un joueur",
        description = "Permet d'avertir un joueur",
        error = "~r~Vous n'avez pas la permission d'avertir un joueur.",
        value = false
    },
    ["PLAYER_SANCTIONS"] = {
        label = "Sanctions d'un joueur",
        description = "Permet d'obtenir les sanctions d'un joueur",
        error = "~r~Vous n'avez pas la permission d'obtenir les sanctions d'un joueur.",
        value = false
    },
    ["PLAYER_VEHICLES"] = {
        label = "Véhicules d'un joueur",
        description = "Permet d'obtenir les véhicules d'un joueur",
        error = "~r~Vous n'avez pas la permission d'obtenir les véhicules d'un joueur.",
        value = false
    },
    ["PLAYER_KILL"] = {
        label = "Tuer un joueur",
        description = "Permet de tuer un joueur",
        error = "~r~Vous n'avez pas la permission de tuer un joueur.",
        value = false
    },
    ["PLAYER_RESET_IDENTITY"] = {
        label = "Réinitialiser l'identité d'un joueur",
        description = "Permet de réinitialiser l'identité d'un joueur",
        error = "~r~Vous n'avez pas la permission de réinitialiser l'identité d'un joueur.",
        value = false
    },
    ["PLAYER_VEHICLES_IMPOUND"] = {
        label = "Mettre en fourrière un véhicule",
        description = "Permet de mettre en fourrière un véhicule",
        error = "~r~Vous n'avez pas la permission de mettre en fourrière un véhicule.",
        value = false
    }
}