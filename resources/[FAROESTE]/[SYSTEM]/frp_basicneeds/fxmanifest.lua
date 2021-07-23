fx_version "adamant"

games {'rdr3'}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {    
    'client/*.lua'    
}

server_scripts {    
    'server/*.lua'    
}


files {
    'html/*',
    'html/assets/*',
    'html/css/*',
    'html/js/*'
}

ui_page 'html/ui.html'
