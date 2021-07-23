--BlueBerryRP creator

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    '@_core/lib/utils.lua',
    'client.lua',
    'config.lua'
}

shared_script 'config.lua'

server_scripts {
    '@_core/lib/utils.lua',
    '@frp_chests/server.lua',
    'config.lua',
    'server.lua',
}
