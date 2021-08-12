
local vehicle = GetVehiclePedIsIn(player)
local currentmode = 0


--Get Hash of mustang / pursuit vehicle
-- Add more by using the same method and updating the function at the bottom with "or IsVehicleModel(vehicle, *newhasname_hash*)"
local Interceptor_hash = GetHashKey("2015polstang")



--Start Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait (0)
        if IsPlayerInInterceptor() and IsDisabledControlJustPressed (1, 36) then
        ChangeMode()
        end
    end           
end) --End Thread


-- Functions
function IsPlayerInInterceptor()
	local lPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(lPed)
	return IsVehicleModel(vehicle, Interceptor_hash)
end

function ChangeMode()
    while true do
        Citizen.Wait(0)
	if currentmode == 0 and IsDisabledControlJustPressed (1, 36) then
		currentmode = 1
        TriggerEvent("chatMessage", 'Vehicle Mode: pursuit')
        while currentmode == 1 do
        Citizen.Wait (0)
        SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), true), 5.5)
        SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), true), 5.5) 
        if IsPlayerInInterceptor() and IsDisabledControlJustPressed (1, 36) then
            currentmode = 2
        end
        if IsPedOnFoot(PlayerPedId()) then 
            currentmode = 0
        end

    end
	elseif currentmode == 2 then
        TriggerEvent("chatMessage", 'Vehicle Mode: pursuit+')
        while currentmode == 2 do
            Citizen.Wait (0)
            SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), true), 10.5)
            SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), true), 10.5) 
            if IsPlayerInInterceptor() and IsDisabledControlJustPressed (1, 36) then
                currentmode = 0
                TriggerEvent("chatMessage", 'Vehicle Mode: Patrol')
            end
            if IsPedOnFoot(PlayerPedId()) then 
                currentmode = 0
            end
        end
	elseif currentmode == 0 and IsDisabledControlJustPressed (1, 36)  then
	end
end
end

