Config = {}

Config.Vehicles = {
    Car = {
        ["car"] = {
            {model = "bati", label = "Bati", price = 1600, category = "luxury"},
            {model = "police", label = "Zentorno", price = 2600, category = "jeep", restricted = {
                ["police"] = true,
            }},
        },
    },    

    Category = {
        ["car"] = {
            {name = "luxury"},
            {name = "jeep"},
        },
    },

    Color = {
        ["car"] = {
            {R = 132, G = 131, B = 145},
            {R = 141, G = 82 , B = 38},
            {R = 142, G = 148, B = 36},
        },
    }
}

CustomizeCamera = function(self)
    isOpen = not self
    DisplayHud(isOpen)
    DisplayRadar(isOpen)
end

Config.GetVehFuel = function(Veh)
    return GetVehicleFuelLevel(Veh)-- exports["LegacyFuel"]:GetFuel(Veh)
end

Config.Carkeys = function(Plate)
    TriggerEvent("vehiclekeys:client:SetOwner", Plate)
end

CustomizePlate = function()
    return string.upper(randomNumber(2) .. randomCharacter(3) .. randomNumber(3))
end

Config.Locations = {
    { 
        job = "all", -- job
        type = "car",
        coords = vector3(-42.5464, -1092.97, 25.422),
        marker = "VEHICLESHOP",
        blip = {
            ["active"] = true,
            ["name"] = "Car Shop",
            ["colour"] = 4,
            ["id"] = 56
        },
        NuiCarViewSpawnPosition = vector4(-73.5, -822.0, 284.8, 201.5),
        NuiCarViewCameraPosition = {
            posX = -67.0,
            posY = -824.5,
            posZ = 285.5,
            rotX = -9.0,
            rotY = 0,
            rotZ = 74.0,
            fov = 45.00
        },
        TestDriveTime = 60,
        TestDriveSpawnPosition = vector4(-874.34, -3226.6, 13.22, 60.82),
        BuyCarSpawnPositions = {
            [1] = vector4(-10.6716, -1096.76, 26.183, 100.5),
            [2] = vector4(-11.4883, -1099.59, 26.180, 100.5),
            [3] = vector4(-12.4124, -1102.35, 26.183, 100.5),
            [4] = vector4(-13.0040, -1105.23, 26.179, 100.5),
            [5] = vector4(-14.5665, -1108.37, 26.183, 100.5)
        },
    }, 
}