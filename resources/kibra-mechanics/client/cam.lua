cam = nil

gameplaycam = nil 

local function f(n)
	return (n + 0.00001)
end


function ResetCam()
	SetCamCoord(cam,GetGameplayCamCoords())
	SetCamRot(cam, GetGameplayCamRot(2), 2)
	-- RenderScriptCams( 0, 1, 1000, 0, 0)
	RenderScriptCams(0, 1, 1500, 1, 0)
	SetCamActive(gameplaycam, true)
	EnableGameplayCam(true)
	SetCamActive(cam, false)
end

function freeCam()
	Citizen.CreateThread(function()
		SetNuiFocus(false,false)
		ResetCam()
		local freecam = true
	end)
end

local function PointCamAtBone(bone,ox,oy,oz)
	SetCamActive(cam, true)
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	local b = GetEntityBoneIndexByName(veh, bone)
	if b and b > -1 then
		local bx,by,bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
		local ox2,oy2,oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh, bx, by, bz))
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(veh, ox2 + f(ox), oy2 + f(oy), oz2 +f(oz)))
		SetCamCoord(cam, x, y, z)
		PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, oy2, oz2))
		RenderScriptCams( 1, 1, 1000, 0, 0)
	end
end

local function MoveVehCam(pos,x,y,z)
	SetCamActive(cam, true)
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	local vx,vy,vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length,width,height = d.y*-2, d.x*-2, d.z*-2
	local ox,oy,oz
	if pos == 'front' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2)+ f(y), f(z)))
	elseif pos == "front-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2) + f(y),(height) + f(z)))
	elseif pos == "back" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),f(z)))
	elseif pos == "back-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),(height/2) + f(z)))
	elseif pos == "left" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, -(width/2) + f(x), f(y), f(z)))
	elseif pos == "right" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, (width/2) + f(x), f(y), f(z)))
	elseif pos == "middle" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), f(y), (height/2) + f(z)))
	end
	SetCamCoord(cam, ox, oy, oz)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, 0, f(0)))
	RenderScriptCams( 1, 1, 1000, 0, 0)
end


function camControl(c)
	if c == "ontaraf" then
		MoveVehCam('front',-0.6,1.5,0.4)
	elseif c == "renk" then
		MoveVehCam('middle',-2.6,2.5,1.4)
	elseif  c == "egzoz" then
		MoveVehCam('back',-0.5,-1.5,0.2)
	elseif c == "yukaridan-bak" then
		MoveVehCam('front-top',-0.5,1.3,1.0)
	elseif c == "tavan" then
		MoveVehCam('middle',-2.2,2,1.5)
	elseif c == "seksi-bakis" then
		MoveVehCam('middle',-2.0,2,0.5)
	elseif c == "farlar"then
		MoveVehCam('front',-0.6,1.3,0.6)
	elseif c == "plaka" then
		MoveVehCam('back',0,-1,0.2)
	elseif c == "soltaraf" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "arka-ama-genis" then
		MoveVehCam('back',0.5,-1.6,1.3)
	elseif c == "lastikler" then
		PointCamAtBone("wheel_lr",-1.4,0,0.3)
	elseif c == "neonlar" then
		if not IsThisModelABike(GetEntityModel(vehicle)) then
			PointCamAtBone("neon_l",-2.0,2.0,0.4)
		end
	elseif c == "araba-ic" then
		MoveVehCam('back-top',0.0,4.0,0.7)
	elseif c == "kapilar" then
		SetVehicleDoorOpen(vehicle, 0, 0, 0)
		SetVehicleDoorOpen(vehicle, 1, 0, 0)
		doorsopen = true
	elseif "reset" then
		ResetCam()
	else
		if doorsopen then
			SetVehicleDoorShut(vehicle, 0, 0)
			SetVehicleDoorShut(vehicle, 1, 0)
			SetVehicleDoorShut(vehicle, 4, 0)
			SetVehicleDoorShut(vehicle, 5, 0)
			doorsopen = false
		end
	end
end