Config = {}

-- priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    ["steam:11000010596ee06"] = 99, -- KLAN
    ["steam:110000115598f8c"] = 99, -- GASHEX
    ["steam:1100001349014c1"] = 99, -- BELA
    ["steam:110000106321dbf"] = 99, -- SORAM
    ["steam:110000109766c18"] = 99, -- KEY

    ["steam:110000101b89514"] = 99, -- gabe peixe
    ["steam:110000102190921"] = 99, -- 
    ["steam:1100001014c2ccf"] = 99,
    ["steam:1100001053cb788"] = 99, -- Marcobc

    ["steam:11000011b6dcf70"] = 50, -- clonado
    
     -- ///////////////// APOIADORES //////////////////
    ["steam:11000010760ea7e"] = 30, -- thiago neves
    ["steam:1100001157cbdd3"] = 30, -- Nicky Mitrava#6377 -- 22/07
    ["steam:110000107156247"] = 45, -- Miojo#0001 / 11.06
    ["steam:110000114c155cc"] = 45, -- ELÉ JUNIOR / 11.06
    ["steam:110000106ff1cbd"] = 25, -- Supla Games#1480 / 11.06
    ["steam:110000105f862f7"] = 45, -- PaL0MinhA#0001 / 11.06
    ["steam:11000011559ed3f"] = 5, -- Coelho#6335 / 11.06 
    ["steam:1100001067bddc2"] = 30, -- Franco Signorelli#9502 / 11.06
    ["steam:11000011204cc57"] = 18, -- Meninote#5349 / 11.06
    ["steam:110000111b14f4c"] = 10, -- CoyotePlay#0096 / 11.06
    ["steam:110000136568842"] = 5, -- Leandrosniper#8919 / 11.06
    ["steam:11000010f7857eb"] = 5, -- Mands#7288 / 11.06
    ["steam:1100001063df198"] = 10, -- nhish#4982 / 11.06
    ["steam:11000010593d219"] = 10, -- ALPHAIAT#6345 / 11.07
    ["steam:11000010760ea7e"] = 30, -- Rent#7650 / 11.07
    ["steam:11000011cdcba80"] = 30,  -- Diamante brutalfatal_zétafé#469 (244) / 29.06
    ["steam:110000105a713f4"] = 5, -- Richard.Grawe#1438 (166) / Setando em 14.07
    ["steam:1100001321f881e"] = 10, -- DiGreia#8360 / 20.07
    ["steam:11000010326195e"] = 15, -- jayvi#8804 / 22-07
    ["steam:11000013b3cbafd"] = 15, -- indaiass#0697 / 22-07

   -- ///////////////// NITRO BOOSTERS //////////////////
    ["steam:1100001128e0a15"] = 15, -- Revolvi38#0038 / 11.06
    ["steam:110000134de800c"] = 15, -- NattefrostHe4rt#9761 / 11.06
    ["steam:1100001178ea858"] = 15, -- Tayfe#8846 / 11.06
    ["steam:110000135fcae2c"] = 15, -- Chaveco#0666 / 11.06
    ["steam:11000010c99c072"] = 15, -- dark paradise#0014 / 11.06
    ["steam:11000010d34c06e"] = 15, -- Quinny#7957 / 11.06
    ["steam:1100001121b084e"] = 15, -- FixoH`#1117 / 11.06
    ["steam:11000010b03fc75"] = 15, -- BlackFPS#0007 / 11.06
    ["steam:11000010dc424d9"] = 15, -- Mark Nunes#3418 / 11.06
    ["steam:1100001055da0a1"] = 15, -- Blue Eyes#4732 / 11.06
    ["steam:110000112643e37"] = 15, -- cleytinho2000#7166 / 11.06
    ["steam:11000013c62e106"] = 15, -- Farlindu#3891 / 11.06
    ["steam:1100001045461b8"] = 15, -- dinho#6107 / 11.06
    ["steam:110000110f385c2"] = 15, -- ! a Shimatai#0001 / 11.06
    ["steam:110000107caf442"] = 15, -- Diego OwnZ#0862 / 11.06
    ["steam:1100001062dd384"] = 15, -- nery#8195 / 11.06
    ["steam:110000134b230b1"] = 15, -- Velma Dricky#4393 / 11.06
    ["steam:110000113393044"] = 15, -- Andrade#1920 / 11.06 
    ["steam:110000107275cee"] = 15, -- Bunny Style#0001 (292) / 11.06

}
-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 90

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = true

-- how much priority power grace time will give
Config.GracePower = 5

-- how long grace time lasts in seconds
Config.GraceTime = 600

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 30000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Entrando...",
    connecting = "\xE2\x8F\xB3Carregando...",
    idrr = "\xE2\x9D\x97[Queue] Error: Não foi identificado seu id, por favor, relogue.",
    err = "\xE2\x9D\x97[Queue] Temos um erro",
    pos = "\xF0\x9F\x90\x8CVocê é %d/%d na fila \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[Queue] Error: Erro ao adicionar você a fila de espera.",
    timedout = "\xE2\x9D\x97[Queue] Error: O tempo de espera esgotou?!",
    wlonly = "\xE2\x9D\x97[Queue] Você não está na whitelist deste servidor.",
    steam = "\xE2\x9D\x97 [Queue] Error: Sua steam precisa estar aberta."
}