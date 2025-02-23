ICONS = {
    [11] = {id= "modEngine", icon = "fa-thin fa-engine", kamera = "yukaridan-bak", label = Config.MechanicMenu["Engine"]},
    [12] = {id= "modBrakes", icon = "fa-solid fa-brake-warning", kamera = "ontaraf", label = Config.MechanicMenu["Brakes"]},
    [15] = {id= "modSuspension", icon = "fa-solid fa-sliders", kamera = "ontaraf", label = Config.MechanicMenu["Suspension"]},
    [17] = {id= "modTurbo", icon = "fa-solid fa-gauge", kamera = "ontaraf", label = Config.MechanicMenu["Turbo"]},
    [5] = {id= "modFrame", icon = "../web/img/chassis.png", kamera = "tavan", label = Config.MechanicMenu["Cage"], menu = "back2"},
    [13] = {id = "modTransmission", icon = "../web/img/transmission.png", kamera = "tavan", label = Config.MechanicMenu["Transmission"], menu = "back2"},
    [23] = {id= "modFrontWheels", icon = "fa-solid fa-tire", kamera = "lastikler", label = Config.MechanicMenu["Wheels"], menu = "tekerlekmenusu"},
    [16] = {id= "modArmor", icon = "fa-sharp fa-solid fa-shield", kamera = "seksi-bakis", label = Config.MechanicMenu["Armor"]},
    [14] = {id = "modHorns", icon = "fa-solid fa-bullhorn", kamera = "ontaraf", label = Config.MechanicMenu["Horns"]},
    [48] = {id = "modLivery", icon = "fa-solid fa-car-garage", kamera = "tavan", label = Config.MechanicMenu["Livery"], menu = "renkturleri"},
    [8] = {id = "modFender", icon = "../web/img/fender.png", kamera = "soltaraf", label = Config.MechanicMenu["LeftFender"], menu = "back2"},
    [9] = {id = "modRightFender", icon = "../web/img/fender.png", kamera = "sagtaraf", label = Config.MechanicMenu["RightFender"], menu = "back2"},
    [49] = {id = "modLightbar", icon = "../web/img/farlar.png", kamera = "farlar", label = Config.MechanicMenu["Headlights"], menu = "back2"},
    [1000] = {id = "bodyParts", icon = "fa-regular fa-screwdriver-wrench"},
    [0] = {id = "modSpoilers", icon = "../web/img/spoiler.png", kamera = "arka-ama-genis", label = Config.MechanicMenu["Spoilers"], menu = "back2"},
    [1] = {id = "modFrontBumper", icon = "../web/img/frontbumper.png", kamera = "ontaraf", label = Config.MechanicMenu["FrontBumper"], menu = "back2"},
    [2] = {id = "modRearBumper", icon = "../web/img/rearbumper.png", kamera = "egzoz", label = Config.MechanicMenu["RearBumper"], menu = "back2"},
    [3] = {id = "modSideSkirt", icon = "../web/img/skirt.png", kamera = "soltaraf", label = Config.MechanicMenu["SideSkirt"], menu = "back2"},
    [4] = {id = "modExhaust", icon = "../web/img/exhaust.png", kamera = "egzoz", label = Config.MechanicMenu["Exhaust"], menu = "back2"},
    [6] = {id = "modGrille", icon = "../web/img/grille.png", kamera = "farlar", label = Config.MechanicMenu["Grille"], menu = "back2"},
    [15677] = {id = "windowTint", icon = "../web/img/window.png", kamera = "seksi-bakis", label = Config.MechanicMenu["Windows"], menu = "back2"},
    [7] = {id = "modHood", icon = "../web/img/bonnet.png", kamera = "tavan", label = Config.MechanicMenu["Hood"], menu = "back2"},
    [10] = {id = "modRoof", icon = "../web/img/roof.png", kamera = "tavan", label = Config.MechanicMenu["Roof"], menu = "back2"},
    [1300] = {id = "wheelColor", icon = "fa-regular fa-tire", kamera= "lastikler", label = Config.MechanicMenu["WheelColor"]},
    [1766] = {id = "tyreSmokeColor", icon = "fa-regular fa-tire", kamera= "arka-ama-genis", label = Config.MechanicMenu["TireSmoke"]},
    [1986] = {id = "neonColor", icon = "fa-brands fa-neos", kamera = "neonlar", label = Config.MechanicMenu["Neon"]},
    ["plateIndex"] = {id = "plateIndex", icon = "../web/img/carplate.png", kamera = "arka-ama-genis", label = Config.MechanicMenu["PlateIndex"], menu = "back2"},
    [1996] = {id="color1", icon = "fa-sharp fa-solid fa-palette", label = Config.MechanicMenu["PrimaryColor"], menu = "back"},
    [1997] = {id="color2", icon = "fa-sharp fa-solid fa-palette", label = Config.MechanicMenu["SecondaryColor"]},
    [1998] = {id = "pearlescentColor", icon = "fa-sharp fa-solid fa-palette", label = Config.MechanicMenu["PearlescentColor"]},
    [27] = {id = "modTrimA", icon = "../web/img/interior.png", label = Config.MechanicMenu["Interior"]},
    [36] = {id = "modSpeakers", icon = "../web/img/speakers.png", label = Config.MechanicMenu["Speakers"]},
    [38] = {id = "modHydrolic", icon = "../web/img/modHydrolic.png", label = Config.MechanicMenu["hydrolic"]},
    [29] = {id = "modDashboard", icon = "../web/img/dashboard.png", label = Config.MechanicMenu["dashboard"]},

}

