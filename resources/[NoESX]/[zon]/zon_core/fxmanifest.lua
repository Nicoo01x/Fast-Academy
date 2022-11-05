fx_version 'cerulean'

game 'gta5'
-- this_is_a_map 'yes'


client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
	'load.lua',
    'cliente/*.lua',
    'weaponsstream/recoil.lua',
    'weaponsstream/weapons.meta',
    'weaponsstream/weaponcombatpdw.meta',
    'weaponsstream/weaponmachinepistol.meta',
    'weaponsstream/weaponheavypistol.meta',
    'weaponsstream/weapons_assaultrifle_mk2.meta',
    'weaponsstream/weapons_carbinerifle_mk2.meta',
    'weaponsstream/weapons_pistol_mk2.meta',
    'weaponsstream/weapons_smg_mk2.meta',
    'weaponsstream/weaponsnspistol.meta',
    'weaponsstream/weaponspecialcarbine.meta',
    'weaponsstream/weapons_specialcarbine_mk2.meta',
    'weaponsstream/weapons_combat_pistol.meta',
    'weaponsstream/weaponanimations.meta',
    'weaponsstream/weaponcomponents.meta',

	'cliente/scripts/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'server/*.lua',
    'server/scripts/*.lua',
}

shared_scripts {
    'config.lua'
}

-- ui_page "html/index.html"

-- files { 
-- 	'html/index.html',
-- 	'html/style.css',
-- 	'html/config.js'
-- }