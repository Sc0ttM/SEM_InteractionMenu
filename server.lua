--[[
───────────────────────────────────────────────────────────────

	SEM_InteractionMenu (server.lua) - Created by Scott M
	Current Version: v1.6.2 (Oct 2020)
	
	Support: https://semdevelopment.com/discord
	
		!!! Change vaules in the 'config.lua' !!!
	DO NOT EDIT THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
	
───────────────────────────────────────────────────────────────
]]



RegisterServerEvent('SEM_InteractionMenu:GlobalChat')
AddEventHandler('SEM_InteractionMenu:GlobalChat', function(Color, Prefix, Message)
	TriggerClientEvent('chatMessage', -1, Prefix, Color, Message)
end)

RegisterServerEvent('SEM_InteractionMenu:CuffNear')
AddEventHandler('SEM_InteractionMenu:CuffNear', function(ID)
	if ID == source or ID == false then
		return
	end	
		
	if ID == -1 or ID == '-1' then
		if source ~= '' then
			print('^1[#' .. source .. '] ' .. GetPlayerName(source) .. '  -  attempted to cuff all players^7')
			DropPlayer(source, '\n[SEM_InteractionMenu] Attempting to cuff all players')
		else
			print('^1Someone attempted to cuff all players^7')
		end

		return
	end
    TriggerClientEvent('SEM_InteractionMenu:Cuff', ID)
end)

RegisterServerEvent('SEM_InteractionMenu:DragNear')
AddEventHandler('SEM_InteractionMenu:DragNear', function(ID)
	if ID == source or ID == false then
		return
	end
	if ID == -1 or ID == '-1' then
		if source ~= '' then
			print('^1[#' .. source .. '] ' .. GetPlayerName(source) .. '  -  attempted to drag all players^7')
			DropPlayer(source, '\n[SEM_InteractionMenu] Attempting to drag all players')
		else
			print('^1Someone attempted to drag all players^7')
		end

		return
	end
	
	TriggerClientEvent('SEM_InteractionMenu:Drag', ID, source)
end)

RegisterServerEvent('SEM_InteractionMenu:SeatNear')
AddEventHandler('SEM_InteractionMenu:SeatNear', function(ID, Vehicle)
    TriggerClientEvent('SEM_InteractionMenu:Seat', ID, Vehicle)
end)

RegisterServerEvent('SEM_InteractionMenu:UnseatNear')
AddEventHandler('SEM_InteractionMenu:UnseatNear', function(ID, Vehicle)
    TriggerClientEvent('SEM_InteractionMenu:Unseat', ID, Vehicle)
end)

RegisterServerEvent('SEM_InteractionMenu:Spikes-TriggerDeleteSpikes')
AddEventHandler('SEM_InteractionMenu:Spikes-TriggerDeleteSpikes', function(NetID)
    TriggerClientEvent('SEM_InteractionMenu:Spikes-DeleteSpikes', -1, NetID)
end)

RegisterServerEvent('SEM_InteractionMenu:Jail')
AddEventHandler('SEM_InteractionMenu:Jail', function(ID, Time)
	if ID == -1 or ID == '-1' then
		if source ~= '' then
			print('^1[#' .. source .. '] ' .. GetPlayerName(source) .. '  -  attempted to jail all players^7')
			DropPlayer(source, '\n[SEM_InteractionMenu] Attempting to jail all players')
		else
			print('^1Someone attempted to jail all players^7')
		end

		return
	end
	
	TriggerClientEvent('SEM_InteractionMenu:JailPlayer', ID, Time)
	TriggerClientEvent('chatMessage', -1, 'Judge', {86, 96, 252}, GetPlayerName(ID) .. ' has been Jailed for ' .. Time .. ' second(s)')
end)

RegisterServerEvent('SEM_InteractionMenu:Unjail')
AddEventHandler('SEM_InteractionMenu:Unjail', function(ID)
	TriggerClientEvent('SEM_InteractionMenu:UnjailPlayer', ID)
end)

RegisterServerEvent('SEM_InteractionMenu:Backup')
AddEventHandler('SEM_InteractionMenu:Backup', function(Code, StreetName, Coords)
	TriggerClientEvent('SEM_InteractionMenu:CallBackup', -1, Code, StreetName, Coords)
end)

RegisterServerEvent('SEM_InteractionMenu:Ads')
AddEventHandler('SEM_InteractionMenu:Ads', function(Text, Name, Loc, File)
	TriggerClientEvent('SEM_InteractionMenu:SyncAds', -1, Text, Name, Loc, File, source)
end)

BACList = {}
RegisterServerEvent('SEM_InteractionMenu:BACSet')
AddEventHandler('SEM_InteractionMenu:BACSet', function(BACLevel)
	BACList[source] = BACLevel
end)

RegisterServerEvent('SEM_InteractionMenu:BACTest')
AddEventHandler('SEM_InteractionMenu:BACTest', function(ID)
	local BACLevel = BACList[ID]
	TriggerClientEvent('SEM_InteractionMenu:BACResult', source, BACLevel)
end)