kibraMechanicMenu = {
    {
        menuName = "engine",
        menuLabel = Config.MechanicMenu["Engine"],
        menuIcon = "fa-thin fa-engine",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 11 
    },

    {
        menuName = "bodyparts",
        menuLabel = Config.MechanicMenu["BodyParts"],
        menuIcon = "fa-regular fa-screwdriver-wrench",
        menuImg = false,
        priceDefault = 500,
        type = 1000,
    },

    {
        menuName = "turbo",
        menuLabel = Config.MechanicMenu["Turbo"],
        menuIcon = "fa-solid fa-gauge",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 17
    },

    {
        menuName = "brakes",
        menuLabel = Config.MechanicMenu["Brakes"],
        menuIcon = "fa-solid fa-brake-warning",
        menuImg = false,
        priceDefault = 500,
        type = 12
    },

    {
        menuName = "armor",
        menuLabel = Config.MechanicMenu["Armor"],
        menuIcon = "fa-sharp fa-solid fa-shield",
        menuImg = false,
        priceDefault = 500,
        type = 16
    },

    {
        menuName = "suspension",
        menuLabel = Config.MechanicMenu["Suspension"],
        menuIcon = "fa-solid fa-sliders",
        menuImg = false,
        priceDefault = 500,
        type = 15
    },

    {
        menuName = "horn",
        menuLabel = Config.MechanicMenu["Horns"],
        menuIcon = "fa-solid fa-bullhorn",
        menuImg = false,
        priceDefault = 500,
        type = 14
    },

    {
        menuName = "vehcolor",
        menuLabel = Config.MechanicMenu["VehColor"],
        menuIcon = "fa-sharp fa-solid fa-palette",
        menuImg = false,
        priceDefault = 500,
        type = 2004
    },

    {
        menuName = "neonColor",
        menuLabel = Config.MechanicMenu["Neon"],
        menuIcon = " fa-brands fa-neos",
        menuImg = false,
        priceDefault = 500,
        type = 1986
    },

    {
        menuName = "wheels",
        menuLabel = Config.MechanicMenu["Wheels"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false,
        priceDefault = 500,
        type = 990112
    },
}

VehicleColorMenu = {
    {
        menuName = "vehcolor",
        menuLabel = Config.MechanicMenu["PrimaryColor"],
        menuIcon = "fa-sharp fa-solid fa-palette",
        menuImg = false,
        priceDefault = 500,
        type = 1996
    },

    {
        menuName = "vehcolor",
        menuLabel = Config.MechanicMenu["SecondaryColor"],
        menuIcon = "fa-sharp fa-solid fa-palette",
        menuImg = false,
        priceDefault = 500,
        type = 1997
    },

    {
        menuName = "vehcolor",
        menuLabel = Config.MechanicMenu["PearlescentColor"],
        menuIcon = "fa-sharp fa-solid fa-palette",
        menuImg = false,
        priceDefault = 500,
        type = 1998
    },

    {
        menuName = "vehcolor",
        menuLabel = Config.MechanicMenu["Livery"],
        menuIcon = "fa-solid fa-car-garage",
        menuImg = false,
        priceDefault = 500,
        type = 48
    },
}

BodyParts = {
    {
        menuName = "spoiler",
        menuLabel = Config.MechanicMenu["Spoilers"],
        menuIcon = "../web/img/spoiler.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 0
    },

    {
        menuName = "frontbumper",
        menuLabel = Config.MechanicMenu["FrontBumper"],
        menuIcon = "../web/img/frontbumper.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 1
    },


    {
        menuName = "cage",
        menuLabel = Config.MechanicMenu["Cage"],
        menuIcon = "../web/img/chassis.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 5
    },

    {
        menuName = "dashboard",
        menuLabel = Config.MechanicMenu["dashboard"],
        menuIcon = "../web/img/dashboard.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 29
    },

    {
        menuName = "leftfender",
        menuLabel = Config.MechanicMenu["LeftFender"],
        menuIcon = "../web/img/fender.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 8
    },

    {
        menuName = "rightfender",
        menuLabel = Config.MechanicMenu["RightFender"],
        menuIcon = "../web/img/fender.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 9
    },

    {
        menuName = "speakers",
        menuLabel = Config.MechanicMenu["Speakers"],
        menuIcon = "../web/img/speakers.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 36
    },

    {
        menuName = "interior",
        menuLabel = Config.MechanicMenu["Interior"],
        menuIcon = "../web/img/interior.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 27
    },

    {
        menuName = "modHydrolic",
        menuLabel = Config.MechanicMenu["hydrolic"],
        menuIcon = "../web/img/modHydrolic.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 38
    },

    {
        menuName = "headlights",
        menuLabel = Config.MechanicMenu["Headlights"],
        menuIcon = "../web/img/farlar.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 49
    },

    {
        menuName = "transmission",
        menuLabel = Config.MechanicMenu["Transmission"],
        menuIcon = "../web/img/transmission.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 13
    },

    {
        menuName = "rearbumper",
        menuLabel = Config.MechanicMenu["RearBumper"],
        menuIcon = "../web/img/rearbumper.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 2
    },

    {
        menuName = "skirt",
        menuLabel = Config.MechanicMenu["SideSkirt"],
        menuIcon = "../web/img/skirt.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 3
    },

    {
        menuName = "carplate",
        menuLabel = Config.MechanicMenu["PlateIndex"],
        menuIcon = "../web/img/carplate.png",
        menuImg = true,
        priceDefault = 500,
        type = "plateIndex"
    },

    {
        menuName = "windowTint",
        menuLabel = Config.MechanicMenu["Windows"],
        menuIcon = "../web/img/window.png",
        menuImg = true,
        priceDefault = 1500,
        type = 15677
    },

    {
        menuName = "exhaust",
        menuLabel = Config.MechanicMenu["Exhaust"],
        menuIcon = "../web/img/exhaust.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 4
    },

    {
        menuName = "grille",
        menuLabel = Config.MechanicMenu["Grille"],
        menuIcon = "../web/img/grille.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 6
    },

    {
        menuName = "hood",
        menuLabel = Config.MechanicMenu["Hood"],
        menuIcon = "../web/img/bonnet.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 7
    },

    {
        menuName = "roof",
        menuLabel = Config.MechanicMenu["Roof"],
        menuIcon = "../web/img/roof.png",
        menuImg = true, -- If the plugin icon is an image, mark it as true.
        type = 10
    },
}

Wheels = {
    wheels = {
        {
            menuName = "wheeltype",
            menuLabel = Config.MechanicMenu["WheelType"],
            menuIcon = "fa-solid fa-tire",
            menuImg = false, -- If the plugin icon is an image, mark it as true.
            type = 67000
        },

        {
            menuName = "wheelcolor",
            menuLabel = Config.MechanicMenu["WheelColor"],
            menuIcon = "fa-solid fa-tire",
            menuImg = false, -- If the plugin icon is an image, mark it as true.
            type = 1300
        },

        {
            menuName = "tiresmoke",
            menuLabel = Config.MechanicMenu["TireSmoke"],
            menuIcon = "fa-solid fa-tire",
            menuImg = false, -- If the plugin icon is an image, mark it as true.
            type = 1766
        },
	},
}

WheelsCategory = {
    {
        menuName = "sportwheel",
        menuLabel = Config.MechanicMenu["Sports"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 23,
        modtyp = 0
    },

    {
        menuName = "musclewheel",
        menuLabel = Config.MechanicMenu["Muscle"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 23,
        modtyp = 1
    },

    {
        menuName = "lowriderwheel",
        menuLabel = Config.MechanicMenu["Lowrider"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 23,
        modtyp = 2
    },

    {
        menuName = "suvwheel",
        menuLabel = Config.MechanicMenu["Suv"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 23,
        modtyp = 3
    },

    {
        menuName = "offroadwheel",
        menuLabel = Config.MechanicMenu["Offroad"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 23,
        modtyp = 4
    },

    {
        menuName = "tuningwheel",
        menuLabel = Config.MechanicMenu["Tuning"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 23,
        modtyp = 5
    },

    {
        menuName = "motorwheel",
        menuLabel = Config.MechanicMenu["Motorcycle"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 23,
        modtyp = 6
    },

    {
        menuName = "luxurywheel",
        menuLabel = Config.MechanicMenu["Luxury"],
        menuIcon = "fa-solid fa-tire",
        menuImg = false, -- If the plugin icon is an image, mark it as true.
        type = 23,
        modtyp = 7
    },
}

colorTypeMenu = {
    {
        type = "normal",
        label = Config.MechanicMenu["normal"],
        id = 0
    },

    {
        type = "metalic",
        label = Config.MechanicMenu["metalic"],
        id = 1
    },

    {
        type = "pearl",
        label = Config.MechanicMenu["pearl"],
        id = 2
    },

    {
        type = "matte",
        label = Config.MechanicMenu["matte"],
        id = 3
    },

    {
        type = "metal",
        label = Config.MechanicMenu["metal"],
        id = 4
    },

    {
        type = "chrome",
        label = Config.MechanicMenu["chrome"],
        id = 5
    }
}

ProhibitedsWords = {
    "plate",
    "plateIndex",
    "wheelcolor",
    "tyreSmokeColor",
    "neonColor"
}