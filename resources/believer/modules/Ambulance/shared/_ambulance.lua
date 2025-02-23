GM.Ambulance = {}

GM.Ambulance.Locker = {
    vector3(318.10848999023,-586.43981933594,43.26127243042),
}

GM.Ambulance.Garage = {
    {
        name = "garage_1",
        label = "Garage 1",
        position = vector3(292.74591064453,-598.01800537109,43.26664352417),
        helpNotification = "pour ouvrir le garage.",
        ped = {
            model = GetHashKey("s_m_m_doctor_01"),
            position = vector3(293.5500793457,-598.27740478516,43.296199798584),
            heading = 70.86
        },
        vehicles = {
            position = {
                vector4(290.45303344727,-596.34027099609,42.910606384277, 342.99),
            },
            list = {
                ["unmarked"] = {
                    "ambulance",
                },
                ["all"] = {
                    "ambulance",
                }
            },
        }
    },
}

GM.Ambulance.Duty = {
    {
        name = "duty_1",
        label = "Prise de service 1",
        position = vector3(313.7766418457,-588.81115722656,43.261241912842),
        helpNotification = "pour prendre votre service.",
        ped = {
            model = GetHashKey("s_m_m_doctor_01"),
            position = vector3(315.80999755859,-588.0927734375,43.261241912842),
            heading = 102.04
        },
    },
}

GM.Ambulance.Wardrobe = {
    {
        name = "wardrobe_1",
        label = "Vestiaire 1",
        position = vector3(299.38003540039,-597.50799560547,43.284076690674),
        helpNotification = "pour ouvrir le vestiaire.",
        outfits = {
            {
                name = "Medecin",
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
        }
    },
}

-- GM.Ambulance.Shop = {
--     {
--         name = "shop_1",
--         shopName = "Pharmacie 1",
--         position = vector3(306.65182495117,-601.12628173828,43.284076690674),
--         helpNotification = "pour accéder à la phamarcie.",
--         items = {
--             {
--                 name = "bandage",
--                 price = 30,
--                 meta = {
--                     grade = 0,
--                 }
--             },
--             {
--                 name = "medikit",
--                 price = 50,
--                 meta = {
--                     grade = 0,
--                 }
--             },
--         }
--     },
-- }

GM.Ambulance.Menu = {
    backup = {
        {
            name = "backup_1",
            label = "Backup 1",
            grade = 0,
            message = "Message de backup 1",
        },
    },
}

GM.Ambulance.QuitJob = {
    {
        name = "handcuffs",
        label = "Menottes",
    },
}

GM.Ambulance.callDelete = 10 -- Automatic delete of the call after x minutes