Inventories = {}
RegisterServerEvent('SEM_InteractionMenu:InventorySet')
AddEventHandler('SEM_InteractionMenu:InventorySet', function(Items)
	Inventories[source] = Items
end)

RegisterServerEvent('SEM_InteractionMenu:InventorySearch')
AddEventHandler('SEM_InteractionMenu:InventorySearch', function(ID)
	local Inventory = Inventories[ID]

	TriggerClientEvent('SEM_InteractionMenu:InventoryResult', source, Inventory)
end)

RegisterServerEvent('SEM_InteractionMenu:Hospitalize')
AddEventHandler('SEM_InteractionMenu:Hospitalize', function(ID, Time, Location)
	if ID == -1 or ID == '-1' then
		if source ~= '' then
			print('^1[#' .. source .. '] ' .. GetPlayerName(source) .. '  -  attempted to hospitalize all players^7')
			DropPlayer(source, '\n[SEM_InteractionMenu] Attempting to hospitalize all players')
		else
			print('^1Someone attempted to hospitalize all players^7')
		end

		return
	end

	TriggerClientEvent('SEM_InteractionMenu:HospitalizePlayer', ID, Time, Location)
	TriggerClientEvent('chatMessage', -1, 'Doctor', {86, 96, 252}, GetPlayerName(ID) .. ' has been Hospitalized for ' .. Time .. ' second(s)')
end)

RegisterServerEvent('SEM_InteractionMenu:Unhospitalize')
AddEventHandler('SEM_InteractionMenu:Unhospitalize', function(ID)
	TriggerClientEvent('SEM_InteractionMenu:UnhospitalizePlayer', ID)
end)

RegisterServerEvent('SEM_InteractionMenu:LEOPerms')
AddEventHandler('SEM_InteractionMenu:LEOPerms', function()
    if IsPlayerAceAllowed(source, 'sem_intmenu.leo') then
		TriggerClientEvent('SEM_InteractionMenu:LEOPermsResult', source, true)
	else
		TriggerClientEvent('SEM_InteractionMenu:LEOPermsResult', source, false)
	end
end)

RegisterServerEvent('SEM_InteractionMenu:FirePerms')
AddEventHandler('SEM_InteractionMenu:FirePerms', function()
    if IsPlayerAceAllowed(source, 'sem_intmenu.fire') then
		TriggerClientEvent('SEM_InteractionMenu:FirePermsResult', source, true)
	else
		TriggerClientEvent('SEM_InteractionMenu:FirePermsResult', source, false)
	end
end)

RegisterServerEvent('SEM_InteractionMenu:UnjailPerms')
AddEventHandler('SEM_InteractionMenu:UnjailPerms', function()
    if IsPlayerAceAllowed(source, 'sem_intmenu.unjail') then
		TriggerClientEvent('SEM_InteractionMenu:UnjailPermsResult', source, true)
	else
		TriggerClientEvent('SEM_InteractionMenu:UnjailPermsResult', source, false)
	end
end)

RegisterServerEvent('SEM_InteractionMenu:UnhospitalPerms')
AddEventHandler('SEM_InteractionMenu:UnhospitalPerms', function()
    if IsPlayerAceAllowed(source, 'sem_intmenu.unhospital') then
		TriggerClientEvent('SEM_InteractionMenu:UnhospitalPermsResult', source, true)
	else
		TriggerClientEvent('SEM_InteractionMenu:UnhospitalPermsResult', source, false)
	end
end)



Citizen.CreateThread(function()
	local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
	if not CurrentVersion then
		print('^1SEM_InteractionMenu Version Check Failed!^7')
	end

	function VersionCheckHTTPRequest()
		PerformHttpRequest('https://semdevelopment.com/releases/interactionmenu/info/version.json', VersionCheck, 'GET')
	end

	function VersionCheck(err, response, headers)
		Citizen.Wait(3000)
		if err == 200 then
			local Data = json.decode(response)
			
			if CurrentVersion ~= Data.NewestVersion then
				print('\n--------------------------------------------------------------------------')
				print('\nSEM_InteractionMenu is outdated!')
				print('Current Version: ^2' .. Data.NewestVersion .. '^7')
				print('Your Version: ^1' .. CurrentVersion .. '^7')
				print('Please download the lastest version from ^5' .. Data.DownloadLocation .. '^7')
				if Data.Changes ~= '' then
					print('\n^5Changes: ^7' .. Data.Changes)
				end
				print('\n--------------------------------------------------------------------------\n^7')
			else
				print('^2SEM_InteractionMenu is up to date!^7')
			end
		else
			print('^1SEM_InteractionMenu Version Check Failed!^7')
		end
		
		SetTimeout(60000000, VersionCheckHTTPRequest)
	end

	if CurrentVersion then
		VersionCheckHTTPRequest()
	end
end)
