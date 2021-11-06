Cfg_Coffre = {
    Prefix = "nCoffre",
    Credit = "nCoffre is started, created by Nehco#7797 or Nehco#0069",
    ESXEvent = "esx:getSharedObject",
    ESXLoaded = nil,
    ServerSide = TriggerServerEvent,
    ClientSide = TriggerClientEvent,
    InSide = TriggerEvent,
    defaultWeight = 1000,
    prt = print,
    main_Menu = {
        menuIsOpen = false,
        totalCount = 0,
        trIndex = 1,
        vInventory = {},
        pInventory = {},
    },
    maxWeight = {
        --[[
            125000 = 125000 grammes donc 125 KG
        ]]
        [0] = 125000, --Compact
        [1] = 125000, --Sedan
        [2] = 125000, --SUV
        [3] = 125000, --Coupes
        [4] = 125000, --Muscle
        [5] = 125000, --Sports Classics
        [6] = 125000, --Sports
        [7] = 125000, --Super
        [8] = 125000, --Motorcycles
        [9] = 125000, --Off-road
        [10] = 125000, --Industrial
        [11] = 125000, --Utility
        [12] = 125000, --Vans
        [13] = 125000, --Cycles
        [14] = 125000, --Boats
        [15] = 125000, --Helicopters
        [16] = 125000, --Planes
        [17] = 125000, --Service
        [18] = 125000, --Emergency
        [19] = 125000, --Military
        [20] = 125000, --Commercial
        [21] = 125000, --Trains,
    },
    itemsWeight = {
        --[[
            Liste des items qui auront un poids "personnalisé", à vous d'en ajouté si cela est nécessaire !
        ]]
        -- Argent sale
        ["black_money"] = 750,
        -- Arme(s) 
        ["WEAPON_PISTOL"] = 2500,
        -- Item(s)
        ["bread"] = 1250,
    },
}
