Citizen.CreateThread(
    function()
        Citizen.Wait(2000)


        ShopPool = {
            -- itemHash, itemAmount, itemPriceDollar, itemPriceGold
            ["Mercadinho"] = {
                vec3(1054.163,91.976,94.305),
                {
                    [46] = {joaat("w_shotgun_doublebarrel"), 1, 0.7, 0.5},
                    [47] = {joaat("w_lasso"), 1, 0.3, 0.7}
                }
            }
        }

        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()
            local pPosition = GetEntityCoords(ped)

            inAShop = false

            for shop, d in pairs(ShopPool) do
                local sPosition = d[1]

                if #(pPosition - sPosition) <= 2.5 then
                    inAShop = true

                    if not Containers["shop"].containerIsOpen then
                        ContainerSetItemPool("shop", d[2])
                        ContainerSetTitle("shop", shop)
                    end
                    break
                end
            end

            if inAShop == false then
                if Containers["shop"].containerIsOpen then
                    stopdrawing("shop")
                end
            end
        end
    end
)
