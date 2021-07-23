Quests = {
    ['carteiro'] = {
        name = "Entregue Cartas",
        helptext = "Missão destinada a entrega de cartas nos devidos lugares marcados no mapa.",
        need = {
            cartas = 15,
            needReturn = true
        },
        rewards = {
            money = math.random(10.1, 35.9),
            exp = 100
        }
    },
    ['entregador'] = {
        name = "Entregue Cargas",
        helptext = "Missão destinada a entrega de cargas nos devidos lugares marcados no mapa.",
        need = {
            cargas = 1,
            needReturn = true
        },
        rewards = {
            money = math.random(10.1, 35.9),
            exp = 100
        }
    },
    ['pescador'] = {
        name = "Pesca? Oi? Pesca?",
        helptext = "Vá até um dos lagos que foi marcado em seu mapa para conseguir utilizar sua vara, já que ninguém usa KKKK.",
        need = {
            peixes = 25,
            needReturn = true
        },
        rewards = {
            money = math.random(10.1, 45.9),
            exp = 75
        }
    },
    ['cacadorderecompensas'] = {
        name = "Capture o Criminoso",
        helptext = "Fale com um chefão deste condado para que você consiga a localização de um dos criminosos perigosos desta cidade.",
        need = {
            criminoso = 1,
            needReturn = true
        },
        rewards = {
            money = math.random(50.1, 95.9),
            exp = 250
        }
    },
    ['mineradordecobre'] = {
        name = "Minerar Cobre",
        helptext = "Encontre uma mina proximo ao local marcado no mapa, este ponto não é um lugar exato, vá em busca do ponto!",
        need = {
            cobre = 1000,
            needReturn = true
        },
        rewards = {
            money = math.random(10.1, 25.9),
            exp = 250
        }
    },
    ['mineradordeprata'] = {
        name = "Minerar Prata",
        helptext = "Encontre uma mina proximo ao local marcado no mapa, este ponto não é um lugar exato, vá em busca do ponto!",
        need = {
            prata = 1000,
            needReturn = true
        },
        rewards = {
            money = math.random(25.1, 35.9),
            exp = 250
        }
    },
    ['mineradordeouro'] = {
        name = "Minerar Ouro",
        helptext = "Encontre uma mina proximo ao local marcado no mapa, este ponto não é um lugar exato, vá em busca do ponto!",
        need = {
            ouro = 1000,
            needReturn = true
        },
        rewards = {
            money = math.random(35.1, 55.9),
            exp = 250
        }
    },
}