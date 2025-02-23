Config = {}

Config.DefaultMechanicName = "Mechanic" -- Default name of mechanical businesses.

Config.DefaultMechanicMoney = 1000 -- The amount of money to start mechanical businesses.

Config.UseVehicleKeys = true -- for qb-vehiclekeys

Config.UseKibraVehicleShop = true  -- This setting only applies to our customers using kibra-vehicleshops.
-- Thanks to this setting, in vehicle modifications, the prices of vehicle parts will be indexed to the sales prices of the vehicles.

Config.VehiclePriceToPartPriceRatio = 60 --% This setting is inversely proportional.
-- This ratio is the percentage value that determines how much the vehicle price will affect the part price.
-- IT CAN ONLY WORK WITH USERS OF KIBRA-VEHICLESHOPS.

Config.VehicleBodyPartsPriceRatio = 2 --% This setting is inversely proportional.
-- This ratio is the percentage value that determines how much the vehicle price will affect the part price.
-- IT CAN ONLY WORK WITH USERS OF KIBRA-VEHICLESHOPS.

Config.PlateInterchangeability = true -- If you enable this, players can change their license plate via the mechanic.

Config.EmployeesFreeDiscount = true -- It allows your employees to make modifications for free.

Config.PlateSpace = true --  Allows players to leave spaces on the plates.

Config.RegisterVehiclePropsDatabase = true -- At the end of the modifications, it finds the vehicle from the database and updates the prop json column.

Config.MechanicsCompany = true -- If you mark as true, players can buy and operate mechanical businesses.

Config.PlateReplacementFee = 1750 -- Plate Replacement Fee

Config.DefaultTechRank = 1 -- If you are using the Server job system, the rank to start when you recruit someone to your mechanic business.

Config.DefaultBossRank = 4 -- If you are using the Server job system, the rank to start when you owner someone to your mechanic business.

Config.RepairTime = 20 -- Vehicle engine repair time -- SECOND 

Config.AutoPropsUpdate = true  

Config.HudHideEvent = "" -- When the mod menu opens, it hides your hud.

Config.HudOpenEvent = "" -- When the mod menu is closed, it shows your hud.

Config.FixKitItem = "fixkit" -- The name of the car kit item that only repairs the engine.

Config.OnlyCarsInTheDatabase = false -- A setting that allows only vehicles purchased from the gallery or registered in the database to be modified.

Config.PlateMinimumLetter = 8 -- Minimum number of letters required for license plates

Config.MouseActiveKeyText = "Press Home"

Config.MouseActiveKey = "home" -- Mechanically open, key that activates and deactivates your keyboard and mouse control.

Config.VehicleSpeedUnit = "km/h" -- or "mph" or "ms"

Config.ModifiedAccessKey = 38 -- https://docs.fivem.net/docs/game-references/controls/

Config.BossMenuOpenKey = 38 -- https://docs.fivem.net/docs/game-references/controls/

Config.TowTruckSpawnKey = 38 -- https://docs.fivem.net/docs/game-references/controls/

Config.TowTrucks = {
    {
        Label = "Flatbed",
        Model = "flatbed3",
        isOut = false,
        isAddon = false,
        img = nil
    },

    {
        Label = "Towtruck",
        Model = "towtruck",
        isOut = false,
        isAddon = false,
        img = nil
    },

    {
        Label = "Slamvan",
        Model = "slamvan",
        isOut = false,
        isAddon = false,
        img = nil
    },
}

Config.Opens = {
    ["Modify"] = {"[E]", "Modify Vehicle"},
    ["BossMenu"] = {"[E]", "Boss Menu"},
    ["VehicleSpawn"] = {"[E]", "Tow Trucks"},
    ["EnterTowTruck"] = {"[E]", "Enter A TowTruck"}
}

