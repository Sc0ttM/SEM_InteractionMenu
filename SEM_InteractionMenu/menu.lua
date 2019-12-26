--[[
───────────────────────────────────────────────────────────────

	SEM_InteractionMenu (menu.lua) - Created by Scott M
	Current Version: v1.2 (Dec 2019)
	
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
MainMenu = NativeUI.CreateMenu()





function Menu()
    local MenuTitle = ''
    if Config.MenuTitle == 0 then
        MenuTitle = 'Interaction Menu'
    elseif Config.MenuTitle == 1 then
        MenuTitle = GetPlayerName(source)
    elseif Config.MenuTitle == 2 then
        MenuTitle = Config.MenuTitleCustom
    else
        MenuTitle = 'Interaction Menu'
    end



	_MenuPool:Remove()
	_MenuPool = NativeUI.CreatePool()
	MainMenu = NativeUI.CreateMenu(MenuTitle, GetResourceMetadata(GetCurrentResourceName(), 'title', 0) .. ' ~y~' .. GetResourceMetadata(GetCurrentResourceName(), 'version', 0), MenuOri)
	_MenuPool:Add(MainMenu)
	MainMenu:SetMenuWidthOffset(Config.MenuWidth)
	collectgarbage()
	
	MainMenu:SetMenuWidthOffset(Config.MenuWidth)	
	_MenuPool:ControlDisablingEnabled(false)
	_MenuPool:MouseControlsEnabled(false)





    if LEORestrict() then
        local LEOMenu = _MenuPool:AddSubMenu(MainMenu, 'LEO Toolbox', 'Law Enforcement Related Menu', true)
        LEOMenu:SetMenuWidthOffset(Config.MenuWidth)
            local LEOActions = _MenuPool:AddSubMenu(LEOMenu, 'Actions', '', true)
            LEOActions:SetMenuWidthOffset(Config.MenuWidth)
                local Cuff = NativeUI.CreateItem('Cuff', 'Cuff Closest Player')
                local Drag = NativeUI.CreateItem('Drag', 'Drags Closest Player')
                local Seat = NativeUI.CreateItem('Seat', 'Puts Player in Vehicle')
                local Unseat = NativeUI.CreateItem('Unseat', 'Removes Player from Vehicle')
                local Inventory = NativeUI.CreateItem('Inventory', 'Search Inventory')
                local BAC = NativeUI.CreateItem('BAC', 'Tests BAC Level')
                local Spikes = NativeUI.CreateItem('Deploy Spikes', 'Places Spike Strips in Front of Player')
                local Shield = NativeUI.CreateItem('Toggle Shield', 'Toggles Bulletproof Shield')
                local CarbineRifle = NativeUI.CreateItem('Toggle Carbine', 'Toggles Carbine Rifle')
                local Shotgun = NativeUI.CreateItem('Toggle Shotgun', 'Toggles Shotgun')
                PropsList = {}
                for _, Prop in pairs(Config.LEOProps) do
                    table.insert(PropsList, Prop.name)
                end
                local Props = NativeUI.CreateListItem('Spawn Props', PropsList, 1, 'Spawn Objects/Props')
                local RemoveProps = NativeUI.CreateItem('Remove Props', 'Removes Spawned Props')
                LEOActions:AddItem(Cuff)
                LEOActions:AddItem(Drag)
                LEOActions:AddItem(Seat)
                LEOActions:AddItem(Unseat)
                LEOActions:AddItem(Inventory)
                LEOActions:AddItem(BAC)
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

                    for ID = 0, 128 do
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

                    for ID = 0, 128 do
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

                    for ID = 0, 128 do
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
                end
                Unseat.Activated = function(ParentMenu, SelectedItem)
                    local Ped = GetPlayerPed(-1)

                    ShortestDistance = 2
                    ClosestId = 0

                    for ID = 0, 128 do
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
                end
                Inventory.Activated = function(ParentMenu, SelectedItem)
                    local Ped = GetPlayerPed(-1)

                    ShortestDistance = 2
                    ClosestId = 0

                    for ID = 0, 128 do
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
                    
                    Notify('~b~Searching ...')
                    TriggerServerEvent('SEM_InventorySearch', ClosestId)
                end
                BAC.Activated = function(ParentMenu, SelectedItem)
                    local Ped = GetPlayerPed(-1)

                    ShortestDistance = 2
                    ClosestId = 0

                    for ID = 0, 128 do
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
                    
                    Notify('~b~Testing ...')
                    
                    TriggerServerEvent('SEM_BACTest', ClosestId)
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
                        for _, Prop in pairs(Config.LEOProps) do
                            if Prop.name == item:IndexToItem(index) then
                                TriggerEvent('SEM_Object:SpawnObjects', Prop.spawncode, Prop.name)
                            end
                        end
                    end
                end
                RemoveProps.Activated = function(ParentMenu, SelectedItem)
                    for _, Prop in pairs(Config.LEOProps) do
                        DeleteOBJ(Prop.spawncode)
                    end
                end

            local LEOLoadouts = _MenuPool:AddSubMenu(LEOMenu, 'Loadouts', '', true)
            LEOLoadouts:SetMenuWidthOffset(Config.MenuWidth)
                UniformsList = {}
                for _, Uniform in pairs(Config.LEOUniforms) do
                    table.insert(UniformsList, Uniform.name)
                end
                
                LoadoutsList = {}
                for Name, Loadout in pairs(Config.LEOLoadouts) do
					table.insert(LoadoutsList, Name)
                end

                local Uniforms = NativeUI.CreateListItem('Uniforms', UniformsList, 1, 'Spawn Uniforms')
                local Loadouts = NativeUI.CreateListItem('Loadouts', LoadoutsList, 1, 'Spawns LEO Loadouts')
                LEOLoadouts:AddItem(Uniforms)
                LEOLoadouts:AddItem(Loadouts)
                LEOLoadouts.OnListSelect = function(sender, item, index)
                    if item == Uniforms then
                        for _, Uniform in pairs(Config.LEOUniforms) do
                            if Uniform.name == item:IndexToItem(index) then
                                LoadPed(Uniform.spawncode)
                                Notify('~b~Uniform Spawned: ~g~' .. Uniform.name)
                            end
                        end
                    end



                    if item == Loadouts then
                        for Name, Loadout in pairs(Config.LEOLoadouts) do
							if Name == item:IndexToItem(index) then
								SetEntityHealth(GetPlayerPed(-1), 200)
								RemoveAllPedWeapons(GetPlayerPed(-1), true)
								AddArmourToPed(GetPlayerPed(-1), 100)

								for _, Weapon in pairs(Loadout) do
									GiveWeapon(Weapon.weapon)
															
									for _, Component in pairs(Weapon.components) do
										AddWeaponComponent(Weapon.weapon, Component)
									end
								end

								Notify('~b~Loadout Spawned: ~g~' .. Name)
							end
                        end
                    end
                end

            if Config.ShowLEOVehicles then
                local LEOVehicles = _MenuPool:AddSubMenu(LEOMenu, 'Vehicles', '', true)
                LEOVehicles:SetMenuWidthOffset(Config.MenuWidth)
                
                for Name, Category in pairs(Config.LEOVehiclesCategories) do
                    local LEOCategory = _MenuPool:AddSubMenu(LEOVehicles, Name, '', true)
                    LEOCategory:SetMenuWidthOffset(Config.MenuWidth)
                    for _, Vehicle in pairs(Category) do
                        local LEOVehicle = NativeUI.CreateItem(Vehicle.name, '')
                        LEOCategory:AddItem(LEOVehicle)
                        if Config.ShowLEOSpawnCode then
                            LEOVehicle:RightLabel(Vehicle.spawncode)
                        end
                        LEOVehicle.Activated = function(ParentMenu, SelectedItem)
                            SpawnVehicle(Vehicle.spawncode, Vehicle.name)
                        end
                    end
                end
            end
    end




    if FireRestrict() then
        local FireMenu = _MenuPool:AddSubMenu(MainMenu, 'Fire Toolbox', 'Fire Related Menu', true)
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

                    for ID = 0, 128 do
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

                    for ID = 0, 128 do
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
                end
                Unseat.Activated = function(ParentMenu, SelectedItem)
                    local Ped = GetPlayerPed(-1)

                    ShortestDistance = 2
                    ClosestId = 0

                    for ID = 0, 128 do
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
                end

            local FireLoadouts = _MenuPool:AddSubMenu(FireMenu, 'Loadouts', '', true)
            FireLoadouts:SetMenuWidthOffset(Config.MenuWidth)
                UniformsList = {}
                for _, Uniform in pairs(Config.FireUniforms) do
                    table.insert(UniformsList, Uniform.name)
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
                        for _, Uniform in pairs(Config.FireUniforms) do
                            if Uniform.name == item:IndexToItem(index) then
                                LoadPed(Uniform.spawncode)
                                Notify('~b~Uniform Spawned: ~g~' .. Uniform.name)
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
                
                for _, Vehicle in pairs(Config.FireVehicles) do
                    local FireVehicle = NativeUI.CreateItem(Vehicle.name, '')
                    FireVehicles:AddItem(FireVehicle)
                    if Config.ShowFireSpawnCode then
                        FireVehicle:RightLabel(Vehicle.spawncode)
                    end
                    FireVehicle.Activated = function(ParentMenu, SelectedItem)
                        SpawnVehicle(Vehicle.spawncode, Vehicle.name)
                    end
                end
            end
    end





	local CivMenu = _MenuPool:AddSubMenu(MainMenu, 'Civ Toolbox', 'Civilian Related Menu', true)
    CivMenu:SetMenuWidthOffset(Config.MenuWidth)
        local CivActions = _MenuPool:AddSubMenu(CivMenu, 'Actions', '', true)
        CivActions:SetMenuWidthOffset(Config.MenuWidth)
            local HU = NativeUI.CreateItem('HU', 'Hands Up')
            local HUK = NativeUI.CreateItem('HUK', 'Hands Up and Kneel')
            local Inventory = NativeUI.CreateItem('Inventory', 'Set Inventory')
            local BAC = NativeUI.CreateItem('BAC', 'Set BAC Level')
            local DropWeapon = NativeUI.CreateItem('Drop Weapon', 'Drops Weapon on the floor')
            CivActions:AddItem(HU)
            CivActions:AddItem(HUK)
            CivActions:AddItem(Inventory)
            CivActions:AddItem(BAC)
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
            Inventory.Activated = function(ParentMenu, SelectedItem)
                local Items = KeyboardInput('Items:', 75)
                if Items == nil or Items == '' then
                    Notify('~r~No Items Provided!')
                    return
                end

                TriggerServerEvent('SEM_InventorySet', Items)
                Notify('~g~Inventory Set!')
            end
            BAC.Activated = function(ParentMenu, SelectedItem)
                local BACLevel = KeyboardInput('BAC Level - Legal Limit: 0.08', 5)
                if BACLevel == nil or BACLevel == '' then
                    Notify('~r~No BAC Level Provided!')
                    return
                end

                TriggerServerEvent('SEM_BACSet', tonumber(BACLevel))
                if tonumber(BACLevel) < 0.08 then
                    Notify('~b~BAC Level Set: ~g~' .. tostring(BACLevel))
                else
                    Notify('~b~BAC Level Set: ~r~' .. tostring(BACLevel))
                end
            end
            DropWeapon.Activated = function(ParentMenu, SelectedItem)
                local CurrentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
                SetPedDropsInventoryWeapon(GetPlayerPed(-1), CurrentWeapon, -2.0, 0.0, 0.5, 30)
                Notify('~r~Weapon Dropped!')
            end
        local CivAdverts = _MenuPool:AddSubMenu(CivMenu, 'Adverts', 'Civilian Adverts')
        CivAdverts:SetMenuWidthOffset(Config.MenuWidth)
			for _, Ad in pairs(Config.CivAdverts) do
                local Advert  = NativeUI.CreateItem(Ad.name, '')
                CivAdverts:AddItem(Advert)
                Advert.Activated = function(ParentMenu, SelectedItem)
					local Message = KeyboardInput('Message:', 128)
					if Message == nil or Message == '' then
						Notify('~r~No Advert Message Provided!')
						return
					end
		
					TriggerServerEvent('SEM_Ads', Message, Ad.name, Ad.loc, Ad.file)
                end
            end
		if Config.ShowCivVehicles then
            local CivVehicles = _MenuPool:AddSubMenu(CivMenu, 'Vehicles', '', true)
            CivVehicles:SetMenuWidthOffset(Config.MenuWidth)
            
			for _, Vehicle in pairs(Config.CivVehicles) do
                local CivVehicle = NativeUI.CreateItem(Vehicle.name, '')
                CivVehicles:AddItem(CivVehicle)
                if Config.ShowCivSpawnCode then
                    CivVehicle:RightLabel(Vehicle.spawncode)
                end
                CivVehicle.Activated = function(ParentMenu, SelectedItem)
                    SpawnVehicle(Vehicle.spawncode, Vehicle.name)
                end
            end
		end





    if VehicleRestrict() then
        local VehicleMenu = _MenuPool:AddSubMenu(MainMenu, 'Vehicle', 'Vehicle Related Menu', true)
        VehicleMenu:SetMenuWidthOffset(Config.MenuWidth)
            local Seats = {-1, 0, 1, 2}
            local Windows = {'Front', 'Rear', 'All'}
            local Doors = {'Driver', 'Passenger', 'Rear Right', 'Rear Left', 'Hood', 'Trunk', 'All'}
            local Engine = NativeUI.CreateItem('Toggle Engine', 'Toggles Vehicle\'s Engine')
            local ILights = NativeUI.CreateItem('Toggle Interior Light', 'Toggles Vehicle\'s Interior Light')
            local Seat = NativeUI.CreateSliderItem('Change Seats', Seats, 1, 'Change Seats in a Vehicle')
            local Window = NativeUI.CreateListItem('Windows', Windows, 1, 'Open/Close Windows')
            local Door = NativeUI.CreateListItem('Doors', Doors, 1, 'Open/Close Doors')
            VehicleMenu:AddItem(Engine)
            VehicleMenu:AddItem(ILights)
            VehicleMenu:AddItem(Seat)
            VehicleMenu:AddItem(Window)
            VehicleMenu:AddItem(Door)
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
            VehicleMenu.OnSliderChange = function(sender, item, index)
                if item == Seat then
                    VehicleSeat = item:IndexToItem(index)
                    local Veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
                    SetPedIntoVehicle(PlayerPedId(), Veh, VehicleSeat)
                end
            end
            VehicleMenu.OnListSelect = function(sender, item, index)
                local Ped = GetPlayerPed(-1)
                local Veh = GetVehiclePedIsIn(Ped, false)

                if item == Window then
                    VehicleWindow = item:IndexToItem(index)
                    if VehicleWindow == 'Front' then
                        if IsPedInAnyVehicle(Ped, false) then
                            if (GetPedInVehicleSeat(Veh, -1) == Ped) then 
                                SetEntityAsMissionEntity(Veh, true, true)
                                if (WindowFrontRolled) then
                                    RollDownWindow(Veh, 0)
                                    RollDownWindow(Veh, 1)
                                    WindowFrontRolled = false
                                else
                                    RollUpWindow(Veh, 0)
                                    RollUpWindow(Veh, 1)
                                    WindowFrontRolled = true
                                end
                            end
                        end
                    elseif VehicleWindow == 'Rear' then
                        if IsPedInAnyVehicle(Ped, false) then
                            if (GetPedInVehicleSeat(Veh, -1) == Ped) then 
                                SetEntityAsMissionEntity(Veh, true, true)
                                if (WindowFrontRolled) then
                                    RollDownWindow(Veh, 2)
                                    RollDownWindow(Veh, 3)
                                    WindowFrontRolled = false
                                else
                                    RollUpWindow(Veh, 2)
                                    RollUpWindow(Veh, 3)
                                    WindowFrontRolled = true
                                end
                            end
                        end
                    elseif VehicleWindow == 'All' then
                        if IsPedInAnyVehicle(Ped, false) then
                            if (GetPedInVehicleSeat(Veh, -1) == Ped) then 
                                SetEntityAsMissionEntity(Veh, true, true)
                                if (WindowFrontRolled) then
                                    RollDownWindow(Veh, 0)
                                    RollDownWindow(Veh, 1)
                                    RollDownWindow(Veh, 2)
                                    RollDownWindow(Veh, 3)
                                    WindowFrontRolled = false
                                else
                                    RollUpWindow(Veh, 0)
                                    RollUpWindow(Veh, 1)
                                    RollUpWindow(Veh, 2)
                                    RollUpWindow(Veh, 3)
                                    WindowFrontRolled = true
                                end
                            end
                        end
                    end
                elseif item == Door then
                    local Doors = {'Driver', 'Passenger', 'Rear Left', 'Rear Right', 'Hood', 'Trunk', 'All'}
                    VehicleDoor = item:IndexToItem(index)
                    if VehicleDoor == 'Driver' then
                        if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
                            if GetVehicleDoorAngleRatio(Veh, 0) > 0 then
                                SetVehicleDoorShut(Veh, 0, false)
                            else
                                SetVehicleDoorOpen(Veh, 0, false, false)
                            end
                        end
                    elseif VehicleDoor == 'Passenger' then
                        if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
                            if GetVehicleDoorAngleRatio(Veh, 1) > 0 then
                                SetVehicleDoorShut(Veh, 1, false)
                            else
                                SetVehicleDoorOpen(Veh, 1, false, false)
                            end
                        end
                    elseif VehicleDoor == 'Rear Left' then
                        if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
                            if GetVehicleDoorAngleRatio(Veh, 2) > 0 then
                                SetVehicleDoorShut(Veh, 2, false)
                            else
                                SetVehicleDoorOpen(Veh, 2, false, false)
                            end
                        end
                    elseif VehicleDoor == 'Rear Right' then
                        if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
                            if GetVehicleDoorAngleRatio(Veh, 3) > 0 then
                                SetVehicleDoorShut(Veh, 3, false)
                            else
                                SetVehicleDoorOpen(Veh, 3, false, false)
                            end
                        end
                    elseif VehicleDoor == 'Hood' then
                        if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
                            if GetVehicleDoorAngleRatio(Veh, 4) > 0 then
                                SetVehicleDoorShut(Veh, 4, false)
                            else
                                SetVehicleDoorOpen(Veh, 4, false, false)
                            end
                        end
                    elseif VehicleDoor == 'Trunk' then
                        if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
                            if GetVehicleDoorAngleRatio(Veh, 5) > 0 then
                                SetVehicleDoorShut(Veh, 5, false)
                            else
                                SetVehicleDoorOpen(Veh, 5, false, false)
                            end
                        end
                    elseif VehicleDoor == 'All' then
                        if Veh ~= nil and Veh ~= 0 and Veh ~= 1 then
                            if GetVehicleDoorAngleRatio(Veh, 0) > 0 then
                                SetVehicleDoorShut(Veh, 0, false)
                                SetVehicleDoorShut(Veh, 1, false)
                                SetVehicleDoorShut(Veh, 2, false)
                                SetVehicleDoorShut(Veh, 3, false)
                                SetVehicleDoorShut(Veh, 4, false)
                                SetVehicleDoorShut(Veh, 5, false)
                            else
                                SetVehicleDoorOpen(Veh, 0, false, false)
                                SetVehicleDoorOpen(Veh, 1, false, false)
                                SetVehicleDoorOpen(Veh, 2, false, false)
                                SetVehicleDoorOpen(Veh, 3, false, false)
                                SetVehicleDoorOpen(Veh, 4, false, false)
                                SetVehicleDoorOpen(Veh, 5, false, false)
                            end
                        end
                    end
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
	for _, Emote in pairs(Config.EmotesList) do
		table.insert(EmotesList, Emote.name)
	end

	local EmotesMenu = NativeUI.CreateListItem('Emotes', EmotesList, 1, 'General RP Emotes')
	MainMenu:AddItem(EmotesMenu)
		
		MainMenu.OnListSelect = function(sender, item, index)
			if item == EmotesMenu then
				for _, Emote in pairs(Config.EmotesList) do
					if Emote.name == item:IndexToItem(index) then
						PlayEmote(Emote.emote, Emote.name)
					end
				end
			end
        end
        
    _MenuPool:RefreshIndex()
end



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		_MenuPool:ProcessMenus()	
		_MenuPool:ControlDisablingEnabled(false)
		_MenuPool:MouseControlsEnabled(false)
		
		if IsControlJustPressed(1, Config.MenuButton) and GetLastInputMethod(2) then
			if not MainMenu:Visible() then
				Menu()
                MainMenu:Visible(true)
            else
                _MenuPool:CloseAllMenus()
			end
		end
	end
end)



RegisterCommand(Config.Command, function(source, args, rawCommands)
    if Config.OpenMenu == 1 then
        Menu()
        MainMenu:Visible(true)
    end
end)

Citizen.CreateThread(function()
    if Config.OpenMenu == 1 then
        TriggerEvent('chat:addSuggestion', '/' .. Config.Command, 'Used to open SEM_InteractionMenu')
    end
end)