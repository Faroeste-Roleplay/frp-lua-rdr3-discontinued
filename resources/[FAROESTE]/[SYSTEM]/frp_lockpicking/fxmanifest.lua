fx_version "adamant"
games {"rdr3"}
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_scripts {
	"@_core/lib/utils.lua",
	"lockpicking_client.lua"
}

server_scripts {
	"@_core/lib/utils.lua",
	"lockpicking_server.lua"
}

server_export "startRobbery"

export "lockpick"

ui_page "html/ui.html"

files {
	"html/*",
	"html/sounds/*",
	"html/assets/*"
}
