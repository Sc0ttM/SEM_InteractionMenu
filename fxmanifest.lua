--[[
──────────────────────────────────────────────────────────────────

	SEM_InteractionMenu (fxmanifest.lua) - Created by Scott M
	Current Version: v1.7.1 (Sep 2021)
	
	Support: https://semdevelopment.com/discord
	
		!!! Change vaules in the 'config.lua' !!!
	DO NOT EDIT THIS IF YOU DON'T KNOW WHAT YOU ARE DOING

──────────────────────────────────────────────────────────────────
]]



fx_version 'cerulean'
games {'gta5'}

--DO NOT REMOVE THESE
title 'SEM_InteractionMenu'
description 'Multi Purpose Interaction Menu'
author 'Scott M [SEM Development]'
version 'v1.7.1' --This is required for the version checker, DO NOT change or remove

client_scripts {
    'dependencies/NativeUI.lua',
    'client.lua',
    'config.lua',
    'functions.lua',
    'menu.lua',
}

server_scripts {
    'config.lua',
    'server.lua',
    'functions.lua',
}

exports {
    'IsOndutyLEO',
    'IsOndutyFire',
}
