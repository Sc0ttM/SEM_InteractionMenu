--[[
───────────────────────────────────────────────────────────────

	SEM_InteractionMenu (menu.lua) - Created by Scott M
	Current Version: v1.0 (Nov 2019)
	
	Support | https://semdevelopment.com/discord
	
        !!! Change vaules in the 'config.lua' !!!
	DO NOT EDIT THIS IF YOU DON'T KNOW WHAT YOU ARE DOING

───────────────────────────────────────────────────────────────
]]



local MenuOri = 0
if Config.MenuOrientation == 0 then
    MenuOri = 0
elseif Config.MenuOrientation == 1 then
    MenuOri = 730
elseif Config.MenuOrientation == 2 then
    MenuOri = 1320
else
    MenuOri = 0
end


_MenuPool = NativeUI.CreatePool()
MainMenu = NativeUI.CreateMenu('Interaction Menu', GetResourceMetadata(GetCurrentResourceName(), 'title', 0) .. ' ~y~' .. GetResourceMetadata(GetCurrentResourceName(), 'version', 0), MenuOri)
_MenuPool:Add(MainMenu)
MainMenu:SetMenuWidthOffset(Config.MenuWidth)





function LEO(menu)
    local LEOMenu = _MenuPool:AddSubMenu(menu, 'LEO Toolbox', 'Law Enforcement Related Menu', true)
    LEOMenu:SetMenuWidthOffset(Config.MenuWidth)
        local LEOActions = _MenuPool:AddSubMenu(LEOMenu, 'Actions', '', true)
        LEOActions:SetMenuWidthOffset(Config.MenuWidth)
            local Cuff = NativeUI.CreateItem('Cuff', 'Cuff Closest Player')
            local Drag = NativeUI.CreateItem('Drag', 'Drags Closest Player')
            local Seat = NativeUI.CreateItem('Seat', 'Puts Player in Vehicle')
            local Unseat = NativeUI.CreateItem('Unseat', 'Removes Player from Vehicle')
            local Spikes = NativeUI.CreateItem('Set Spikes', 'Places Spike Strips in Front of Player')
            local Shield = NativeUI.CreateItem('Toggle Shield', 'Toggles Bulletproof Shield')
            local CarbineRifle = NativeUI.CreateItem('Toggle Carbine', 'Toggles Carbine Rifle')
            local Shotgun = NativeUI.CreateItem('Toggle Shotgun', 'Toggles Shotgun')
            PropsList = {
                'Police Barrier',
                'Barrier',
                'Traffic Cone',
                'Work Barrier',
            }
            local Props = NativeUI.CreateListItem('Spawn Props', PropsList, 1, 'Spawn Objects/Props')
            local RemoveProps = NativeUI.CreateItem('Remove Props', 'Removes Spawned Props')
            LEOActions:AddItem(Cuff)
            LEOActions:AddItem(Drag)
            LEOActions:AddItem(Seat)
            LEOActions:AddItem(Unseat)
            LEOActions:AddItem(Spikes)
            LEOActions:AddItem(Shield)
            LEOActions:AddItem(CarbineRifle)
            LEOActions:AddItem(Shotgun)
            LEOActions:AddItem(Props)
            LEOActions:AddItem(RemoveProps)
            Cuff.Activated = function(ParentMenu, SelectedItem)
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
            Drag.Activated = function(ParentMenu, SelectedItem)
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
            Seat.Activated = function(ParentMenu, SelectedItem)
                local Ped = GetPlayerPed(-1)
                local Veh = GetVehiclePedIsIn(Ped, true)

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

                TriggerServerEvent('SEM_SeatNear', ClosestId, Veh)
                Citizen.Wait(500)
                TriggerServerEvent('SEM_DragNear', ClosestId)
            end
            Unseat.Activated = function(ParentMenu, SelectedItem)
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
                
                TriggerServerEvent('SEM_UnseatNear', ClosestId)
                Citizen.Wait(500)
                TriggerServerEvent('SEM_DragNear', ClosestId)
            end
            Spikes.Activated = function(ParentMenu, SelectedItem)
                TriggerEvent('SEM_Spikes:SpawnSpikes')
            end
            Shield.Activated = function(ParentMenu, SelectedItem)
                if ShieldActive then
                    DisableShield()
                else
                    EnableShield()
                end
            end
            CarbineRifle.Activated = function(ParentMenu, SelectedItem)
                if (GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1))) == 18) then
                    CarbineEquipped = not CarbineEquipped
                    ShotgunEquipped = false
                elseif (GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1))) ~= 18) then
                    Notify('~r~You Must be in a Police Vehicle to rack/unrack your Carbine Rifle')
                    return
                end
            
                if CarbineEquipped then
                    Notify('~g~Carbine Rifle Equipped')
                    GiveWeapon('weapon_carbinerifle')
                    AddWeaponComponent('weapon_carbinerifle', 'component_at_ar_flsh')
                    AddWeaponComponent('weapon_carbinerifle', 'component_at_ar_afgrip')
                else 
                    Notify('~y~Carbine Rifle Unequipped')
                    RemoveWeaponFromPed(GetPlayerPed(-1), 'weapon_carbinerifle')
                end
            end
            Shotgun.Activated = function(ParentMenu, SelectedItem)
                if (GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1))) == 18) then
                    ShotgunEquipped = not ShotgunEquipped
                    CarbineEquipped = false
                elseif (GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1))) ~= 18) then
                    Notify('~r~You Must be in a Police Vehicle to rack/unrack your Shotgun')
                    return
                end
                
                if ShotgunEquipped then
                    Notify('~g~Shotgun Equipped')
                    GiveWeapon('weapon_pumpshotgun')
                    AddWeaponComponent('weapon_pumpshotgun', 'component_at_ar_flsh')
                else
                    Notify('~y~Shotgun Unequipped')
                    RemoveWeaponFromPed(GetPlayerPed(-1), 'weapon_pumpshotgun')
                end
            end
            LEOActions.OnListSelect = function(sender, item, index)
                if item == Props then
                    local SelectedProp = item:IndexToItem(index)
                    if SelectedProp == 'Police Barrier' then
                        TriggerEvent('SEM_Object:SpawnObjects', 'prop_barrier_work05', SelectedProp)
                    elseif SelectedProp == 'Barrier' then
                        TriggerEvent('SEM_Object:SpawnObjects', 'prop_barrier_work06a', SelectedProp)
                    elseif SelectedProp == 'Traffic Cone' then
                        TriggerEvent('SEM_Object:SpawnObjects', 'prop_roadcone01a', SelectedProp)
                    elseif SelectedProp == 'Work Barrier' then
                        TriggerEvent('SEM_Object:SpawnObjects', 'prop_mp_barrier_02b', SelectedProp)
                    elseif SelectedProp == 'Work Barrier 2' then
                        TriggerEvent('SEM_Object:SpawnObjects', 'prop_barrier_work01a', SelectedProp)
                    end
                end
            end
            RemoveProps.Activated = function(ParentMenu, SelectedItem)
                DeleteOBJ('prop_barrier_work05') --Police Barrier
                DeleteOBJ('prop_barrier_work06a') --Barrier
                DeleteOBJ('prop_roadcone01a') --Traffic Cone
                DeleteOBJ('prop_mp_barrier_02b') --Work Barrier
            end

        local LEOLoadouts = _MenuPool:AddSubMenu(LEOMenu, 'Loadouts', '', true)
        LEOLoadouts:SetMenuWidthOffset(Config.MenuWidth)
            UniformsList = {}
            for k, v in pairs(Config.LEOUniforms) do
                table.insert(UniformsList, v.name)
            end
            
            
            
            
            LoadoutsList = {
				'Clear',
                'Standard',
                'SWAT',
            }
            local Uniforms = NativeUI.CreateListItem('Uniforms', UniformsList, 1, 'Spawn Uniforms')
            local Loadouts = NativeUI.CreateListItem('Loadouts', LoadoutsList, 1, 'Spawns LEO Loadouts')
            LEOLoadouts:AddItem(Uniforms)
            LEOLoadouts:AddItem(Loadouts)
            LEOLoadouts.OnListSelect = function(sender, item, index)
				if item == Uniforms then
                    local Unif = {}
                    for k, v in pairs(Config.LEOUniforms) do
                        if v.name == item:IndexToItem(index) then
                            Unif = v

                            LoadPed(Unif.spawncode)
                            Notify('~b~Uniform Spawned: ~g~' .. Unif.name)
                        end
                    end
                end



                if item == Loadouts then
                    local SelectedLoadout = item:IndexToItem(index)
                    if SelectedLoadout == 'Clear' then
                        SetEntityHealth(GetPlayerPed(-1), 200)
                        RemoveAllPedWeapons(GetPlayerPed(-1), true)
                        Notify('~r~All Weapons Cleared!')
                    elseif SelectedLoadout == 'Standard' then
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
                        Notify('~b~Loadout Spawned: ~g~' .. SelectedLoadout)
                    elseif SelectedLoadout == 'SWAT' then
                        SetEntityHealth(GetPlayerPed(-1), 200)
                        RemoveAllPedWeapons(GetPlayerPed(-1), true)
                        AddArmourToPed(GetPlayerPed(-1), 100)
                        GiveWeapon('weapon_nightstick')
                        GiveWeapon('weapon_flashlight')
                        GiveWeapon('weapon_knife')
                        GiveWeapon('weapon_fireextinguisher')
                        GiveWeapon('weapon_flare')
                        GiveWeapon('weapon_bzgas')
                        GiveWeapon('weapon_stungun')
                        GiveWeapon('weapon_combatpistol')
                        AddWeaponComponent('weapon_combatpistol', 'component_at_pi_flsh')
                        GiveWeapon('weapon_smg_mk2')
                        AddWeaponComponent('weapon_smg_mk2', 'component_at_ar_flsh')
                        AddWeaponComponent('weapon_smg_mk2', 'component_at_scope_macro_02')
                        AddWeaponComponent('weapon_smg_mk2', 'component_at_muzzle_06')
                        AddWeaponComponent('weapon_smg_mk2', 'component_at_sb_barrel_02')
                        AddWeaponComponent('weapon_smg_mk2', 'component_at_sights_smg')
                        GiveWeapon('weapon_carbinerifle_mk2')
                        AddWeaponComponent('weapon_carbinerifle_mk2', 'component_at_ar_afgrip_02')
                        AddWeaponComponent('weapon_carbinerifle_mk2', 'component_at_ar_flsh')
                        AddWeaponComponent('weapon_carbinerifle_mk2', 'component_at_cr_barrel_02')
                        AddWeaponComponent('weapon_carbinerifle_mk2', 'component_at_muzzel_01')
                        AddWeaponComponent('weapon_carbinerifle_mk2', 'component_at_sights')
                        GiveWeapon('weapon_heavysniper_mk2')
                        AddWeaponComponent('weapon_heavysniper_mk2', 'component_heavysniper_mk2_clip_02')
                        AddWeaponComponent('weapon_heavysniper_mk2', 'component_heavysniper_mk2_clip_armorpiercing')
                        AddWeaponComponent('weapon_heavysniper_mk2', 'component_ar_scope_max')
                        AddWeaponComponent('weapon_heavysniper_mk2', 'component_at_muzzel_09')
                        AddWeaponComponent('weapon_heavysniper_mk2', 'component_at_ar_barrel_02')
                        Notify('~b~Loadout Spawned: ~g~' .. SelectedLoadout)
                    end
                end
			end

        if Config.ShowLEOVehicles then
            local LEOVehicles = _MenuPool:AddSubMenu(LEOMenu, 'Vehicles', '', true)
            LEOVehicles:SetMenuWidthOffset(Config.MenuWidth)
            
			for k, v in pairs(Config.LEOVehiclesCategories) do
                local LEOCategory = _MenuPool:AddSubMenu(LEOVehicles, k, '', true)
                LEOCategory:SetMenuWidthOffset(Config.MenuWidth)
                for n, s in pairs(v) do
                    local LEOVehicle = NativeUI.CreateItem(s.name, '')
                    LEOCategory:AddItem(LEOVehicle)
                    if Config.ShowLEOSpawnCode then
                        LEOVehicle:RightLabel(s.spawncode)
                    end
                    LEOVehicle.Activated = function(ParentMenu, SelectedItem)
                        SpawnVehicle(s.spawncode, s.name)
                    end
                end
            end
        end
