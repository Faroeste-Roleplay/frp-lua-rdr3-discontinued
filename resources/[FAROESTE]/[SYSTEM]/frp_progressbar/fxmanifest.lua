fx_version "adamant"
games { "rdr3" }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page('html/index.html') 

client_scripts {
    'client/main.lua'
}

files {
    'html/*',
    'html/css/*',
    'html/js/*',
    'html/img/*'
}