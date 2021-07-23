fx_version "adamant"
games {"rdr3"}

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_scripts {
    "@_core/lib/utils.lua",
    "client.lua",
    'hashes/hash_models.lua',
    'hashes/hash_peds.lua',
    'hashes/hash_provisions.lua',
    'hashes/hash_vehicles.lua',
    'hashes/hash_doors.lua',
    'hashes/hash_carriable.lua'
}

server_scripts {
    "server.lua"
}

files {
    "save.json",
}