end





function Fire(menu)
    local FireMenu = _MenuPool:AddSubMenu(menu, 'Fire Toolbox', 'Fire Related Menu', true)
    FireMenu:SetMenuWidthOffset(Config.MenuWidth)
        local FireActions = _MenuPool:AddSubMenu(FireMenu, 'Actions', '', true)
        FireActions:SetMenuWidthOffset(Config.MenuWidth)
            local Drag = NativeUI.CreateItem('Drag', 'Drags Closest Player')
            local Seat = NativeUI.CreateItem('Seat', 'Puts Player in Vehicle')
            local Unseat = NativeUI.CreateItem('Unseat', 'Removes Player from Vehicle')
            FireActions:AddItem(Drag)
            FireActions:AddItem(Seat)
            FireActions:AddItem(Unseat)
            Drag.Activated = function(ParentMenu, SelectedItem)
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
            Seat.Activated = function(ParentMenu, SelectedItem)
                local Ped = GetPlayerPed(-1)
                local Veh = GetVehiclePedIsIn(Ped, true)

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

                TriggerServerEvent('SEM_SeatNear', ClosestId, Veh)
                Citizen.Wait(500)
                TriggerServerEvent('SEM_DragNear', ClosestId)
            end
            Unseat.Activated = function(ParentMenu, SelectedItem)
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
                
                TriggerServerEvent('SEM_UnseatNear', ClosestId)
                Citizen.Wait(500)
                TriggerServerEvent('SEM_DragNear', ClosestId)
            end

        local FireLoadouts = _MenuPool:AddSubMenu(FireMenu, 'Loadouts', '', true)
        FireLoadouts:SetMenuWidthOffset(Config.MenuWidth)
            UniformsList = {}
            for k, v in pairs(Config.FireUniforms) do
                table.insert(UniformsList, v.name)
            end
                
                
                
                
            LoadoutsList = {
                'Clear',
                'Standard',
            }
            local Uniforms = NativeUI.CreateListItem('Uniforms', UniformsList, 1, 'Spawn Uniforms')
            local Loadouts = NativeUI.CreateListItem('Loadouts', LoadoutsList, 1, 'Spawns Fire Loadouts')
            FireLoadouts:AddItem(Uniforms)
            FireLoadouts:AddItem(Loadouts)
            FireLoadouts.OnListSelect = function(sender, item, index)
                if item == Uniforms then
                    local Unif = {}
                    for k, v in pairs(Config.FireUniforms) do
                        if v.name == item:IndexToItem(index) then
                            Unif = v
    
                            LoadPed(Unif.spawncode)
                            Notify('~b~Uniform Spawned: ~g~' .. Unif.name)
                        end
                    end
                end
    
    
    
                if item == Loadouts then
                    local SelectedLoadout = item:IndexToItem(index)
                    if SelectedLoadout == 'Clear' then
                        SetEntityHealth(GetPlayerPed(-1), 200)
                        RemoveAllPedWeapons(GetPlayerPed(-1), true)
                        Notify('~r~All Weapons Cleared!')
                    elseif SelectedLoadout == 'Standard' then
                        SetEntityHealth(GetPlayerPed(-1), 200)
                        RemoveAllPedWeapons(GetPlayerPed(-1), true)
                        AddArmourToPed(GetPlayerPed(-1), 100)
                        GiveWeapon('weapon_flashlight')
                        GiveWeapon('weapon_fireextinguisher')
                        GiveWeapon('weapon_flare')
                        GiveWeapon('weapon_stungun')
                        Notify('~b~Loadout Spawned: ~g~' .. SelectedLoadout)
                    end
                end
            end
        
        if Config.ShowFireVehicles then
            local FireVehicles = _MenuPool:AddSubMenu(FireMenu, 'Vehicles', '', true)
            FireVehicles:SetMenuWidthOffset(Config.MenuWidth)
            
			for n, s in pairs(Config.FireVehicles) do
                local FireVehicle = NativeUI.CreateItem(s.name, '')
                FireVehicles:AddItem(FireVehicle)
                if Config.ShowFireSpawnCode then
                    FireVehicle:RightLabel(s.spawncode)
                end
                FireVehicle.Activated = function(ParentMenu, SelectedItem)
                    SpawnVehicle(s.spawncode, s.name)
                end
            end
        end
