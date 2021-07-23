fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    "@_core/lib/utils.lua",
    'client_functions.lua',
    'client_main.lua',
    'client_endurance.lua',
    'client_drink.lua',
    'client_eat.lua',
    'client_js.js',
}

server_scripts {
    "@_core/lib/utils.lua",
    "server.lua"
}


exports {
	'js_native',
}