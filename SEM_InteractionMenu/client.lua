--[[
──────────────────────────────────────────────────────────────

	SEM_InteractionMenu (client.lua) - Created by Scott M
	Current Version: v1.0 (Nov 2019)
	
	Support: https://semdevelopment.com/discord
	
		!!! Change vaules in the 'config.lua' !!!
	DO NOT EDIT THIS IF YOU DON'T KNOW WHAT YOU ARE DOING

──────────────────────────────────────────────────────────────
]]



--Cuffing Event
RegisterNetEvent('SEM_Cuff')
AddEventHandler('SEM_Cuff', function()
	Ped = GetPlayerPed(-1)
	if (DoesEntityExist(Ped)) then
		Citizen.CreateThread(function()
		    RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			end
			if isCuffed then
				ClearPedSecondaryTask(Ped)
				StopAnimTask(Ped, 'mp_arresting', 'idle', 3)
				SetEnableHandcuffs(Ped, false)
				isCuffed = false
			else
				TaskPlayAnim(Ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetEnableHandcuffs(Ped, true)
				isCuffed = true
			end
		end)
	end
end)

--Cuff Animation & Restructions
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isCuffed and not IsEntityPlayingAnim(GetPlayerPed(PlayerId()), 'mp_arresting', 'idle', 3) then
			Citizen.Wait(3000)
			TaskPlayAnim(GetPlayerPed(PlayerId()), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), 'mp_arresting', 'idle', 3) then
			DisableControlAction(1, 140, true) --R
			DisableControlAction(1, 141, true) --Q
			DisableControlAction(1, 142, true) --LMB
			SetPedPathCanUseLadders(GetPlayerPed(PlayerId()), false)
			if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
				DisableControlAction(0, 59, true) --Vehicle Driving
			end
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), 'random@mugging3', 'handsup_standing_base', 3) then
			DisableControlAction(1, 140, true) --R
			DisableControlAction(1, 141, true) --Q
			DisableControlAction(1, 142, true) --LMB
			if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
				DisableControlAction(0, 59, true) --Vehicle Driving
			end
		end
	end
end)



--Dragging Event
local Drag = false
local OfficerDrag = -1
RegisterNetEvent('Drag')
AddEventHandler('Drag', function(a)
	Drag = not Drag
	OfficerDrag = a
end)

--Drag Attachment
Citizen.CreateThread(function()
    while true do
      Wait(0)
          if Drag then
              local Ped = GetPlayerPed(GetPlayerFromServerId(OfficerDrag))
              local Ped2 = PlayerPedId()
              AttachEntityToEntity(Ped2, Ped, 4103, 11816, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
              StillDragged = true
          else
              if(StillDragged) then
                  DetachEntity(PlayerPedId(), true, false)
                  StillDragged = false
              end
          end
    end
end)



--Force Seat Player Event
RegisterNetEvent('SEM_Seat')
AddEventHandler('SEM_Seat', function(Veh)
	local Pos = GetEntityCoords(PlayerPedId())
	local EntityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
    local RayHandle = CastRayPointToPoint(Pos.x, Pos.y, Pos.z, EntityWorld.x, EntityWorld.y, EntityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, VehicleHandle = GetRaycastResult(RayHandle)
    if VehicleHandle ~= nil then
		SetPedIntoVehicle(PlayerPedId(), VehicleHandle, 1)
	end
end)



--Force Unseat Player Event
RegisterNetEvent('SEM_Unseat')
AddEventHandler('SEM_Unseat', function(ID)
	local Ped = GetPlayerPed(ID)
	ClearPedTasksImmediately(Ped)
	PlayerPos = GetEntityCoords(PlayerPedId(),  true)
	local X = PlayerPos.x - 0
	local Y = PlayerPos.y - 0

    SetEntityCoords(PlayerPedId(), X, Y, PlayerPos.z)
end)



--Spike Strip Events & Functions
local SpawnedSpikes = {}
local SpikeModel = 'P_ld_stinger_s'
local SpikesSpawned = false
local NearSpikes = false
local IsPedNear = false

--Spike Strip Spawn Event
RegisterNetEvent('SEM_Spikes:SpawnSpikes')
AddEventHandler('SEM_Spikes:SpawnSpikes', function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        Notify('~r~You can\'t set spikes while in a vehicle!')
        return
    end

    local SpawnCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()) , 0.0, 2.0, 0.0)
    for a = 1, 3 do
        local Spike = CreateObject(GetHashKey(SpikeModel), SpawnCoords.x, SpawnCoords.y, SpawnCoords.z, 1, 1, 1)
        local NetID = NetworkGetNetworkIdFromEntity(Spike)
        SetNetworkIdExistsOnAllMachines(NetID, true)
        SetNetworkIdCanMigrate(NetID, false)
        SetEntityHeading(Spike, GetEntityHeading(GetPlayerPed(PlayerId()) ))
        PlaceObjectOnGroundProperly(Spike)
        FreezeEntityPosition(Spike, true)
        SpawnCoords = GetOffsetFromEntityInWorldCoords(Spike, 0.0, 4.0, 0.0)
        table.insert(SpawnedSpikes, NetID)
    end
    SpikesSpawned = true
end)

