GM.Police = GM.Police or {}

GM.Police.Locker = {
    vector3(-1061.7990722656,-856.48248291016,4.8677086830139),
}

GM.Police.Garage = {
    {
        name = "garage_1",
        label = "Garage 1",
        position = vector3(-1073.4967041016,-859.30712890625,4.8674116134644),
        helpNotification = "pour ouvrir le garage.",
        ped = {
            model = GetHashKey("s_f_y_cop_01"),
            position = vector3(-1075.6857910156,-858.44702148438,5.0418553352356),
            heading = 243.77
        },
        vehicles = {
            position = {
                vector4(-1070.6469726563,-857.72442626953,4.240786075592, 308.97),
            },
            list = {
                ["unmarked"] = {
                    "sultanrs",
                },
                ["all"] = {
                    "infernus",
                    "thrax",
                    "sultan",
                    "primo2",
                }
            },
        }
    },
}

GM.Police.Duty = {
    {
        name = "duty_1",
        label = "Prise de service 1",
        position = vector3(-1070.3204345703,-865.87982177734,4.867723941803),
        helpNotification = "pour prendre votre service.",
        ped = {
            model = GetHashKey("s_m_y_cop_01"),
            position = vector3(-1090.8175048828,-821.10479736328,27.034391403198),
            heading = 34.01
        },
    },
}

GM.Police.Wardrobe = {
    {
        name = "wardrobe_1",
        label = "Vestiaire 1",
        position = vector3(-1092.4991455078,-826.40161132813,26.827428817749),
        helpNotification = "pour ouvrir le vestiaire.",
        outfits = {
            {
                name = "Rookie",
                grade = 0,
                male = {
                    tshirt_1 = 15,  tshirt_2 = 0,
                    torso_1 = 499,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 1,
                    pants_1 = 168,   pants_2 = 5,
                    shoes_1 = 105,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    ears_1 = -1,     ears_2 = 0,
                    mask_1 = 0,     mask_2 = 0,
                    bags_1 = 0,     bags_2 = 0,
                    bproof_1 = 0,     bproof_2 = 0,
                },
                female = {
                    tshirt_1 = 14,  tshirt_2 = 0,
                    torso_1 = 528,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 0,
                    pants_1 = 174,   pants_2 = 0,
                    shoes_1 = 109,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    ears_1 = -1,     ears_2 = 0,
                    mask_1 = 0,     mask_2 = 0,
                    bags_1 = 0,     bags_2 = 0,
                    bproof_1 = 0,     bproof_2 = 0,
                },
            },
            {
                name = "Rookie 2",
                grade = 2,
                male = {
                    tshirt_1 = 15,  tshirt_2 = 0,
                    torso_1 = 499,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 1,
                    pants_1 = 168,   pants_2 = 5,
                    shoes_1 = 105,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    ears_1 = -1,     ears_2 = 0,
                    mask_1 = 0,     mask_2 = 0,
                    bags_1 = 0,     bags_2 = 0,
                    bproof_1 = 0,     bproof_2 = 0,
                },
                female = {
                    tshirt_1 = 14,  tshirt_2 = 0,
                    torso_1 = 528,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 0,
                    pants_1 = 174,   pants_2 = 0,
                    shoes_1 = 109,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    ears_1 = -1,     ears_2 = 0,
                    mask_1 = 0,     mask_2 = 0,
                    bags_1 = 0,     bags_2 = 0,
                    bproof_1 = 0,     bproof_2 = 0,
                },
            },
        }
    },
}

GM.Police.Armory = {
    {
        name = "armory_1",
        label = "Armurerie 1",
        position = vector3(-1065.7542724609,-848.26275634766,5.0419421195984),
        helpNotification = "pour accéder à l'armurerie.",
        items = {
            -- {
            --     name = "weapon_flashlight",
            --     label = "Lampe torche",
            --     grade = 0,
            -- },
            {
                name = "handcuffs",
                label = "Menottes",
                grade = 0,
                price = 200
            },
        }
    },
}

GM.Police.Menu = {
    backup = {
        {
            name = "backup_1",
            label = "Backup 1",
            grade = 0,
            message = "Message de backup 1",
        },
    },
    status = {
        {
            name = "taken_service",
            label = "Prise de service",
            grade = 0,
        },
    }
}

GM.Police.QuitJob = {
    {
        name = "handcuffs",
        label = "Menottes",
    },
}

GM.Police.callDelete = 10 -- Automatic delete of the call after x minutes