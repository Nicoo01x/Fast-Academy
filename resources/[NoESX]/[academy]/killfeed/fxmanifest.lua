fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    '/html/img/*.webp',
    '/html/img/*.png',
}

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',
}

escrow_ignore {
    'client.lua'
}
dependency '/assetpacks'