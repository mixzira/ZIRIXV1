fx_version 'bodacious'
game 'gta5'

client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

dependencies {
    'mysql-async'
}