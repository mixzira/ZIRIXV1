fx_version 'bodacious'
game 'gta5'

ui_page 'nui/ui.html'

client_scripts{
    '@vrp/lib/utils.lua',
    'client.lua'
}

server_scripts{
    '@vrp/lib/utils.lua',
    'server.lua'
}

files {
	'nui/ui.html',
	'nui/ui.js',
	'nui/ui.css'
}