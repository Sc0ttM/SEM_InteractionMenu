--[[
───────────────────────────────────────────────────────────────

	SEM_InteractionMenu (server.lua) - Created by Scott M
	Current Version: v1.0 (Nov 2019)
	
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