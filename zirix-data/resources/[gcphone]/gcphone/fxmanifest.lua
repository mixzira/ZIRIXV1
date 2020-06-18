fx_version 'bodacious'
game 'gta5'

ui_page 'html/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'config.lua',
	'client/animation.lua',
	'client/client.lua',
	'client/app_tchat.lua',
	'client/twitter.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@vrp/lib/utils.lua',
	'config.lua',
	'server/server.lua',
	'server/app_tchat.lua',
	'server/twitter.lua'
}

files {
	'html/index.html',
	'html/static/css/app.css',
	'html/static/js/app.js',
	'html/static/js/manifest.js',
	'html/static/js/vendor.js',
	'html/static/config/config.json',
	'html/static/img/coque/background.png',
	'html/static/img/background/background.jpg',
	'html/static/img/icons_app/call.png',
	'html/static/img/icons_app/contacts.png',
	'html/static/img/icons_app/sms.png',
	'html/static/img/icons_app/settings.png',
	'html/static/img/icons_app/menu.png',
	'html/static/img/icons_app/tchat.png',
	'html/static/img/icons_app/twitter.png',
	'html/static/img/app_bank/logo_mazebank.jpg',
	'html/static/img/app_tchat/splashtchat.png',
	'html/static/img/twitter/bird.png',
	'html/static/sound/Twitter_Sound_Effect.ogg',
	'html/static/img/courbure.png',
	'html/static/fonts/fontawesome-webfont.ttf',
	'html/static/sound/ring.ogg',
	'html/static/sound/tchatNotification.ogg',
	'html/static/sound/Phone_Call_Sound_Effect.ogg'
}