--Spike Strip Delete Event
RegisterNetEvent('SEM_Spikes:DeleteSpikes')
AddEventHandler('SEM_Spikes:DeleteSpikes', function(NetID)
    Citizen.CreateThread(function()
        local Spike = NetworkGetEntityFromNetworkId(NetID)
        DeleteEntity(Spike)
        Notify('~r~Spikes Strips Removed!')
    end)
end)

--Spike Strip Check Distance Ped
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Ped = PlayerPedId()
        local PedPos = GetEntityCoords(Ped, false)

        local Spikes = GetClosestObjectOfType(PedPos.x, PedPos.y, PedPos.z, 80.0, GetHashKey(SpikeModel), 1, 1, 1)
        local SpikesPos = GetEntityCoords(Spikes, false)

        local Distance = Vdist(PedPos.x, PedPos.y, PedPos.z, SpikesPos.x, SpikesPos.y, SpikesPos.z)

        if SpikesSpawned then
            if Distance ~= 0 and Distance < 5 then
                NotifyHelp('~b~Remove Spike Strips~w~, Press ~INPUT_CHARACTER_WHEEL~ + ~INPUT_PHONE~')
                if (IsControlPressed(1, 19) and IsControlJustPressed(1, 27)) and GetLastInputMethod(2) then
                    RemoveSpikes()
                    SpikesSpawned = false
                end
            elseif Distance > 5 and Distance < 25 then
                NotifyHelp('~o~Move Closer to Remove the Spike Strips!')
            elseif Distance > 150 then
                RemoveSpikes()
                SpikesSpawned = false
            end
        end
    end
end)

--Spike Strip Check Distance Veh
Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(GetPlayerPed(PlayerId()) , false) then
            local Vehicle = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
            if GetPedInVehicleSeat(Vehicle, -1) == GetPlayerPed(PlayerId())  then
                local VehiclePos = GetEntityCoords(Vehicle, false)
                local Spikes = GetClosestObjectOfType(VehiclePos.x, VehiclePos.y, VehiclePos.z, 80.0, GetHashKey(SpikeModel), 1, 1, 1)
                local SpikePos = GetEntityCoords(Spikes, false)
                local Distance = Vdist(VehiclePos.x, VehiclePos.y, VehiclePos.z, SpikePos.x, SpikePos.y, SpikePos.z)

                if Spikes ~= 0 then
                    NearSpikes = true
                else
                    NearSpikes = false
                end
            else
                NearSpikes = false
            end
        else
            NearSpikes = false
        end

        Citizen.Wait(0)
    end
end)

