fx_version "cerulean"
games {"gta5"}

version "1.0"

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"server.lua"
}

client_script {
	"client.lua"
}
