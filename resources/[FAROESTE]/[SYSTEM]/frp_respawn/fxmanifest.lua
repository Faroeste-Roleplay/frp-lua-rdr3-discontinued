fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
client_scripts {
	'@_core/lib/utils.lua',
	'config.lua',
	'client.lua'
}

server_script {
	'@_core/lib/utils.lua',
	'server.lua'
}

ui_page 'html/map2.html'

files {
	'html/*',
	'html/js/*'
}
