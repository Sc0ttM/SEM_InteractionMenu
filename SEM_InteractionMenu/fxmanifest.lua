--[[
──────────────────────────────────────────────────────────────────

	SEM_AOP (fxmanifest.lua) - Created by Scott M
	Current Version: v1.5 (Apr 2020)
	
	Support: https://semdevelopment.com/discord
	
		!!! Change vaules in the 'config.lua' !!!
	DO NOT EDIT THIS IF YOU DON'T KNOW WHAT YOU ARE DOING

──────────────────────────────────────────────────────────────────
]]



fx_version 'bodacious'
games {'gta5'}


title 'SEM_InteractionMenu'
description 'Multi Purpose Interaction Menu'
author 'Scott M [SEM Development]'
version 'v1.5'

client_scripts {
    'dependencies/NativeUI.lua',
    'client.lua',
    'config.lua',
    'functions.lua',
    'menu.lua',
}

server_scripts {
    'server.lua',
    'functions.lua'
}