--Spike Strip Tire Popping
Citizen.CreateThread(function()
    while true do
        if NearSpikes then
            local Tires = {
                {bone = 'wheel_lf', index = 0},
                {bone = 'wheel_rf', index = 1},
                {bone = 'wheel_lm', index = 2},
                {bone = 'wheel_rm', index = 3},
                {bone = 'wheel_lr', index = 4},
                {bone = 'wheel_rr', index = 5}
            }

            for a = 1, #Tires do
                local Vehicle = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
                local TirePos = GetWorldPositionOfEntityBone(Vehicle, GetEntityBoneIndexByName(Vehicle, Tires[a].bone))
                local Spike = GetClosestObjectOfType(TirePos.x, TirePos.y, TirePos.z, 15.0, GetHashKey(SpikeModel), 1, 1, 1)
                local SpikePos = GetEntityCoords(Spike, false)
                local Distance = Vdist(TirePos.x, TirePos.y, TirePos.z, SpikePos.x, SpikePos.y, SpikePos.z)

                if Distance < 1.8 then
                    if not IsVehicleTyreBurst(Vehicle, Tires[a].index, true) or IsVehicleTyreBurst(Vehicle, Tires[a].index, false) then
                        SetVehicleTyreBurst(Vehicle, Tires[a].index, false, 1000.0)
                    end
                end
            end
        end

        Citizen.Wait(0)
    end
end)

--Spike Strip Remove Function
function RemoveSpikes()
    for a = 1, #SpawnedSpikes do
        TriggerServerEvent('SEM_Spikes:TriggerDeleteSpikes', SpawnedSpikes[a])
    end
    SpawnedSpikes = {}
end



--Toggle LEO Weapons
CarbineEquipped = false
ShotgunEquipped = false
Citizen.CreateThread(function()
    local Ped = GetPlayerPed(-1)
    while true do 
        Citizen.Wait(0)
        local Ped = GetPlayerPed(-1)
        local Veh = GetVehiclePedIsIn(Ped)
        local CurrentWeapon = GetSelectedPedWeapon(Ped)
        
        if CarbineEquipped then
            if (tostring(CurrentWeapon) ~= '-2084633992') and Veh == nil then
                Notify('~y~You must put away your Carbine Rifle')
            end
            SetCurrentPedWeapon(Ped, 'weapon_carbinerifle', true)			
        end
        
        if ShotgunEquipped then
            if tostring(CurrentWeapon) ~= '487013001' and Veh == nil then
                Notify('~y~You must put away your Shotgun')
            end
            SetCurrentPedWeapon(Ped, 'weapon_pumpshotgun', true)
        end
    end
end)



--Object Spawn Event
RegisterNetEvent('SEM_Object:SpawnObjects')
AddEventHandler('SEM_Object:SpawnObjects', function(ObjectName, Name)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        Notify('~r~You can\'t spawn objects while in a vehicle!')
        return
    end

    local SpawnCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()) , 0.0, 0.5, 0.0)
    
    local Object = CreateObject(GetHashKey(ObjectName), SpawnCoords.x, SpawnCoords.y, SpawnCoords.z, 1, 1, 1)
    local NetID = NetworkGetNetworkIdFromEntity(Spike)
    SetNetworkIdExistsOnAllMachines(NetID, true)
    SetNetworkIdCanMigrate(NetID, false)
    SetEntityHeading(Object, GetEntityHeading(GetPlayerPed(PlayerId()) ))
    PlaceObjectOnGroundProperly(Object)
    FreezeEntityPosition(Object, true)
    Notify('~b~Object Spawned: ~g~' .. Name)
end)



--Civilian Adverts
RegisterNetEvent('SEM_SyncAds')
AddEventHandler('SEM_SyncAds',function(Text, Name, Loc, File)
    Ad(Text, Name, Loc, File)
end)



