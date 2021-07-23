fx_version "adamant"

games {"rdr3"}

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_scripts {
    "@_core/lib/utils.lua",
    "client.lua",
    "ChorePopulators/FeedBagPickup.lua",
    "ChorePopulators/FeedBagPutdown.lua",
    "ChorePopulators/ManurePickup.lua",
    "ChorePopulators/FeedChicken.lua",
}

-- server_scripts {
--     "@_core/lib/utils.lua",
--     'config.lua',
--     'server/server.lua'
-- }
