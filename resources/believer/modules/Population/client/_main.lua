GM.Population = GM.Population or {}

GM:newThread(function()
	while true do
		Wait(0)
        -- if IsPedInAnyVehicle(PlayerPedId()) or GM.Interface.PlayerCount >= 150 then
        --     SetVehicleDensityMultiplierThisFrame(0.0)
		-- 	SetAmbientVehicleRangeMultiplierThisFrame(0.0)
		-- 	SetParkedVehicleDensityMultiplierThisFrame(0.0)
        -- else
        --     SetVehicleDensityMultiplierThisFrame(1.0)
		-- 	SetAmbientVehicleRangeMultiplierThisFrame(1.0)
		-- 	SetParkedVehicleDensityMultiplierThisFrame(1.0)
        -- end
        SetVehicleDensityMultiplierThisFrame(1.0)
		SetAmbientVehicleRangeMultiplierThisFrame(1.0)
		SetParkedVehicleDensityMultiplierThisFrame(1.0)
	end
end)