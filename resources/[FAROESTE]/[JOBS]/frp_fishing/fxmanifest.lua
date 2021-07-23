fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    '@_core/lib/utils.lua',
    'client_js.js',
    'client.lua'
}

server_scripts {
    '@_core/lib/utils.lua',
    'server.lua'
}

exports {
	'GET_TASK_FISHING_DATA',
    'SET_TASK_FISHING_DATA',
    'VERTICAL_PROBE'
}