--Emote
Citizen.CreateThread(function()
    while true do
        if EmotePlaying then
            if Config.EmoteHelp then
                NotifyHelp('You are Playing an Emote, ~b~Move to Cancel')
            end

            if (IsControlPressed(0, 22) or IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
            --  Spacebar                   W                          S                          A                          D
                CancelEmote()
            end
        end
        Citizen.Wait(0)
    end
end)



--Commands
Citizen.CreateThread(function()
    local Index = 0
    local Emotes = ''
    for k, v in pairs(Config.EmotesList) do
        Index = Index + 1
        if Index == 1 then
            Emotes = Emotes .. v.name
        else
            Emotes = Emotes .. ', ' .. v.name
        end
    end

    TriggerEvent('chat:addSuggestion', '/eng', 'Toggles Engine')
    TriggerEvent('chat:addSuggestion', '/hood', 'Toggles Vehicle\'s Hood')
    TriggerEvent('chat:addSuggestion', '/trunk', 'Toggles Vehicle\'s Trunk')
    TriggerEvent('chat:addSuggestion', '/clear', 'Clears all Weapons')
    TriggerEvent('chat:addSuggestion', '/emotes', 'List of Current Avaliable Emotes')
    TriggerEvent('chat:addSuggestion', '/emote', 'Play Emote', {{name='Emote Name', help='Emotes: ' .. Emotes}})
    TriggerEvent('chat:addSuggestion', '/cuff', 'Cuff Player', {{name='ID', help='Players Server ID'}})
    TriggerEvent('chat:addSuggestion', '/drag', 'Drag Player', {{name='ID', help='Players Server ID'}})
    TriggerEvent('chat:addSuggestion', '/dropweapon', 'Drops Weapon in Hand')
    TriggerEvent('chat:addSuggestion', '/loadout', 'Equips LEO Weapon Loadout')
end)

RegisterCommand('cuff', function(source, args, rawCommands)
    if args[1] ~= nil then
        local ID = tonumber(args[1])
        TriggerServerEvent('SEM_CuffNear', ID)
    else
        local Ped = GetPlayerPed(-1)

        ShortestDistance = 2
        ClosestId = 0

        for ID = 0, 32 do
            if NetworkIsPlayerActive(ID) and GetPlayerPed(ID) ~= GetPlayerPed(-1) then
                Ped2 = GetPlayerPed(ID)
                local x, y, z = table.unpack(GetEntityCoords(Ped))
                if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  ShortestDistance) then
                    ShortestDistance = GetDistanceBetweenCoords(GetEntityCoords(Ped), x, y, z)
                    ClosestId = GetPlayerServerId(ID)
                end
            end
        end

        if ClosestId == 0 then
            Notify('~r~No Player Nearby!')
            return
        end

        TriggerServerEvent('SEM_CuffNear', ClosestId)
    end
end)

RegisterCommand('drag', function(source, args, rawCommands)
    if args[1] ~= nil then
        local ID = tonumber(args[1])
        TriggerServerEvent('SEM_DragNear', ID)
    else
        local Ped = GetPlayerPed(-1)

        ShortestDistance = 2
        ClosestId = 0

        for ID = 0, 32 do
            if NetworkIsPlayerActive(ID) and GetPlayerPed(ID) ~= GetPlayerPed(-1) then
                Ped2 = GetPlayerPed(ID)
                local x, y, z = table.unpack(GetEntityCoords(Ped))
                if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  ShortestDistance) then
                    ShortestDistance = GetDistanceBetweenCoords(GetEntityCoords(Ped), x, y, z)
                    ClosestId = GetPlayerServerId(ID)
                end
            end
        end

        if ClosestId == 0 then
            Notify('~r~No Player Nearby!')
            return
        end

        TriggerServerEvent('SEM_DragNear', ClosestId)
    end
end)

RegisterCommand('loadout', function(source, args, rawCommands)
    SetEntityHealth(GetPlayerPed(-1), 200)
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    AddArmourToPed(GetPlayerPed(-1), 100)
    GiveWeapon('weapon_nightstick')
    GiveWeapon('weapon_flashlight')
    GiveWeapon('weapon_fireextinguisher')
    GiveWeapon('weapon_flare')
    GiveWeapon('weapon_stungun')
    GiveWeapon('weapon_combatpistol')
    AddWeaponComponent('weapon_combatpistol', 'component_at_pi_flsh')
    Notify('~g~Loadout Spawned')
end)

