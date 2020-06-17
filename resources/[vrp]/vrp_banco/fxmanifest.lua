fx_version 'adamant'
game 'gta5'

author 'MixZira'
contact 'E-mail: mixzira@outlook.com.br - Discord: MixZira#0001'
version '1.0.0'

ui_page('nui/darkside.html')

client_script{
    '@vrp/lib/utils.lua',
    'hansolo/*.lua'
}

server_script {
    '@vrp/lib/utils.lua',
	'skywalker.lua'
}

files {
    'nui/*.html',
    'nui/*.css',
    'nui/**/*.png',
    'nui/**/*.ttf'
}
