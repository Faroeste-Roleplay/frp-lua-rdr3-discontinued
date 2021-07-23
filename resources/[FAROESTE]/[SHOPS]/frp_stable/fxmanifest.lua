fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_script {
	'@_core/lib/utils.lua',
	'config/horse_comp.lua',
	'config/config.lua',
	'client.lua'
}

server_script {
	'@_core/lib/utils.lua',
	'server.lua'
}

ui_page 'html/index.html'

files {
	'html/*',
	'html/css/*',
	'html/fonts/*',
	'html/img/*'
}