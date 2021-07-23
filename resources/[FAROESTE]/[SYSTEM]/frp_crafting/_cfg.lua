Config = {
    {
        -- position = vec3(0, 0, 0) -- No position, its global
        campfire = true,
        craftings = {
            {
                -- ! cIndex (crafting index)
                time = 40,
                input = {
                    {item = "meat_poor", amount = 1, alias = {"meat_good", "meat_perfect"}} -- ! cInputIndex (crafting input index)
                },
                output = {
                    -- {item = "money", amount = 1, name = "Na fogueira"} -- ! cInputIndex (crafting input index)
                    {item = "meat_cooked", amount = 1}
                }
            },
            {
                time = 60,
                input = {
                    {item = "meat_poor", amount = 1, alias = {"meat_good", "meat_perfect"}},
                    {item = "herb_oregano", amount = 1}
                },
                output = {
                    {item = "meat_oregano_cooked", amount = 1}
                }
            },
            {
                time = 20,
                input = {
                    {item = "herb_rams_head", amount = 3},
                    {item = "flask", amount = 1},
                    {item = "melee_knife", amount = 1, remove = false}
                },
                output = {
                    {item = "opio", amount = 1}
                }
            }
        }
    },
    {
        -- position = vec3(0, 0, 0), -- No position, its global
        craftings = {
            {
                time = 15,
                input = {
                    {item = "bones", amount = 1},
                    {item = "stick", amount = 1},
                    {item = "melee_knife", amount = 1, remove = false}
                },
                output = {
                    {item = "ammo_arrow", amount = 1}
                }
            }
            -- {
            --     time = 40,
            --     input = {
            --         {item = "stick", amount = 2},
            --         {item = "ropecut", amount = 1},
            --         {item = "melee_knife", amount = 1, remove = false}
            --     },
            --     output = {
            --         {item = "bow", amount = 1}
            --     }
            -- },
            -- {
            --     time = 30,
            --     input = {
            --         {item = "rope", amount = 1},
            --         {item = "melee_knife", amount = 1, remove = false}
            --     },
            --     output = {
            --         {item = "ropecut", amount = 5}
            --     }
            -- },
            -- {
            --     time = 30,
            --     input = {
            --         {item = "rope", amount = 1},
            --         {item = "melee_knife", amount = 1, remove = false}
            --     },
            --     output = {
            --         {item = "ropecut", amount = 5}
            --     }
            -- }
        }
    },
    {
        group = "medic",
        craftings = {
            -- {
            --     time = 30,
            --     input = {
            --         {item = "herb_american_ginseng", amount = 1},
            --         {item = "herb_yarrow", amount = 1}
            --     },
            --     output = {
            --         {item = "medicine_poor", amount = 1}
            --     }
            -- },
            -- {
            --     time = 30,
            --     input = {
            --         {item = "herb_sage", amount = 1},
            --         {item = "herb_burdock_root", amount = 1}
            --     },
            --     output = {
            --         {item = "stimulant_poor", amount = 1}
            --     }
            -- },
            {
                time = 90,
                input = {
                    {item = "herb_american_ginseng", amount = 2},
                    -- {item = "herb_yarrow", amount = 2},
                    {item = "flask", amount = 1},
                    -- {item = "herb_english_mace", amount = 2, alias = {"herb_milkweed"}}
                    {item = "herb_common_bullrush", amount = 2},
                    {item = "herb_parasol_mushroom", amount = 2}
                },
                output = {
                    {item = "medicine_good", amount = 1}
                }
            },
            {
                time = 90,
                input = {
                    -- {item = "herb_sage", amount = 2},
                    {item = "herb_desert_sage", amount = 2},
                    {item = "flask", amount = 1},
                    {item = "herb_burdock_root", amount = 1}
                },
                output = {
                    {item = "stimulant_good", amount = 1}
                }
            }
            -- {
            --     time = 90,
            --     input = {
            --         {item = "herb_indian_tobacco", amount = 4},
            --         {item = "herb_american_ginseng", amount = 4},
            --         {item = "herb_sage", amount = 4}
            --     },
            --     output = {
            --         {item = "horse_stimulant_poor", amount = 1}
            --     }
            -- }
        }
    },
    -- {
    --     position = vec3(365.660, 1492.330, 180.677),
    --     craftings = {
    --         {
    --             time = 10,
    --             input = {
    --                 {item = "money", amount = 2}
    --             },
    --             output = {
    --                 {item = "repeater_henry", amount = 1}
    --             }
    --         },
    --     }
    -- }
}

--[[

CRAFTING

CARCANO
DESATIVAR ROLLINGBLOCK
LANCHESTER
WHINCESTER
REVOLVER MOUSER

--]]
