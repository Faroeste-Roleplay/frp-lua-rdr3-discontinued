fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {'rdr3'}


client_scripts { 
    '@_core/lib/utils.lua',
    "client.lua"
}

server_scripts { 
    '@_core/lib/utils.lua',
    "server.lua"
}

server_export 'checkPayment'