fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page 'nui/index.html'

server_scripts {
	'@_core/lib/utils.lua',
	'_cfg.lua',
	'server.lua'
}

client_scripts {
	"@_core/lib/warmenu.lua",
	'@_core/lib/utils.lua',
	'@_core/config/Items.lua',
	'_cfg.lua',
	'client.lua'
}

files {
	'nui/index.html',
	'nui/design.css',
	'nui/script.js',
	'nui/assets/*'
}

