--[[
─────────────────────────────────────────────────────────────────

	SEM_InteractionMenu (functions.lua) - Created by Scott M
	Current Version: v1.5.1 (June 2020)
	
	Support: https://semdevelopment.com/discord
	
		!!! Change vaules in the 'config.lua' !!!
	DO NOT EDIT THIS IF YOU DON'T KNOW WHAT YOU ARE DOING

─────────────────────────────────────────────────────────────────
]]



--General Functions
function Notify(Text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(Text)
    DrawNotification(true, true)
end

function NotifyHelp(Text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(Text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LoadAnimation(Dict)
    while not HasAnimDictLoaded(Dict) do
        RequestAnimDict(Dict)
        Citizen.Wait(5)
    end
end

function KeyboardInput(TextEntry, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', '', '', '', '', MaxStringLenght)
	BlockInput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local Result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		BlockInput = false
		return Result
	else
		Citizen.Wait(500)
		BlockInput = false
		return nil
	end
end

function GetClosestPlayer()
    local Ped = PlayerPedId()

    for _, Player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(Player) ~= GetPlayerPed(-1) then
            local Ped2 = GetPlayerPed(Player)
            local x, y, z = table.unpack(GetEntityCoords(Ped))
            if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  2) then
                return GetPlayerServerId(Player)
            end
        end
    end

    Notify('~r~No Player Nearby!')
    return false
end

function GetDistance(ID)
    local Ped = GetPlayerPed(-1)
    local Ped2 = GetPlayerPed(ID)
    local x, y, z = table.unpack(GetEntityCoords(Ped))
    return GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z)
end

--LEO Functions
function EnableShield()
    ShieldActive = true
    local Ped = GetPlayerPed(-1)
    local PedPos = GetEntityCoords(Ped, false)

    if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        Notify('~r~You cannot be in a vehicle when getting your shield out!')
        ShieldActive = false
        return
    end
    
    RequestAnimDict('combat@gestures@gang@pistol_1h@beckon')
    while not HasAnimDictLoaded('combat@gestures@gang@pistol_1h@beckon') do
        Citizen.Wait(100)
    end

    TaskPlayAnim(Ped, 'combat@gestures@gang@pistol_1h@beckon', '0', 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey('prop_ballistic_shield'))
    while not HasModelLoaded(GetHashKey('prop_ballistic_shield')) do
        Citizen.Wait(100)
    end

    local shield = CreateObject(GetHashKey('prop_ballistic_shield'), PedPos.x, PedPos.y, PedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, Ped, GetEntityBoneIndexByName(Ped, 'IK_L_Hand'), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(Ped, 'Gang1H')

    if HasPedGotWeapon(Ped, 'weapon_combatpistol', 0) or GetSelectedPedWeapon(Ped) == 'weapon_combatpistol' then
        SetCurrentPedWeapon(Ped, 'weapon_combatpistol', 1)
        HadPistol = true
    else
        GiveWeaponToPed(Ped, 'weapon_combatpistol', 300, 0, 1)
        SetCurrentPedWeapon(Ped, 'weapon_combatpistol', 1)
        HadPistol = false
    end
    SetEnableHandcuffs(Ped, true)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if ShieldActive == true then
            DisableControlAction(1, 23, true) --F | Enter Vehicle
            DisableControlAction(1, 75, true) --F | Exit Vehicle
        end
    end
end)

function DisableShield()
    local Ped = GetPlayerPed(-1)
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(Ped)
    SetWeaponAnimationOverride(Ped, 'Default')
    SetCurrentPedWeapon(Ped, 'weapon_unarmed', 1)

    if not HadPistol then
        RemoveWeaponFromPed(Ped, 'weapon_combatpistol')
    end
    SetEnableHandcuffs(Ped, false)
    HadPistol = false
    ShieldActive = false
end



--Civ Functions
function Ad(Text, Name, Loc, File, ID)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(Text)
    EndTextCommandThefeedPostMessagetext(Loc, File, true, 1, Name, '~b~Advertisement #' .. ID)
    DrawNotification(false, true)
end



--Vehicle Functions
function SpawnVehicle(Veh, Name)
    local Ped = GetPlayerPed( -1 )
    if (DoesEntityExist(Ped) and not IsEntityDead(Ped)) then 
        local pos = GetEntityCoords(Ped)
        if (IsPedSittingInAnyVehicle(Ped)) then 
            local Vehicle = GetVehiclePedIsIn(Ped, false)
            if (GetPedInVehicleSeat(Vehicle, -1) == Ped) then 
                SetEntityAsMissionEntity(Vehicle, true, true )
                DeleteVehicle(Vehicle)
            end
        end
    end

    local WaitTime = 0
    local Model = GetHashKey(Veh)
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        CancelEvent()
        RequestModel(Model)
        Citizen.Wait(100)

        WaitTime = WaitTime + 1

        if WaitTime == 600 then
            CancelEvent()
            Notify('~r~Unable to load vehicle, please contact development!')
            return
        end
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local Vehicle = CreateVehicle(Model, x + 2, y + 2, z + 1, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), Vehicle, -1)
    SetVehicleDirtLevel(Vehicle, 0)
    SetModelAsNoLongerNeeded(Model)

    if Name then
        Notify('~b~Vehicle Spawned: ~g~' .. Name)
    else
        Notify('~b~Vehicle Spawned!')
    end
end

function DeleteVehicle(entity)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end



--Ped Functions
function LoadPed(Hash)
    Citizen.CreateThread(function()
        local Model = GetHashKey(Hash)
            RequestModel(Model)
        while not HasModelLoaded(Model) do
            Wait(0)
        end
        if HasModelLoaded(Model) then
            SetPlayerModel(PlayerId(), Model)
        else
	        Notify('The model could not load - please contact development.')
        end
    end)
end



--Weapon Functions
function GiveWeapon(Hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(Hash), 999, false)
end

function AddWeaponComponent(WeaponHash, Component)
    if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(WeaponHash), false) then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(WeaponHash), GetHashKey(Component))
    end