end





function Civ(menu)
    local CivMenu = _MenuPool:AddSubMenu(menu, 'Civ Toolbox', 'Civilian Related Menu', true)
    CivMenu:SetMenuWidthOffset(Config.MenuWidth)
        local CivActions = _MenuPool:AddSubMenu(CivMenu, 'Actions', '', true)
        CivActions:SetMenuWidthOffset(Config.MenuWidth)
            local HU = NativeUI.CreateItem('HU', 'Hands Up')
            local HUK = NativeUI.CreateItem('HUK', 'Hands Up and Kneel')
            local DropWeapon = NativeUI.CreateItem('Drop Weapon', 'Drops Weapon on the floor')
            CivActions:AddItem(HU)
            CivActions:AddItem(HUK)
            CivActions:AddItem(DropWeapon)
            HU.Activated = function(ParentMenu, SelectedItem)
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
            end
            HUK.Activated = function(ParentMenu, SelectedItem)
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
            end
            DropWeapon.Activated = function(ParentMenu, SelectedItem)
                local CurrentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
                SetPedDropsInventoryWeapon(GetPlayerPed(-1), CurrentWeapon, -2.0, 0.0, 0.5, 30)
                Notify('~r~Weapon Dropped!')
            end
        local CivAdverts = _MenuPool:AddSubMenu(CivMenu, 'Adverts', 'Civilian Adverts')
        CivAdverts:SetMenuWidthOffset(Config.MenuWidth)
			for k, v in pairs(Config.CivAdverts) do
                local Advert  = NativeUI.CreateItem(v.name, '')
                CivAdverts:AddItem(Advert)
                Advert.Activated = function(ParentMenu, SelectedItem)
					local Message = KeyboardInput('Message:', 128)
					if Message == nil or Message == '' then
						Notify('~r~No Advert Message Provided!')
						return
					end
		
					TriggerServerEvent('SEM_Ads', Message, v.name, v.loc, v.file)
                end
            end
		if Config.ShowCivVehicles then
            local CivVehicles = _MenuPool:AddSubMenu(CivMenu, 'Vehicles', '', true)
            CivVehicles:SetMenuWidthOffset(Config.MenuWidth)
            
			for k, v in pairs(Config.CivVehicles) do
                local CivVehicle = NativeUI.CreateItem(v.name, '')
                CivVehicles:AddItem(CivVehicle)
                if Config.ShowCivSpawnCode then
                    CivVehicle:RightLabel(v.spawncode)
                end
                CivVehicle.Activated = function(ParentMenu, SelectedItem)
                    SpawnVehicle(v.spawncode, v.name)
                end
            end
        end
            

