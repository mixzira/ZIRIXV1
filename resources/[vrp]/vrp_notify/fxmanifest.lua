fx_version 'bodacious'
game 'gta5'

client_script 'client.lua'

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}


files {
	'app.js',
	'index.html',
	'style.css'
}

ui_page {
	'index.html'
}