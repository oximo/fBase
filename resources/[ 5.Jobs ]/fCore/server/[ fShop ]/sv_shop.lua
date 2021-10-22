ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('fellow:shop')
AddEventHandler('fellow:shop', function(ITEM,price)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()
    local xBank = xPlayer.getAccount('bank').money

    if xMoney >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(ITEM, 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    elseif xBank >= price then 
        xPlayer.removeAccountMoney('bank', price)
        xPlayer.addInventoryItem(ITEM, 1)
    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)