end





function Vehicle(menu)
    local VehicleMenu = _MenuPool:AddSubMenu(menu, 'Vehicle', 'Vehicle Related Menu', true)
    VehicleMenu:SetMenuWidthOffset(Config.MenuWidth)
        local Engine = NativeUI.CreateItem('Toggle Engine', 'Toggles Vehicle\'s Engine')
        local ILights = NativeUI.CreateItem('Toggle Interior Light', 'Toggles Vehicle\'s Interior Light')
        VehicleMenu:AddItem(Engine)
        VehicleMenu:AddItem(ILights)
        Engine.Activated = function(ParentMenu, SelectedItem)
            local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if Vehicle ~= nil and Vehicle ~= 0 and GetPedInVehicleSeat(Vehicle, 0) then
                SetVehicleEngineOn(Vehicle, (not GetIsVehicleEngineRunning(Vehicle)), false, true)
                Notify('~g~Engine Toggled!')
            else
                Notify('~r~You\'re not in a Vehicle!')
            end
        end
        ILights.Activated = function(ParentMenu, SelectedItem)
            local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

            if IsPedInVehicle(PlayerPedId(), Vehicle, false) then
                if IsVehicleInteriorLightOn(Vehicle) then
                    SetVehicleInteriorlight(Vehicle, false)
                else
                    SetVehicleInteriorlight(Vehicle, true)
                end
            else
                Notify('~r~You\'re not in a Vehicle!')
            end
        end

        if Config.VehicleOptions then
            local FixVeh = NativeUI.CreateItem('Repair Vehicle', 'Repairs Current Vehicle')
            local CleanVeh = NativeUI.CreateItem('Clean Vehicle', 'Cleans Current Vehicle')
            local DelVeh = NativeUI.CreateItem('~r~Delete Vehicle', 'Deletes Current Vehicle')
            VehicleMenu:AddItem(FixVeh)
            VehicleMenu:AddItem(CleanVeh)
            VehicleMenu:AddItem(DelVeh)
            FixVeh.Activated = function(ParentMenu, SelectedItem)
                local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if Vehicle ~= nil and Vehicle ~= 0 then
                    SetVehicleEngineHealth(Vehicle, 100)
                    SetVehicleFixed(Vehicle)
                    Notify('~g~Vehicle Repaired!')
                else
                    Notify('~r~You\'re not in a Vehicle!')
                end

            end
            CleanVeh.Activated = function(ParentMenu, SelectedItem)
                local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if Vehicle ~= nil and Vehicle ~= 0 then
                    SetVehicleDirtLevel(Vehicle, 0)
                    Notify('~g~Vehicle Cleaned!')
                else
                    Notify('~r~You\'re not in a Vehicle!')
                end
            end
            DelVeh.Activated = function(ParentMenu, SelectedItem)
                if (IsPedSittingInAnyVehicle(PlayerPedId())) then 
                    local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                    if (GetPedInVehicleSeat(Vehicle, -1) == PlayerPedId()) then 
                        SetEntityAsMissionEntity(Vehicle, true, true)
                        DeleteVehicle(Vehicle)

                        if (DoesEntityExist(Vehicle)) then 
                            Notify('~o~Unable to delete vehicle, try again.')
                        else 
                            Notify('~g~Vehicle Deleted!')
                        end 
                    else 
                        Notify('~r~You must be in the driver\'s seat!')
                    end 
                else
                    Notify('~r~You\'re not in a Vehicle!')
                end
            end
        end
