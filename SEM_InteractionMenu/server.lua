--[[
───────────────────────────────────────────────────────────────

	SEM_InteractionMenu (server.lua) - Created by Scott M
	Current Version: v1.2 (Dec 2019)
	
	Support: https://semdevelopment.com/discord
	
		!!! Change vaules in the 'config.lua' !!!
	DO NOT EDIT THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
	
───────────────────────────────────────────────────────────────
]]



RegisterServerEvent('SEM_CuffNear')
AddEventHandler('SEM_CuffNear', function(ID)
    TriggerClientEvent('SEM_Cuff', ID)
end)

RegisterServerEvent('SEM_DragNear')
AddEventHandler('SEM_DragNear', function(ID)
	TriggerClientEvent('Drag', ID, source)
end)

RegisterServerEvent('SEM_SeatNear')
AddEventHandler('SEM_SeatNear', function(ID, Vehicle)
    TriggerClientEvent('SEM_Seat', ID, Vehicle)
end)

RegisterServerEvent('SEM_UnseatNear')
AddEventHandler('SEM_UnseatNear', function(ID, Vehicle)
    TriggerClientEvent('SEM_Unseat', ID, Vehicle)
end)

RegisterServerEvent('SEM_Spikes:TriggerDeleteSpikes')
AddEventHandler('SEM_Spikes:TriggerDeleteSpikes', function(NetID)
    TriggerClientEvent('SEM_Spikes:DeleteSpikes', -1, NetID)
end)

RegisterServerEvent('SEM_Ads')
AddEventHandler('SEM_Ads', function(Text, Name, Loc, File)
    TriggerClientEvent('SEM_SyncAds', -1, Text, Name, Loc, File)
end)

BACList = {}
RegisterServerEvent('SEM_BACSet')
AddEventHandler('SEM_BACSet', function(BACLevel)
	BACList[source] = BACLevel
end)

RegisterServerEvent('SEM_BACTest')
AddEventHandler('SEM_BACTest', function(ID)
	local BACLevel = BACList[ID]
	TriggerClientEvent('SEM_BACResult', source, BACLevel)
end)

Inventories = {}
RegisterServerEvent('SEM_InventorySet')
AddEventHandler('SEM_InventorySet', function(Items)
	Inventories[source] = Items
end)

RegisterServerEvent('SEM_InventorySearch')
AddEventHandler('SEM_InventorySearch', function(ID)
	local Inventory = Inventories[ID]

	TriggerClientEvent('SEM_InventoryResult', source, Inventory)
end)

RegisterServerEvent('SEM_LEOPerms')
AddEventHandler('SEM_LEOPerms', function()
    if IsPlayerAceAllowed(source, 'sem.leo') then
		TriggerClientEvent('SEM_LEOPermsResult', source, true)
	else
		TriggerClientEvent('SEM_LEOPermsResult', source, false)
	end
end)

RegisterServerEvent('SEM_FirePerms')
AddEventHandler('SEM_FirePerms', function()
    if IsPlayerAceAllowed(source, 'sem.fire') then
		TriggerClientEvent('SEM_FirePermsResult', source, true)
	else
		TriggerClientEvent('SEM_FirePermsResult', source, false)
	end
end)



Citizen.CreateThread(function()
	local CurrentVersion = json.decode(LoadResourceFile(GetCurrentResourceName(), 'version.json')).version

	function VersionCheckHTTPRequest()
		PerformHttpRequest('https://semdevelopment.com/releases/interactionmenu/info/version.json', VersionCheck, 'GET')
	end

	function VersionCheck(err, response, headers)
		if err == 200 then
			local Data = json.decode(response)
			if tonumber(CurrentVersion) < tonumber(Data.NewestVersion) then
				print('\n--------------------------------------------------------------------------')
				print('\nSEM_InteractionMenu is outdated!')
				print('Current Version: ^2' .. Data.NewestVersion .. '^7')
				print('Your Version: ^1' .. CurrentVersion .. '^7')
				print('Please download the lastest version from ^5' .. Data.DownloadLocation .. '^7')
				if Data.Changes ~= '' then
					print('\nChanges: ' .. Data.Changes)
				end
				print('\n--------------------------------------------------------------------------\n^7')
			elseif tonumber(CurrentVersion) > tonumber(Data.NewestVersion) then
				print('^3Your version of SEM_InteractionMenu is higher than the current version!^7')
			else
				print('^2SEM_InteractionMenu is up to date!^7')
			end
		else
			print('^1SEM_InteractionMenu Version Check Failed!^7')
		end
		
		SetTimeout(60000000, VersionCheckHTTPRequest)
	end

	VersionCheckHTTPRequest()
end)