--[[
───────────────────────────────────────────────────────────────

	SEM_InteractionMenu (config.lua) - Created by Scott M
	Current Version: v1.0 (Nov 2019)
	
	Support: https://semdevelopment.com/discord

───────────────────────────────────────────────────────────────
]]



Config = {}

--This determines what button will open/activate the menu
--Default 244 [M]  |  To change the button check out https://docs.fivem.net/game-references/controls/
--!!!CONTROLER SUPPORT IS DISABLED!!!
Config.MenuButton = 244

--This determines how wide the menu is
--Default = 80
Config.MenuWidth = 80

--This determines where the menu will appear left/middle/right
--Left = 0 [Default]  |  Middle = 1  |  Right = 2
Config.MenuOrientation = 0

--This determines how you will open the Menu
--Button = 0 [Default]  |  Command = 1
Config.OpenMenu = 0





--These are unfiforms that are available through the LEO Loadout Menu 
Config.LEOUniforms = {
    --[[
        EXAMPLE: 
		{name = 'a', spawncode = 'b'},
        ────────────────────────────────────────────────────────────────
        'a' is the title that shows in the menu
        'b' is the spawn code for uniform that will be spawned
    ]]
    {name = 'Clear', spawncode = 'a_m_y_skater_01'},
    {name = 'LSPD', spawncode = 's_m_y_cop_01'},
    {name = 'BCSO', spawncode = 's_m_y_sheriff_01'},
    {name = 'SAHP', spawncode = 's_m_y_hwaycop_01'},
    {name = 'SWAT', spawncode = 's_m_y_swat_01'},
    {name = 'Undercover', spawncode = 's_m_m_ciasec_01'},
}

--This determines if the vehicle spawn section shows for the LEO Menu
Config.ShowLEOVehicles = true

--This determines if the vehicle spawn code shows next to the title
Config.ShowLEOSpawnCode = true

--These are vehicles that are available through the LEO Vehicle Menu
Config.LEOVehiclesCategories = {
	--[[
        EXAMPLE: 
		a = {
		    {name = 'b', spawncode = 'c'},
		}
        ────────────────────────────────────────────────────────────────
        'a' is the title of the Category
        'b' is the title of the vehicle that shows in the menu
        'c' is the spawn code for vehicle that will be spawned
    ]]
	
	--This is a Category that will show in the LEO Vehicle Menu - These categories sometimes does order correctly
    LSPD = {
		--These are the Vehicles that will show in the Category and there spawn codes
		{name = 'Police', spawncode = 'police'},
		{name = 'Police', spawncode = 'police2'},
		{name = 'Police', spawncode = 'police3'},
	},
	
	BCSO = {
		{name = 'Sheriff', spawncode = 'sheriff'},
		{name = 'Sheriff', spawncode = 'sheriff2'},
	},
    
    SAHP = {
        {name = 'Highway', spawncode = 'police'},
        {name = 'Highway', spawncode = 'police'},
    },

    Unmarked = {
        {name = 'Unmarked', spawncode = 'police4'},
    },
}





--These are unfiforms that are available through the Fire Loadout Menu 
Config.FireUniforms = {
    --[[
        EXAMPLE: 
		{name = 'a', spawncode = 'b'},
        ────────────────────────────────────────────────────────────────
        'a' is the title that shows in the menu
        'b' is the spawn code for uniform that will be spawned
    ]]
    {name = 'Clear', spawncode = 'a_m_y_skater_01'},
    {name = 'Firefighter', spawncode = 's_m_y_fireman_01'},
    {name = 'Paramedic', spawncode = 's_m_m_paramedic_01'},
}

--This determines if the vehicle spawn section shows for the Fire Menu
Config.ShowFireVehicles = true

--This determines if the vehicle spawn code shows next to the title
Config.ShowFireSpawnCode = true

--These are vehicles that are available through the LEO Vehicle Menu
Config.FireVehicles = {
	--[[
        EXAMPLE: 
		{name = 'a', spawncode = 'b'},
        ────────────────────────────────────────────────────────────────
        'a' is the title of the vehicle that shows in the menu
        'b' is the spawn code for vehicle that will be spawned
    ]]
	
	--These are the Vehicles that will show in the Category and there spawn codes
	{name = 'Fire Engine', spawncode = 'firetruk'},
	{name = 'Ambulance', spawncode = 'ambulance'},
}





--This determines if the vehicle spawn section shows for the Civilain Menu
Config.ShowCivVehicles = true

--This determines if the vehicle spawn code shows next to the title
Config.ShowCivSpawnCode = true

--These are vehicles that are available through the LEO Vehicle Menu
Config.CivVehicles = {
	--[[
        EXAMPLE: 
		{name = 'a', spawncode = 'b'},
        ────────────────────────────────────────────────────────────────
        'a' is the title of the vehicle that shows in the menu
        'b' is the spawn code for vehicle that will be spawned
    ]]
	
	--These are the Vehicles that will show in the Category and there spawn codes
	{name = 'Adder', spawncode = 'adder'},
	{name = 'Baller', spawncode = 'baller'},
}

