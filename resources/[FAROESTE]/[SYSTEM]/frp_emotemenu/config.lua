-- Menu configuration, array of menus to display
menuConfigs = {
    ['menu'] = {
        enableMenu = function()
            return true
        end,
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                }
            }
        }
    }
}

-- Submenu configuration
subMenuConfigs = {
    ['submenu1'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"SLEEP", "SIT GROUND", "IDLE", "IDLE 2", "LEAN RAIL", "DRUNK", "WRITE LEDGER", "COUGH", "PUKE", "DANCE"},
                    commands = {"sleep1", "sitground2", "idle1", "idle2", "leanrail1", "drunk1", "writeledger1", "cough1", "puke1", "dance1"}
                }
            }
        }
    },
    ['submenu2'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"STINKY", "WAVE", "THUMBS UP", "THUMBS DOWN", "DRAW", "YES", "NO", "HELL YEAH", "SPIT", "APPLAUSE", "SLOW CLAP", "TA-DA"},
                    commands = {"stinky1", "wave1", "thumbsup1", "thumbsdown1", "draw1", "yes1", "no1", "hellyeah1", "idlespit1", "applause1", "slowclap1", "tada1"}
                },
            }
        }
    },
    ['submenu3'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"BLOW KISS", "BOAST", "FLEX", "FOLLOW ME", "LET'S GO", "LET'S CRAFT", "WANNA FISH?", "PLAY CARDS?", "LOOK DISTANCE", "LOOK YONDER", "POINT"},
                    commands = {"blowkiss1", "boast1", "flex1", "followme1", "letsgo1", "letscraft1", "wannafish1", "playcards1", "lookdistance1", "lookyonder1", "point1"}
                }
            }
        }
    },
    ['submenu4'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"POSSE UP", "PROSPECTOR JIG", "SCHEME", "SHOOT EM UP", "SHOOT THE SKY", "LET'S STOP", "FANCY BOW", "GENTLE WAVE", "GOOD TO SEE YA", "TIP HAT", "RESPECTFUL BOW"},
                    commands = {"posseup1", "prospectorjig1", "scheme1", "shootemup1", "shootthesky1", "letsstop1", "fancybow1", "gentlewave1", "goodtoseeya1", "hattipping1", "respectfulbow1"}
                }
            }
        }
    },
    ['submenu5'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"TOUGH GUY NOD", "BEG FOR MERCY", "GAG", "HUSH YOUR MOUTH", "POINT & LAUGH", "I'M HIT", "WEEP", "WHO, ME?", "HEY YOU!", "YEEHAW"},
                    commands = {"toughguynod1", "begformercy1", "gag1", "hushyourmouth1", "pointandlaugh1", "imhit1", "weep1", "whome1", "heyyou1", "yeehaw1"}
                }
            }
        }
    },
    ['submenu6'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"FLIP OFF", "WATCHIN' YOU", "BRING IT ON", "THROAT SLIT", "WAR CRY", "GONNA CRY?", "CHICKEN", "HOW DARE YOU", "DAMN YOU", "HISSY FIT"},
                    commands = {"flipoff1", "watchinyou1", "bringiton1", "throatslit1", "warcry1", "gonnacry1", "chicken1", "howdareyou1", "damn1", "hissyfit1"}
                }
            }
        }
    },
    ['submenu7'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"GUITAR GROUND", "TRUMPET", "SIT GROUND", "CROUCH INSPECT", "STARE STOIC", "STERN IDLE", "BADASS", "BARTENDER", "BROOM", "COFFEE", "LEAN WALL", "IMPATIENT"},
                    commands = {"guitar1", "trumpet1", "sitground1", "crouchinspect1", "starestoic1", "sternidles1", "badass1", "bartender1", "broom1", "coffee1", "walllean1", "impatient1"}
                }
            }
        }
    },
}

-->> Emote commands
RegisterCommand("testemote", function(source, args, rawCommand)
    TriggerEvent('wwrp:testemote')
end)
    
