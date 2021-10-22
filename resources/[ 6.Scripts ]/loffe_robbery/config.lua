Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'en'  

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 28.5), heading = 266.0, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-705.73, -914.91, 18.22), heading = 89.21, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1222.82, -908.94, 11.32), heading = 36.64, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-46.65, -1757.91, 28.42), heading = 59.03, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1134.08, -982.72, 45.41), heading = 277.21, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1165.02, -323.87, 68.20), heading = 98.01, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1486.57, -377.62, 39.16), heading = 134.32, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1819.10, 793.05, 137.08), heading = 124.87, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(-2966.35, 391.30, 14.04), heading = 85.08, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(-3040.79, 583.97, 6.90), heading = 20.30, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(-3244.24, 1000.17, 11.83), heading = 356.37, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(549.30, 2669.45, 41.15), heading = 92.10, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(2676.40, 3280.25, 54.24), heading = 331.44, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(1959.10, 3741.63, 31.34), heading = 299.68, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(1696.90, 4923.60, 41.06), heading = 322.80, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(1728.71, 6417.05, 34.03), heading = 248.71, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(1728.71, 2710.78, 37.15), heading = 181.67, money = {2500, 10000}, cops = 1, blip = false, name = 'Superette', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false}
}

Translation = {
    ['en'] = {
        ['shopkeeper'] = 'Jean',
        ['robbed'] = "Je viens ~r~d'etre~w~braquer!",
        ['cashrecieved'] = 'Vous avez:',
        ['currency'] = '$',
        ['scared'] = 'Effrayé:',
        ['no_cops'] = 'Y\'a pas assez de ~r~policier~w~ !',
        ['cop_msg'] = 'Nous avons envoyé une photo à la police avec la CCTV camera!',
        ['set_waypoint'] = 'Définir le point de passage au magasin',
        ['hide_box'] = 'Fermer le menu',
        ['robbery'] = 'Vol en cours',
        ['walked_too_far'] = 'Vous avez marche trop loin!'
    },
    ['sv'] = {
        ['shopkeeper'] = 'butiksbiträde',
        ['robbed'] = 'Jag blev precis rånad och har inga pengar kvar!',
        ['cashrecieved'] = 'Du fick:',
        ['currency'] = 'SEK',
        ['scared'] = 'Rädd:',
        ['no_cops'] = 'Det är inte tillräckligt med poliser online!',
        ['cop_msg'] = 'Vi har skickat en bild på rånaren från övervakningskamerorna!',
        ['set_waypoint'] = 'Sätt GPS punkt på butiken',
        ['hide_box'] = 'Stäng denna rutan',
        ['robbery'] = 'Pågående butiksrån',
        ['walked_too_far'] = 'Du gick för långt bort!'
    },
    ['custom'] = { -- edit this to your language
        ['shopkeeper'] = 'João',
        ['robbed'] = "Acabo de ser ~r~assaltado!",
        ['cashrecieved'] = 'Roubou:',
        ['currency'] = '€',
        ['scared'] = 'Assutado:',
        ['no_cops'] = 'Não há ~r~polícias suficientes~w~!',
        ['cop_msg'] = 'Recebemos uma foto do assaltante pela camera de vigilância.',
        ['set_waypoint'] = 'Marcar mercearia no GPS',
        ['hide_box'] = 'Fechar menu',
        ['robbery'] = 'Assalto a decorrer',
        ['walked_too_far'] = 'Está muito longe!'
    }
}