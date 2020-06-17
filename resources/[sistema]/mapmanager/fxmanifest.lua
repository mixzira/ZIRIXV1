fx_version 'bodacious'
game 'gta5'

client_scripts {
    'mapmanager_shared.lua',
    'mapmanager_client.lua'
}

server_scripts {
    'mapmanager_shared.lua',
    'mapmanager_server.lua'
}


server_export 'getCurrentGameType'
server_export 'getCurrentMap'
server_export 'changeGameType'
server_export 'changeMap'
server_export 'doesMapSupportGameType'
server_export 'getMaps'
server_export 'roundEnded'