end





local EmotesList = {}
for k, v in pairs(Config.EmotesList) do
    table.insert(EmotesList, v.name)
end

function Emotes(menu)
    local EmotesMenu = NativeUI.CreateListItem('Emotes', EmotesList, 1, 'General RP Emotes')
    menu:AddItem(EmotesMenu)
    
    menu.OnListSelect = function(sender, item, index)
        if item == EmotesMenu then
            for k, v in pairs(Config.EmotesList) do
                if v.name == item:IndexToItem(index) then
                    PlayEmote(v.emote, v.name)
                end
            end
        end
    end
end









LEO(MainMenu)
Fire(MainMenu)
Civ(MainMenu)
Vehicle(MainMenu)
Emotes(MainMenu)
_MenuPool:RefreshIndex()
_MenuPool:MouseControlsEnabled(false)
_MenuPool:ControlDisablingEnabled(false)
_MenuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _MenuPool:ProcessMenus()
        if (IsControlJustPressed(1, Config.MenuButton) and GetLastInputMethod(2)) and Config.OpenMenu ~= 1 then
            MainMenu:Visible(not MainMenu:Visible())
        end
    end
end)

CreateThread(function()
    if Config.OpenMenu == 1 then
        TriggerEvent('chat:addSuggestion', '/semmenu', 'Toggles SEM Interaction Menu')
    end
end)
RegisterCommand('semmenu', function()
    if Config.OpenMenu == 1 then
        MainMenu:Visible(not MainMenu:Visible())
    end
end)