







fx_version 'adamant'

game 'gta5'

description 'ESX Police JOB'

version '0.1'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/es.lua',
    'locales/fr.lua',
    'locales/en.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/es.lua',
    'locales/fr.lua',
    'locales/en.lua',
    'config.lua',
    'client/main.lua'
}

dependencies {
    'es_extended'
}
