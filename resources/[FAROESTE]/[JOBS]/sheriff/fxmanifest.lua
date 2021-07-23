fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_script { 
'@_core/lib/utils.lua',
'client/client.lua',
'warmenu.lua',
'config.lua'

}
server_script {
'@_core/lib/utils.lua',
'server/server.lua',
'config.lua',
}