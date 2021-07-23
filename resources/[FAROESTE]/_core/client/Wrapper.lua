function cAPI.RequestModel(hash)
	hash = tonumber(hash)

	if not IsModelValid(hash) then
		return
	end

	if not HasModelLoaded(hash) then
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(10)
		end
	end
end

function cAPI.RequestAnimDict(dictionary)
	if not HasAnimDictLoaded(dictionary) then
		RequestAnimDict(dictionary)
		while not HasAnimDictLoaded(dictionary) do
			Citizen.Wait(10)
		end
	end
end

function cAPI.InFade(timer)
	DoScreenFadeOut(timer)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

function cAPI.OutFade(timer)
	ShutdownLoadingScreen()
	DoScreenFadeIn(timer)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

-- {x, y, z}
-- function cAPI.SkyCameraAtCoords(coords)
-- 	local cam =  CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67, 374.08, 873.24, 300.00, 0.00, 0.00, 100.00, false, 0) -- CAMERA COORDS
-- 	PointCamAtCoord(cam, coords[1], coords[2], coords[3] + 200)
-- 	SetCamActive(cam, true)

-- 	cAPI.EndFade(500)

-- 	RenderScriptCams(true, false, 1, true, true)
-- 	return cam
-- end

function cAPI.PlaySkyCameraAnimationAtCoords(coords)
	local vecPosition = vec3(coords[1], coords[2], coords[3])

	RequestCollisionAtCoord(vecPosition)

	local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67, 374.08, 873.24, 300.00, 0.00, 0.00, 100.00, false, 0) -- CAMERA COORDS
	PointCamAtCoord(cam, vecPosition.xy, vecPosition.z + 200)
	SetCamActive(cam, true)

	local cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", vecPosition.xy, vecPosition.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
	PointCamAtCoord(cam3, vecPosition.xy, vecPosition.z + 200)
	SetCamActiveWithInterp(cam3, cam, 8000, true, true)
	Citizen.Wait(8000)
	cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords[1], coords[2], coords[3] + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
	PointCamAtCoord(cam2, vecPosition.xy, vecPosition.z + 2)
	SetCamActiveWithInterp(cam2, cam3, 5000, true, true)
	RenderScriptCams(false, true, 500, true, true)

	local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(vecPosition.x, vecPosition.y, vecPosition.z)

	if _ then
		vecPosition = vec3(vecPosition.xy, groundZ)
	end

	SetEntityCoords(PlayerPedId(), vecPosition)

	Citizen.Wait(5000)

	DestroyAllCams(true)
end