--  !!!!! Wouldn't Recommend Changing These Unless You Know What You're Doing !!!!!
--  !!!!! Wouldn't Recommend Changing These Unless You Know What You're Doing !!!!!
--  !!!!! Wouldn't Recommend Changing These Unless You Know What You're Doing !!!!!
--These are adverts that are avaiable through the Civilain Adverts Menu
Config.CivAdverts = {
    --[[
        EXAMPLE: 
		{name = 'a', loc = 'b', file = 'c'},
        ────────────────────────────────────────────────────────────────
        'a' is the title of the Adverts
        'b' is the location for the Advert's Image
		'c' is the file name for the Advert's Image
    ]]
	
	{name = '24/7', loc = 'CHAR_FLOYD', file = '247'},
    {name = 'Ammunation', loc = 'CHAR_AMMUNATION', file = 'CHAR_AMMUNATION'},
    {name = 'Weazel News', loc = 'CHAR_FLOYD', file = 'NEWS'},
    {name = 'Vanilla Unicorn', loc = 'CHAR_MP_STRIPCLUB_PR', file = 'CHAR_MP_STRIPCLUB_PR'},
    {name = 'Downtown Cab Co.', loc = 'CHAR_TAXI', file = 'CHAR_TAXI'},
    {name = 'Los Santos Traffic Info', loc = 'CHAR_LS_TOURIST_BOARD', file = 'CHAR_LS_TOURIST_BOARD'},
    {name = 'Los Santos Customs', loc = 'CHAR_LS_CUSTOMS', file = 'CHAR_LS_CUSTOMS'},
    {name = 'Liquor Ace', loc = 'CHAR_FLOYD', file = 'ACE'},
    {name = 'Limited Gasoline', loc = 'CHAR_FLOYD', file = 'LTD'},
    {name = 'PostOP', loc = 'CHAR_FLOYD', file = 'OP'},
    {name = 'Cluckin\' Bell', loc = 'CHAR_FLOYD', file = 'BELL'},
    {name = 'Bugstars', loc = 'CHAR_FLOYD', file = 'BUG'},
    {name = 'Fleeca Bank', loc = 'CHAR_BANK_FLEECA', file = 'CHAR_BANK_FLEECA'},
    {name = 'Gruppe6', loc = 'CHAR_FLOYD', file = 'GRUPPE6'},
    {name = 'Mors Mutual Insurance', loc = 'CHAR_MP_MORS_MUTUAL', file = 'CHAR_MP_MORS_MUTUAL'},
    {name = 'Los Santos Water and Power', loc = 'CHAR_FLOYD', file = 'LSWP'},
    {name = 'Dynasty 8', loc = 'CHAR_FLOYD', file = 'D8'},
}





--This determines if Vehicle Repair/Clean/Delete options apprear in the Vehicle Menu
Config.VehicleOptions = true





--This determines if a help message shows when playing an emote
Config.EmoteHelp = true

--These are list of emotes that are available through the menu
Config.EmotesList = {
    {name = 'smoke', emote = 'WORLD_HUMAN_SMOKING'},
    {name = 'cop', emote = 'WORLD_HUMAN_COP_IDLES'},
    {name = 'lean', emote = 'WORLD_HUMAN_LEANING'},
    {name = 'sit', emote = 'WORLD_HUMAN_PICNIC'},
    {name = 'stupor', emote = 'WORLD_HUMAN_STUPOR'},
    {name = 'sunbathe2', emote = 'WORLD_HUMAN_SUNBATHE_BACK'},
    {name = 'sunbathe', emote = 'WORLD_HUMAN_SUNBATHE'},
    {name = 'medic', emote = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD'},
    {name = 'clipboard', emote = 'WORLD_HUMAN_CLIPBOARD'},
    {name = 'party', emote = 'WORLD_HUMAN_PARTYING'},
    {name = 'kneel', emote = 'CODE_HUMAN_MEDIC_KNEEL'},
    {name = 'notepad', emote = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH'},
    {name = 'weed', emote = 'WORLD_HUMAN_SMOKING_POT'},
    {name = 'impatient', emote = 'WORLD_HUMAN_STAND_IMPATIENT'},
    {name = 'fish', emote = 'WORLD_HUMAN_STAND_FISHING'},
    {name = 'weld', emote = 'WORLD_HUMAN_WELDING'},
    {name = 'camera', emote = 'WORLD_HUMAN_PAPARAZZI'},
    {name = 'film', emote = 'WORLD_HUMAN_MOBILE_FILM_SHOCKING'},
    {name = 'cheer', emote = 'WORLD_HUMAN_CHEERING'},
    {name = 'binoculars', emote = 'WORLD_HUMAN_BINOCULARS'},
    {name = 'flex', emote = 'WORLD_HUMAN_MUSCLE_FLEX'},
    {name = 'weights', emote = 'WORLD_HUMAN_MUSCLE_FREE_WEIGHTS'},
    {name = 'yoga', emote = 'WORLD_HUMAN_YOGA'},
    {name = 'coffee', emote = 'WORLD_HUMAN_AA_COFFEE'},
    {name = 'traffic', emote = 'WORLD_HUMAN_CAR_PARK_ATTENDANT'},
    {name = 'hammer', emote = 'WORLD_HUMAN_HAMMERING'},
    {name = 'guard', emote = 'WORLD_HUMAN_GUARD_STAND'},
    {name = 'statue', emote = 'WORLD_HUMAN_HUMAN_STATUE'},
    {name = 'jog', emote = 'WORLD_HUMAN_JOG_STANDING'},
    {name = 'clean', emote = 'WORLD_HUMAN_MAID_CLEAN'},
    {name = 'music', emote = 'WORLD_HUMAN_MUSICIAN'},
    {name = 'phone', emote = 'WORLD_HUMAN_STAND_MOBILE_UPRIGHT'},
    {name = 'mechanic', emote = 'WORLD_HUMAN_VEHICLE_MECHANIC'},
}