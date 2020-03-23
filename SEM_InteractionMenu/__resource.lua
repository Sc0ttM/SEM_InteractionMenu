--[[
──────────────────────────────────────────────────────────────────

	SEM_InteractionMenu (__resource.lua) - Created by Scott M
	Current Version: v1.4 (Mar 2020)
	
	Support: https://semdevelopment.com/discord
	
		!!! Change vaules in the 'config.lua' !!!
	DO NOT EDIT THIS IF YOU DON'T KNOW WHAT YOU ARE DOING

──────────────────────────────────────────────────────────────────
]]



resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

title 'SEM_InteractionMenu'
description 'Multi Purpose Interaction Menu'
author 'Scott M [SEM Development]'
version 'v1.4'

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