RegisterCommand('hu', function(source, args, rawCommands)
    local Ped = PlayerPedId()
    if DoesEntityExist(Ped) and not HandCuffed then
        Citizen.CreateThread(function()
            LoadAnimation('random@mugging3')
            if IsEntityPlayingAnim(Ped, 'random@mugging3', 'handsup_standing_base', 3) or HandCuffed then
                ClearPedSecondaryTask(Ped)
                SetEnableHandcuffs(Ped, false)
            elseif not IsEntityPlayingAnim(Ped, 'random@mugging3', 'handsup_standing_base', 3) or not HandCuffed then
                TaskPlayAnim(Ped, 'random@mugging3', 'handsup_standing_base', 8.0, -8, -1, 49, 0, 0, 0, 0)
                SetEnableHandcuffs(Ped, true)
            end
        end)
    end
end)

RegisterCommand('huk', function(source, args, rawCommands)
    local Ped = PlayerPedId()
    if (DoesEntityExist(Ped) and not IsEntityDead(Ped)) and not HandCuffed then
        Citizen.CreateThread(function()
            LoadAnimation('random@arrests')
            if (IsEntityPlayingAnim(Ped, 'random@arrests', 'kneeling_arrest_idle', 3)) then
                TaskPlayAnim(Ped, 'random@arrests', 'kneeling_arrest_get_up', 8.0, 1.0, -1, 128, 0, 0, 0, 0)
            else
                TaskPlayAnim(Ped, 'random@arrests', 'idle_2_hands_up', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                Wait (4000)
                TaskPlayAnim(Ped, 'random@arrests', 'kneeling_arrest_idle', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
            end
        end)
    end
end)

RegisterCommand('dropweapon', function(source, args, rawCommands)
    local CurrentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
    SetPedDropsInventoryWeapon(GetPlayerPed(-1), CurrentWeapon, -2.0, 0.0, 0.5, 30)
    Notify('~r~Weapon Dropped!')
end)

RegisterCommand('clear', function(source, args, rawCommands)
    SetEntityHealth(GetPlayerPed(-1), 200)
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    Notify('~r~All Weapons Cleared!')
end)

RegisterCommand('eng', function(source, args, rawCommands)
    local Veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if Veh ~= nil and Veh ~= 0 and GetPedInVehicleSeat(Veh, 0) then
        SetVehicleEngineOn(Veh, (not GetIsVehicleEngineRunning(Veh)), false, true)
        Notify('~g~Engine Toggled!')
    end
end)

RegisterCommand('hood', function(source, args, rawCommands)
    local Veh = GetVehiclePedIsIn(PlayerPedId(), false)

    if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
        if GetVehicleDoorAngleRatio(Veh, 4) > 0 then
            SetVehicleDoorShut(Veh, 4, false)
        else
            SetVehicleDoorOpen(Veh, 4, false, false)
        end
    end

    Notify('~g~Hood Toggled!')
end)

RegisterCommand('trunk', function(source, args, rawCommands)
    local Veh = GetVehiclePedIsIn(PlayerPedId(), false)

    if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
        if GetVehicleDoorAngleRatio(Veh, 5) > 0 then
            SetVehicleDoorShut(Veh, 5, false)
        else
            SetVehicleDoorOpen(Veh, 5, false, false)
        end
    end

    Notify('~g~Trunk Toggled!')
end)

RegisterCommand('emotes', function(source, args, rawCommands)
    local Index = 0
    local Emotes = ''
    for k, v in pairs(Config.EmotesList) do
        Index = Index + 1
        if Index == 1 then
            Emotes = Emotes .. v.name
        else
            Emotes = Emotes .. ', ' .. v.name
        end
    end

    TriggerEvent('chatMessage', 'EMOTES', {255, 0, 0}, '\n^r^7' .. Emotes)
end)

RegisterCommand('emote', function(source, args, rawCommands)
    local SelectedEmote = args[1]

    for k, v in pairs(Config.EmotesList) do
        if v.name == SelectedEmote then
            PlayEmote(v.emote, v.name)
            return
        end
    end

    TriggerEvent('chatMessage', 'EMOTES', {255,0,0}, 'Invalid Emote!')
end)