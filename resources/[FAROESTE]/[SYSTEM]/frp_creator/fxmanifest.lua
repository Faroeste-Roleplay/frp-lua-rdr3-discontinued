fx_version "adamant"
games {"rdr3"}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


client_scripts{
    "@_core/lib/utils.lua",
    'config/mp_male.lua',
    'config.lua',
	'config/mp_female.lua',
    'client/client.lua',
    'client/spawn.lua'
}

server_scripts{
    "@_core/lib/utils.lua",
    'server.lua'}


ui_page('client/html/index.html')

files({
    'client/html/img/*',
    'client/html/fonts/*',
    'client/html/*',
    'client/html/webfonts/*',
    'client/html/css/*',
    'server.lua'
})