RegisterNetEvent('wwrp:testemote')
AddEventHandler('wwrp:testemote', function()
    local dict = 'mech_loco_m@character@arthur@carry@crate_tnt@idle'
    local ani = 'idle'

    loadAnimDict(dict)
    TaskPlayAnim(PlayerPedId(), dict, ani, 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict(dict)
end)


RegisterCommand("closewheel", function(source, args, rawCommand)
    TriggerEvent('wwrp:closewheel')
end)
    
RegisterNetEvent('wwrp:closewheel')
AddEventHandler('wwrp:closewheel', function()
    SetNuiFocus(false, false)
end)


RegisterCommand("cancelemote", function(source, args, rawCommand)
    TriggerEvent('wwrp:cancelemote')
end)
    
RegisterNetEvent('wwrp:cancelemote')
AddEventHandler('wwrp:cancelemote', function()
    ClearPedTasks(PlayerPedId())
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
end)

--- STANCE MENU
RegisterCommand("drunk1", function(source, args, rawCommand)
    TriggerEvent('wwrp:drunk1')
end)
    
RegisterNetEvent('wwrp:drunk1')
AddEventHandler('wwrp:drunk1', function()
    loadAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_b', 'idle_e', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
end)
------
RegisterCommand("sitground2", function(source, args, rawCommand)
    TriggerEvent('wwrp:sitground2')
end)
    
RegisterNetEvent('wwrp:sitground2')
AddEventHandler('wwrp:sitground2', function()
    loadAnimDict('amb_camp@world_camp_fire_sit_ground@male_c@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb_camp@world_camp_fire_sit_ground@male_c@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_camp@world_camp_fire_sit_ground@male_c@idle_a')
end)
------
RegisterCommand("sleep1", function(source, args, rawCommand)
    TriggerEvent('wwrp:sleep1')
end)
    
RegisterNetEvent('wwrp:sleep1')
AddEventHandler('wwrp:sleep1', function()
    loadAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
    TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_sleep_ground@arm@male_b@idle_b', 'idle_f', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
end)
------
RegisterCommand("leanrail1", function(source, args, rawCommand)
    TriggerEvent('wwrp:leanrail1')
end)
    
RegisterNetEvent('wwrp:leanrail1')
AddEventHandler('wwrp:leanrail1', function()
    loadAnimDict('amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c')
    TaskPlayAnim(PlayerPedId(), 'amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c', 'idle_g', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c')
end)
------
RegisterCommand("writeledger1", function(source, args, rawCommand)
    TriggerEvent('wwrp:writeledger1')
end)
    
RegisterNetEvent('wwrp:writeledger1')
AddEventHandler('wwrp:writeledger1', function()
    loadAnimDict('amb_work@world_human_write_notebook@female_a@idle_c')
    TaskPlayAnim(PlayerPedId(), 'amb_work@world_human_write_notebook@female_a@idle_c', 'idle_g', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_work@world_human_write_notebook@female_a@idle_c')
end)
------
RegisterCommand("idle1", function(source, args, rawCommand)
    TriggerEvent('wwrp:idle1')
end)
    
RegisterNetEvent('wwrp:idle1')
AddEventHandler('wwrp:idle1', function()
    loadAnimDict('amb_misc@world_human_stand_waiting@female_a@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_stand_waiting@female_a@idle_a', 'idle_a', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_stand_waiting@female_a@idle_a')
end)
------
RegisterCommand("idle2", function(source, args, rawCommand)
    TriggerEvent('wwrp:idle2')
end)

RegisterNetEvent('wwrp:idle2')
AddEventHandler('wwrp:idle2', function()
    loadAnimDict('amb_misc@world_human_stand_waiting@female_a@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_stand_waiting@female_a@idle_a', 'idle_b', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_stand_waiting@female_a@idle_a')
end)
------
RegisterCommand("cough1", function(source, args, rawCommand)
    TriggerEvent('wwrp:cough1')
end)
    
RegisterNetEvent('wwrp:cough1')
AddEventHandler('wwrp:cough1', function()
    loadAnimDict('amb_misc@world_human_coughing@male_c@wip_base')
    TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_coughing@male_c@wip_base", "wip_base", 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_coughing@male_c@wip_base')
end)
------
RegisterCommand("puke1", function(source, args, rawCommand)
    TriggerEvent('wwrp:puke1')
end)
    
RegisterNetEvent('wwrp:puke1')
AddEventHandler('wwrp:puke1', function()
    loadAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
    TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_vomit@male_a@idle_b", "idle_f", 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
end)
------
RegisterCommand("dance1", function(source, args, rawCommand)
    TriggerEvent('wwrp:dance1')
end)
    
RegisterNetEvent('wwrp:dance1')
AddEventHandler('wwrp:dance1', function()
    loadAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_a', 'idle_c', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_a')
end)

--- EMOTE MENU
RegisterCommand("stinky1", function(source, args, rawCommand)
    TriggerEvent('wwrp:stinky1')
end)
    
RegisterNetEvent('wwrp:stinky1')
AddEventHandler('wwrp:stinky1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -166523388, 1, 1, 0, 0)
end)
------
RegisterCommand("wave1", function(source, args, rawCommand)
    TriggerEvent('wwrp:wave1')
end)
    
RegisterNetEvent('wwrp:wave1')
AddEventHandler('wwrp:wave1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -339257980, 1, 1, 0, 0)
end)
------
RegisterCommand("thumbsup1", function(source, args, rawCommand)
    TriggerEvent('wwrp:thumbsup1')
end)
    
RegisterNetEvent('wwrp:thumbsup1')
AddEventHandler('wwrp:thumbsup1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 425751659, 1, 1, 0, 0)
end)
------
RegisterCommand("thumbsdown1", function(source, args, rawCommand)
    TriggerEvent('wwrp:thumbsdown1')
end)
    
RegisterNetEvent('wwrp:thumbsdown1')
AddEventHandler('wwrp:thumbsdown1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1509171361, 1, 1, 0, 0)
end)
------
RegisterCommand("draw1", function(source, args, rawCommand)
    TriggerEvent('wwrp:draw1')
end)
    
RegisterNetEvent('wwrp:draw1')
AddEventHandler('wwrp:draw1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1639456476, 1, 1, 0, 0)
end)
------
RegisterCommand("damn1", function(source, args, rawCommand)
    TriggerEvent('wwrp:damn1')
end)
    
RegisterNetEvent('wwrp:damn1')
AddEventHandler('wwrp:damn1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 354512356, 1, 1, 0, 0)
end)
------
RegisterCommand("idlespit1", function(source, args, rawCommand)
    TriggerEvent('wwrp:idlespit1')
end)
    
RegisterNetEvent('wwrp:idlespit1')
AddEventHandler('wwrp:idlespit1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -2106738342, 1, 1, 0, 0)
end)
------
RegisterCommand("yes1", function(source, args, rawCommand)
    TriggerEvent('wwrp:yes1')
end)
    
RegisterNetEvent('wwrp:yes1')
AddEventHandler('wwrp:yes1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -822629770, 1, 1, 0, 0)
end)
------
RegisterCommand("no1", function(source, args, rawCommand)
    TriggerEvent('wwrp:no1')
end)
    
RegisterNetEvent('wwrp:no1')
AddEventHandler('wwrp:no1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -653113914, 1, 1, 0, 0)
end)
------
RegisterCommand("slowclap1", function(source, args, rawCommand)
    TriggerEvent('wwrp:slowclap1')
end)
    
RegisterNetEvent('wwrp:slowclap1')
AddEventHandler('wwrp:slowclap1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1023735814, 1, 1, 0, 0)
end)
------
RegisterCommand("tada1", function(source, args, rawCommand)
    TriggerEvent('wwrp:tada1')
end)
    
RegisterNetEvent('wwrp:tada1')
AddEventHandler('wwrp:tada1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -462132925, 1, 1, 0, 0)
end)
------
RegisterCommand("blowkiss1", function(source, args, rawCommand)
    TriggerEvent('wwrp:blowkiss1')
end)
    
RegisterNetEvent('wwrp:blowkiss1')
AddEventHandler('wwrp:blowkiss1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1927505461, 1, 1, 0, 0)
end)
------
RegisterCommand("boast1", function(source, args, rawCommand)
    TriggerEvent('wwrp:boast1')
end)
    
RegisterNetEvent('wwrp:boast1')
AddEventHandler('wwrp:boast1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1252070669, 1, 1, 0, 0)
end)
------
RegisterCommand("hellyeah1", function(source, args, rawCommand)
    TriggerEvent('wwrp:hellyeah1')
end)
    
RegisterNetEvent('wwrp:hellyeah1')
AddEventHandler('wwrp:hellyeah1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -402959, 1, 1, 0, 0)
end)
------
RegisterCommand("flex1", function(source, args, rawCommand)
    TriggerEvent('wwrp:flex1')
end)
    
RegisterNetEvent('wwrp:flex1')
AddEventHandler('wwrp:flex1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -773960361, 1, 1, 0, 0)
end)
------
RegisterCommand("followme1", function(source, args, rawCommand)
    TriggerEvent('wwrp:followme1')
end)
    
RegisterNetEvent('wwrp:followme1')
AddEventHandler('wwrp:followme1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1115379199, 1, 1, 0, 0)
end)
------
RegisterCommand("hissyfit1", function(source, args, rawCommand)
    TriggerEvent('wwrp:hissyfit1')
end)
    
RegisterNetEvent('wwrp:hissyfit1')
AddEventHandler('wwrp:hissyfit1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 796723886, 1, 1, 0, 0)
end)
------
RegisterCommand("letsgo1", function(source, args, rawCommand)
    TriggerEvent('wwrp:letsgo1')
end)
    
RegisterNetEvent('wwrp:letsgo1')
AddEventHandler('wwrp:letsgo1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1593752891, 1, 1, 0, 0)
end)
------
RegisterCommand("applause1", function(source, args, rawCommand)
    TriggerEvent('wwrp:applause1')
end)
    
RegisterNetEvent('wwrp:applause1')
AddEventHandler('wwrp:applause1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -221241824, 1, 1, 0, 0)
end)
------
RegisterCommand("letscraft1", function(source, args, rawCommand)
    TriggerEvent('wwrp:letscraft1')
end)
 
RegisterNetEvent('wwrp:letscraft1')
AddEventHandler('wwrp:letscraft1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -415456998, 1, 1, 0, 0)
end)
------
RegisterCommand("wannafish1", function(source, args, rawCommand)
    TriggerEvent('wwrp:wannafish1')
end)
    
RegisterNetEvent('wwrp:wannafish1')
AddEventHandler('wwrp:wannafish1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1159716480, 1, 1, 0, 0)
end)
------
RegisterCommand("playcards1", function(source, args, rawCommand)
    TriggerEvent('wwrp:playcards1')
end)
    
RegisterNetEvent('wwrp:playcards1')
AddEventHandler('wwrp:playcards1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -843470756, 1, 1, 0, 0)
end)
------
RegisterCommand("lookdistance1", function(source, args, rawCommand)
    TriggerEvent('wwrp:lookdistance1')
end)
    
RegisterNetEvent('wwrp:lookdistance1')
AddEventHandler('wwrp:lookdistance1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 935157006, 1, 1, 0, 0)
end)
------
RegisterCommand("lookyonder1", function(source, args, rawCommand)
    TriggerEvent('wwrp:lookyonder1')
end)
    
RegisterNetEvent('wwrp:lookyonder1')
AddEventHandler('wwrp:lookyonder1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 7918540, 1, 1, 0, 0)
end)
------
RegisterCommand("point1", function(source, args, rawCommand)
    TriggerEvent('wwrp:point1')
end)
    
RegisterNetEvent('wwrp:point1')
AddEventHandler('wwrp:point1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 486225122, 1, 1, 0, 0)
end)
------
RegisterCommand("posseup1", function(source, args, rawCommand)
    TriggerEvent('wwrp:posseup1')
end)
    
RegisterNetEvent('wwrp:posseup1')
AddEventHandler('wwrp:posseup1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 474409519, 1, 1, 0, 0)
end)
------
RegisterCommand("prospectorjig1", function(source, args, rawCommand)
    TriggerEvent('wwrp:prospectorjig1')
end)
    
RegisterNetEvent('wwrp:prospectorjig1')
AddEventHandler('wwrp:prospectorjig1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1307697675, 1, 1, 0, 0)
end)
------
RegisterCommand("scheme1", function(source, args, rawCommand)
    TriggerEvent('wwrp:scheme1')
end)
    
RegisterNetEvent('wwrp:scheme1')
AddEventHandler('wwrp:scheme1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 589481092, 1, 1, 0, 0)
end)
------
RegisterCommand("shootemup1", function(source, args, rawCommand)
    TriggerEvent('wwrp:shootemup1')
end)
    
RegisterNetEvent('wwrp:shootemup1')
AddEventHandler('wwrp:shootemup1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1639456476, 1, 1, 0, 0)
end)
------
RegisterCommand("shootthesky1", function(source, args, rawCommand)
    TriggerEvent('wwrp:shootthesky1')
end)
    
RegisterNetEvent('wwrp:shootthesky1')
AddEventHandler('wwrp:shootthesky1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1939251934, 1, 1, 0, 0)
end)
------
RegisterCommand("letsstop1", function(source, args, rawCommand)
    TriggerEvent('wwrp:letsstop1')
end)
    
RegisterNetEvent('wwrp:letsstop1')
AddEventHandler('wwrp:letsstop1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1691237868, 1, 1, 0, 0)
end)
------
RegisterCommand("fancybow1", function(source, args, rawCommand)
    TriggerEvent('wwrp:fancybow1')
end)
    
RegisterNetEvent('wwrp:fancybow1')
AddEventHandler('wwrp:fancybow1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -2121881035, 1, 1, 0, 0)
end)
------
RegisterCommand("gentlewave1", function(source, args, rawCommand)
    TriggerEvent('wwrp:gentlewave1')
end)
    
RegisterNetEvent('wwrp:gentlewave1')
AddEventHandler('wwrp:gentlewave1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 901097731, 1, 1, 0, 0)
end)
------
RegisterCommand("goodtoseeya1", function(source, args, rawCommand)
    TriggerEvent('wwrp:goodtoseeya1')
end)
    
RegisterNetEvent('wwrp:goodtoseeya1')
AddEventHandler('wwrp:goodtoseeya1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 523585988, 1, 1, 0, 0)
end)
------
RegisterCommand("hattipping1", function(source, args, rawCommand)
    TriggerEvent('wwrp:hattipping1')
end)
    
RegisterNetEvent('wwrp:hattipping1')
AddEventHandler('wwrp:hattipping1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1457020913, 1, 1, 0, 0)
end)
------
RegisterCommand("heyyou1", function(source, args, rawCommand)
    TriggerEvent('wwrp:heyyou1')
end)
    
RegisterNetEvent('wwrp:heyyou1')
AddEventHandler('wwrp:heyyou1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 831975651, 1, 1, 0, 0)
end)
------
RegisterCommand("respectfulbow1", function(source, args, rawCommand)
    TriggerEvent('wwrp:respectfulbow1')
end)
    
RegisterNetEvent('wwrp:respectfulbow1')
AddEventHandler('wwrp:respectfulbow1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1801715172, 1, 1, 0, 0)
end)
------
RegisterCommand("toughguynod1", function(source, args, rawCommand)
    TriggerEvent('wwrp:toughguynod1')
end)
    
RegisterNetEvent('wwrp:toughguynod1')
AddEventHandler('wwrp:toughguynod1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1879954891, 1, 1, 0, 0)
end)
------
RegisterCommand("begformercy1", function(source, args, rawCommand)
    TriggerEvent('wwrp:begformercy1')
end)
    
RegisterNetEvent('wwrp:begformercy1')
AddEventHandler('wwrp:begformercy1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 164860528, 1, 1, 0, 0)
end)
------
RegisterCommand("howdareyou1", function(source, args, rawCommand)
    TriggerEvent('wwrp:howdareyou1')
end)
    
RegisterNetEvent('wwrp:howdareyou1')
AddEventHandler('wwrp:howdareyou1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1802342943, 1, 1, 0, 0)
end)
------
RegisterCommand("gag1", function(source, args, rawCommand)
    TriggerEvent('wwrp:gag1')
end)
    
RegisterNetEvent('wwrp:gag1')
AddEventHandler('wwrp:gag1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1118911493, 1, 1, 0, 0)
end)
------
RegisterCommand("hushyourmouth1", function(source, args, rawCommand)
    TriggerEvent('wwrp:hushyourmouth1')
end)
    
RegisterNetEvent('wwrp:hushyourmouth1')
AddEventHandler('wwrp:hushyourmouth1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1644757697, 1, 1, 0, 0)
end)
------
RegisterCommand("pointandlaugh1", function(source, args, rawCommand)
    TriggerEvent('wwrp:pointandlaugh1')
end)
    
RegisterNetEvent('wwrp:pointandlaugh1')
AddEventHandler('wwrp:pointandlaugh1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 803206066, 1, 1, 0, 0)
end)
------
RegisterCommand("imhit1", function(source, args, rawCommand)
    TriggerEvent('wwrp:imhit1')
end)
    
RegisterNetEvent('wwrp:imhit1')
AddEventHandler('wwrp:imhit1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -110352861, 1, 1, 0, 0)
end)
------
RegisterCommand("weep1", function(source, args, rawCommand)
    TriggerEvent('wwrp:weep1')
end)
    
RegisterNetEvent('wwrp:weep1')
AddEventHandler('wwrp:weep1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 81347960, 1, 1, 0, 0)
end)
------
RegisterCommand("whome1", function(source, args, rawCommand)
    TriggerEvent('wwrp:whome1')
end)
    
RegisterNetEvent('wwrp:whome1')
AddEventHandler('wwrp:whome1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 329631369, 1, 1, 0, 0)
end)
------
RegisterCommand("yeehaw1", function(source, args, rawCommand)
    TriggerEvent('wwrp:yeehaw1')
end)
    
RegisterNetEvent('wwrp:yeehaw1')
AddEventHandler('wwrp:yeehaw1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 445839715, 1, 1, 0, 0)
end)
------
RegisterCommand("gonnacry1", function(source, args, rawCommand)
    TriggerEvent('wwrp:gonnacry1')
end)
    
RegisterNetEvent('wwrp:gonnacry1')
AddEventHandler('wwrp:gonnacry1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 246916594, 1, 1, 0, 0)
end)
------
RegisterCommand("chicken1", function(source, args, rawCommand)
    TriggerEvent('wwrp:chicken1')
end)
    
RegisterNetEvent('wwrp:chicken1')
AddEventHandler('wwrp:chicken1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1825177171, 1, 1, 0, 0)
end)
------
RegisterCommand("flipoff1", function(source, args, rawCommand)
    TriggerEvent('wwrp:flipoff1')
end)
    
RegisterNetEvent('wwrp:flipoff1')
AddEventHandler('wwrp:flipoff1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 969312568, 1, 1, 0, 0)
end)
------
RegisterCommand("watchinyou1", function(source, args, rawCommand)
    TriggerEvent('wwrp:watchinyou1')
end)
    
RegisterNetEvent('wwrp:watchinyou1')
AddEventHandler('wwrp:watchinyou1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -553424129, 1, 1, 0, 0)
end)
------
RegisterCommand("bringiton1", function(source, args, rawCommand)
    TriggerEvent('wwrp:bringiton1')
end)
    
RegisterNetEvent('wwrp:bringiton1')
AddEventHandler('wwrp:bringiton1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1533402397, 1, 1, 0, 0)
end)
------
RegisterCommand("throatslit1", function(source, args, rawCommand)
    TriggerEvent('wwrp:throatslit1')
end)
    
RegisterNetEvent('wwrp:throatslit1')
AddEventHandler('wwrp:throatslit1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1256841324, 1, 1, 0, 0)
end)
------
RegisterCommand("warcry1", function(source, args, rawCommand)
    TriggerEvent('wwrp:warcry1')
end)
    
RegisterNetEvent('wwrp:warcry1')
AddEventHandler('wwrp:warcry1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 987239450, 1, 1, 0, 0)
end)
--- SCENARIO MENU
RegisterCommand("guitar1", function(source, args, rawCommand)
    TriggerEvent('wwrp:guitar1')
end)
    
RegisterNetEvent('wwrp:guitar1')
AddEventHandler('wwrp:guitar1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_SIT_GUITAR`, 360000, true, false, false, false)
end)
------
RegisterCommand("trumpet1", function(source, args, rawCommand)
    TriggerEvent('wwrp:trumpet1')
end)
    
RegisterNetEvent('wwrp:trumpet1')
AddEventHandler('wwrp:trumpet1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_TRUMPET`, 360000, true, false, false, false)
end)
------
RegisterCommand("sitground1", function(source, args, rawCommand)
    TriggerEvent('wwrp:sitground1')
end)
    
RegisterNetEvent('wwrp:sitground1')
AddEventHandler('wwrp:sitground1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `GENERIC_SIT_GROUND_SCENARIO`, 360000, true, false, false, false)
end)
------
RegisterCommand("crouchinspect1", function(source, args, rawCommand)
    TriggerEvent('wwrp:crouchinspect1')
end)
    
RegisterNetEvent('wwrp:crouchinspect1')
AddEventHandler('wwrp:crouchinspect1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `MP_LOBBY_WORLD_HUMAN_CROUCH_INSPECT`, 360000, true, false, false, false)
end)
------
RegisterCommand("starestoic1", function(source, args, rawCommand)
    TriggerEvent('wwrp:starestoic1')
end)
    
RegisterNetEvent('wwrp:starestoic1')
AddEventHandler('wwrp:starestoic1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `MP_LOBBY_WORLD_HUMAN_STARE_STOIC`, 360000, true, false, false, false)
end)
------
RegisterCommand("sternidles1", function(source, args, rawCommand)
    TriggerEvent('wwrp:sternidles1')
end)
    
RegisterNetEvent('wwrp:sternidles1')
AddEventHandler('wwrp:sternidles1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `MP_LOBBY_WORLD_HUMAN_STERNGUY_IDLES`, 360000, true, false, false, false)
end)
------
RegisterCommand("badass1", function(source, args, rawCommand)
    TriggerEvent('wwrp:badass1')
end)
    
RegisterNetEvent('wwrp:badass1')
AddEventHandler('wwrp:badass1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_BADASS`, 360000, true, false, false, false)
end)
------
RegisterCommand("bartender1", function(source, args, rawCommand)
    TriggerEvent('wwrp:bartender1')
end)
    
RegisterNetEvent('wwrp:bartender1')
AddEventHandler('wwrp:bartender1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_BARTENDER_CLEAN_GLASS`, 360000, true, false, false, false)
end)
------
RegisterCommand("broom1", function(source, args, rawCommand)
    TriggerEvent('wwrp:broom1')
end)
    
RegisterNetEvent('wwrp:broom1')
AddEventHandler('wwrp:broom1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_BROOM`, 360000, true, false, false, false)
end)
------
RegisterCommand("coffee1", function(source, args, rawCommand)
    TriggerEvent('wwrp:coffee1')
end)
    
RegisterNetEvent('wwrp:coffee1')
AddEventHandler('wwrp:coffee1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_COFFEE_DRINK`, 360000, true, false, false, false)
end)
------
RegisterCommand("walllean1", function(source, args, rawCommand)
    TriggerEvent('wwrp:walllean1')
end)
    
RegisterNetEvent('wwrp:walllean1')
AddEventHandler('wwrp:walllean1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_LEAN_BACK_WALL`, 360000, true, false, false, false)
end)
------
RegisterCommand("impatient1", function(source, args, rawCommand)
    TriggerEvent('wwrp:impatient1')
end)
    
RegisterNetEvent('wwrp:impatient1')
AddEventHandler('wwrp:impatient1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_WAITING_IMPATIENT`, 360000, true, false, false, false)
end)
------

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
end