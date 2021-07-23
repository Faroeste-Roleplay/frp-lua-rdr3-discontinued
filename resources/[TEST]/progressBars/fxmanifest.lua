fx_version "adamant"

games { 'rdr3', 'gta5' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page 'h.html'

client_scripts {
    'client.lua'
} 

files {
    'h.html',
    'chineserocks.ttf',
    'RDRLino-Regular.ttf'
}

export "startUI"
export "closeUI"