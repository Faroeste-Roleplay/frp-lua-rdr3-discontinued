client_scripts{
    '@_core/lib/utils.lua',
    'client.lua'
}

server_scripts {
	'@_core/lib/utils.lua',
    'server.lua'
}

ui_page 'nui/index.html'


files {
	'nui/index.html', 
    'nui/style.css',
    'nui/assets/crock.ttf',
    'nui/assets/bg.png',
	'nui/assets/bg2.png',
}

game 'rdr3'

fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'