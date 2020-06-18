-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKLIST OBJECTS -- ABAIXO VOCÊ COLOCA OS OBJETOS BANIDOS DO SEU SERVIDOR
-----------------------------------------------------------------------------------------------------------------------------------------
local blackObjects = {
	--"apa_mp_apa_yacht",
    "stt_prop_stunt_jump45",
    "prop_const_fence02b",
    "apa_prop_flag_brazil",
   --"prop_c4_final_green"
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		local handle,object = FindFirstObject()
		local finished = false
		repeat
			Citizen.Wait(10)
			for i=1,#blackObjects do
				if GetEntityModel(object) == GetHashKey(blackObjects[i]) then
					ReqAndDelete(object,false)
				end
			end
			finished,object = FindNextObject(handle)
		until not finished
		EndFindObject(handle)
	end
end)

function ReqAndDelete(object,detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end

		if detach then
			DetachEntity(object,0,false)
		end

		SetEntityCollision(object,false,false)
		SetEntityAlpha(object,0.0,true)
		SetEntityAsMissionEntity(object,true,true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end