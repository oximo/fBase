ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('fellow:ammu')
AddEventHandler('fellow:ammu', function(ITEM,price)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then
        xPlayer.removeMoney(price)
TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammu', function(account)
    if account then
        account.addMoney(price)
    end
end)
        xPlayer.addInventoryItem(ITEM, 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)