end



--Object Functions
SpawnedObjects = {}
function SpawnObject(Object)
    local Player = GetPlayerPed(-1)
    local x, y, z = table.unpack(GetEntityCoords(Player, true))
    local Heading = GetEntityHeading(Player)
   
    RequestModel(Object)

    while not HasModelLoaded(Object) do
	    Citizen.Wait(1)
    end

    local Obj = CreateObject(GetHashKey(Object), x, y, z - 1.90, true, true, true)
    local NetID = NetworkGetNetworkIdFromEntity(Obj)
	PlaceObjectOnGroundProperly(Obj)
    SetEntityHeading(Obj, Heading)
    FreezeEntityPosition(Obj, true)
    
    table.insert(SpawnedObjects, NetID)
end

function DeleteOBJ(Object)
    local Hash = GetHashKey(Object)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, Hash, true) then
        local Obj = GetClosestObjectOfType(x, y, z, 0.9, Hash, false, false, false)
        DeleteObject(Obj)
    end
    Notify('~r~Object Removed!')
end

function DeleteEntity(Entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(Entity))
end



--Emote Functions
function PlayEmote(Emote, Name)
    if not DoesEntityExist(GetPlayerPed(-1)) then
        return
    end

    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        Notify('~r~Please exit the vehicle to use this emote!')
        return
    end

    TaskStartScenarioInPlace(GetPlayerPed(-1), Emote, 0, true)
    Notify('~b~Playing Emote: ~g~' .. Name)
    EmotePlaying = true
end

function CancelEmote()
    ClearPedTasks(GetPlayerPed(-1))
    Notify('~r~Stopping Emote')
    EmotePlaying = false
end



--Menu Restrictions
function LEORestrict()
    if Config.LEOAccess == 0 then
        return false
    elseif Config.LEOAccess == 1 then
        return true
    elseif Config.LEOAccess == 2 then
        local Ped = GetEntityModel(GetPlayerPed(-1))

        for _, LEOPeds in pairs(Config.LEOUniforms) do
            local AllowedPed = GetHashKey(LEOPeds.spawncode)

            if Ped == AllowedPed then
                return true
            end
        end
    elseif Config.LEOAccess == 3 then
        return LEOOnduty
    elseif Config.LEOAccess == 4 then
        return LEOAce
    else
        return true
    end
end



function FireRestrict()
    if Config.FireAccess == 0 then
        return false
    elseif Config.FireAccess == 1 then
        return true
    elseif Config.FireAccess == 2 then
        local Ped = GetEntityModel(GetPlayerPed(-1))

        for _, FirePeds in pairs(Config.FireUniforms) do
            local AllowedPed = GetHashKey(FirePeds.spawncode)

            if Ped == AllowedPed then
                return true
            end
        end
    elseif Config.FireAccess == 3 then
        return FireOnduty
    elseif Config.FireAccess == 4 then
        return FireAce
    else
        return true
    end
end



function CivRestrict()
    if Config.CivAccess == 0 then
        return false
    elseif Config.CivAccess == 1 then
        return true
    else
        return true
    end
end



function VehicleRestrict()
    if Config.VehicleAccess == 0 then
        return false
    elseif Config.VehicleAccess == 1 then
        return true
    elseif Config.VehicleAccess == 2 then
        if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
            return true
        else
            return false
        end
    else
        return true
    end
end



function EmoteRestrict()
    if Config.EmoteAccess == 0 then
        return false
    elseif Config.EmoteAccess == 1 then
        return true
    else
        return true
    end
end
