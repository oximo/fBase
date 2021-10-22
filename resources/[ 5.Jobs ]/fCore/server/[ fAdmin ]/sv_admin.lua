ESX = nil

local reportTable = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

--Argent cash
RegisterServerEvent("fAdmin:GiveArgentCash")
AddEventHandler("fAdmin:GiveArgentCash", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addMoney((total))
    envoyerdiscord("fAdmin","__Give d'argent cash :__ "..total.."€ \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

--Argent sale
RegisterServerEvent("fAdmin:GiveArgentSale")
AddEventHandler("fAdmin:GiveArgentSale", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('black_money', total)
    envoyerdiscord("fAdmin","__Give d'argent sale :__ "..total.."€ \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

--Argent banque
RegisterServerEvent("fAdmin:GiveArgentBanque")
AddEventHandler("fAdmin:GiveArgentBanque", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('bank', total)
    envoyerdiscord("fAdmin","__Give d'argent banque :__ "..total.."€ \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

--Kick
RegisterServerEvent('fAdmin:kickjoueur')
AddEventHandler('fAdmin:kickjoueur', function(id, raison)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tragetxPlayer = ESX.GetPlayerFromId(id)
    local reason = "Vous avez été kick par "..xPlayer.getName().." pour la raison suivante : "..raison
    DropPlayer(id, reason)
    envoyerdiscord("fAdmin","__Kick :__ "..tragetxPlayer.getName().." \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

--Give véhicule avec clées
RegisterServerEvent('fAdmin:vehicule')
AddEventHandler('fAdmin:vehicule', function(vehicleProps, plate, veh)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
    end)
    envoyerdiscord("fAdmin","__Give de véhicule :__ "..veh.." \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

RegisterServerEvent('fAdmin:vehiculejoueur')
AddEventHandler('fAdmin:vehiculejoueur', function(vehicleProps, plate, IdSelected, veh)
    local xPlayer = ESX.GetPlayerFromId(IdSelected)
    local lestaff = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
    end)
    envoyerdiscord("fAdmin","__Give de véhicule joueur :__ "..xPlayer.getName().."\n\n__Véhicule :__ "..veh.."\n\n__Staff :__ "..lestaff.getName().."", 16744192, fAdmin.webhooks)
end)

--Report
ESX.RegisterServerCallback('fAdmin:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

RegisterCommand('report', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    local NomDuMec = xPlayer.getName()
    local idDuMec = source
    local RaisonDuMec = table.concat(args, " ")
    if #RaisonDuMec <= 1 then
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez rentrer une raison valable")
    elseif #RaisonDuMec >= 20 then
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez rentrer une raison moins longue")
    else
        TriggerClientEvent("esx:showNotification", source, "~g~Votre report a bien était envoyer")
        TriggerClientEvent("fAdmin:Open/CloseReport", -1, 1)
        table.insert(reportTable, {
            id = idDuMec,
            nom = NomDuMec,
            args = RaisonDuMec,
        })
    end
end, false)

RegisterServerEvent("fAdmin:CloseReport")
AddEventHandler("fAdmin:CloseReport", function(nomMec, raisonMec)
    TriggerClientEvent("fAdmin:Open/CloseReport", -1, 2, nomMec, raisonMec)
    table.remove(reportTable, id, nom, args)
end)

ESX.RegisterServerCallback('fAdmin:infoReport', function(source, cb)
    cb(reportTable)
end)

RegisterServerEvent("fAdmin:bring")
AddEventHandler("fAdmin:bring",function(IdDuMec, plyPedCoords, lequel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        if lequel == "bring" then
            TriggerClientEvent("fAdmin:bring", IdDuMec, plyPedCoords)
        else
            TriggerClientEvent("fAdmin:bring", plyPedCoords, IdDuMec)
        end
    else
        print('Tu peux pas !')
    end
end)

RegisterNetEvent("fAdmin:Message")
AddEventHandler("fAdmin:Message", function(id, type)
    TriggerClientEvent("fAdmin:envoyer", id, type)
end)

--BAN/Warn
local bancache,namecache = {},{}
local open_assists,active_assists = {},{}

function split(s, delimiter)result = {};for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, match) end return result end

Citizen.CreateThread(function() -- startup
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX==nil do Wait(0) end
    
    MySQL.ready(function()
        refreshNameCache()
        refreshBanCache()
    end)

    sendToDiscord("fAdmin has been started...")

    ESX.RegisterServerCallback("fAdmin:ban", function(source,cb,target,reason,length,offline)
        if not target or not reason then return end
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)
        if not xPlayer or (not xTarget and not offline) then cb(nil); return end
        if isAdmin(xPlayer) then
            local success, reason = banPlayer(xPlayer,offline and target or xTarget,reason,length,offline)
            cb(success, reason)
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("fAdmin:warn",function(source,cb,target,message,anon)
        if not target or not message then return end
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)
        if not xPlayer or not xTarget then cb(nil); return end
        if isAdmin(xPlayer) then
            warnPlayer(xPlayer,xTarget,message,anon)
            cb(true)
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("fAdmin:getWarnList",function(source,cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            local warnlist = {}
            for k,v in ipairs(MySQL.Sync.fetchAll("SELECT * FROM bwh_warnings LIMIT @limit",{["@limit"]=Config.page_element_limit})) do
                v.receiver_name=namecache[v.receiver]
                v.sender_name=namecache[v.sender]
                table.insert(warnlist,v)
            end
            cb(json.encode(warnlist),MySQL.Sync.fetchScalar("SELECT CEIL(COUNT(id)/@limit) FROM bwh_warnings",{["@limit"]=Config.page_element_limit}))
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("fAdmin:getBanList",function(source,cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            local data = MySQL.Sync.fetchAll("SELECT * FROM bwh_bans LIMIT @limit",{["@limit"]=Config.page_element_limit})
            local banlist = {}
            for k,v in ipairs(data) do
                v.receiver_name = namecache[json.decode(v.receiver)[1]]
                v.sender_name = namecache[v.sender]
                table.insert(banlist,v)
            end
            cb(json.encode(banlist),MySQL.Sync.fetchScalar("SELECT CEIL(COUNT(id)/@limit) FROM bwh_bans",{["@limit"]=Config.page_element_limit}))
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("fAdmin:getListData",function(source,cb,list,page)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            if list=="banlist" then
                local banlist = {}
                for k,v in ipairs(MySQL.Sync.fetchAll("SELECT * FROM bwh_bans LIMIT @limit OFFSET @offset",{["@limit"]=Config.page_element_limit,["@offset"]=Config.page_element_limit*(page-1)})) do
                    v.receiver_name = namecache[json.decode(v.receiver)[1]]
                    v.sender_name = namecache[v.sender]
                    table.insert(banlist,v)
                end
                cb(json.encode(banlist))
            else
                local warnlist = {}
                for k,v in ipairs(MySQL.Sync.fetchAll("SELECT * FROM bwh_warnings LIMIT @limit OFFSET @offset",{["@limit"]=Config.page_element_limit,["@offset"]=Config.page_element_limit*(page-1)})) do
                    v.sender_name=namecache[v.sender]
                    v.receiver_name=namecache[v.receiver]
                    table.insert(warnlist,v)
                end
                cb(json.encode(warnlist))
            end
        else logUnfairUse(xPlayer); cb(nil) end
    end)

    ESX.RegisterServerCallback("fAdmin:unban",function(source,cb,id)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            MySQL.Async.execute("UPDATE bwh_bans SET unbanned=1 WHERE id=@id",{["@id"]=id},function(rc)
                local bannedidentifier = "N/A"
                for k,v in ipairs(bancache) do
                    if v.id==id then
                        bannedidentifier = v.receiver[1]
                        bancache[k].unbanned = true
                        break
                    end
                end
                logAdmin(("Admin ^1%s^7 unbanned ^1%s^7 (%s)"):format(xPlayer.getName(),(bannedidentifier~="N/A" and namecache[bannedidentifier]) and namecache[bannedidentifier] or "N/A",bannedidentifier))
                cb(rc>0)
            end)
        else logUnfairUse(xPlayer); cb(false) end
    end)
    ESX.RegisterServerCallback("fAdmin:getIndexedPlayerList",function(source,cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
        	local players = {}
        	for k,v in ipairs(ESX.GetPlayers()) do
        		players[tostring(v)]=GetPlayerName(v)..(v==source and " (self)" or "")
        	end
        	cb(json.encode(players))
        else logUnfairUse(xPlayer); cb(false) end
    end)
end)

RegisterServerEvent('fAdmin:backupcheck')
AddEventHandler('fAdmin:backupcheck', function()
    local identifiers = GetPlayerIdentifiers(source)
    local banned = isBanned(identifiers)
    if banned then
        DropPlayer(source, "Ban bypass detected, don’t join back!")
    end
end)

AddEventHandler("playerConnecting",function(name, setKick, def)
    local identifiers = GetPlayerIdentifiers(source)
    if #identifiers>0 and identifiers[1]~=nil then
        local banned, data = isBanned(identifiers)
        namecache[identifiers[1]]=GetPlayerName(source)
        if banned then
            print(("[^1"..GetCurrentResourceName().."^7] Banned player %s (%s) tried to join, their ban expires on %s (Ban ID: #%s)"):format(GetPlayerName(source),data.receiver[1],data.length and os.date("%Y-%m-%d %H:%M",data.length) or "PERMANENT",data.id))
            local kickmsg = Config.banformat:format(data.reason,data.length and os.date("%Y-%m-%d %H:%M",data.length) or "PERMANENT",data.sender_name,data.id)
            if Config.backup_kick_method then DropPlayer(source,kickmsg) else def.done(kickmsg) end
        else
            local playername = GetPlayerName(source)
            local saneplayername = "Adjusted Playername"
            if string.gsub(playername, "[^a-zA-Z0-9]", "") ~= "" then
                saneplayername = string.gsub(playername, "[^a-zA-Z0-9 ]", "")
            end
            local data = {["@name"]=saneplayername}
            for k,v in ipairs(identifiers) do
                data["@"..split(v,":")[1]]=v
            end
            if not data["@steam"] then
	        if Config.kick_without_steam then
		    print("[^1"..GetCurrentResourceName().."^7] Player connecting without steamid, removing player from server.")
		    def.done("You need to have steam open to play on this server.")
		else
                    print("[^1"..GetCurrentResourceName().."^7] Player connecting without steamid, skipping identifier storage.")
		end
            else
                MySQL.Async.execute("INSERT INTO `bwh_identifiers` (`steam`, `license`, `ip`, `name`, `xbl`, `live`, `discord`, `fivem`) VALUES (@steam, @license, @ip, @name, @xbl, @live, @discord, @fivem) ON DUPLICATE KEY UPDATE `license`=@license, `ip`=@ip, `name`=@name, `xbl`=@xbl, `live`=@live, `discord`=@discord, `fivem`=@fivem",data)
            end
        end
    else
        if Config.backup_kick_method then DropPlayer(source,"[BWH] No identifiers were found when connecting, please reconnect") else def.done("[BWH] No identifiers were found when connecting, please reconnect") end
    end
end)

AddEventHandler("playerDropped",function(reason)
    if open_assists[source] then open_assists[source]=nil end
    for k,v in ipairs(active_assists) do
        if v==source then
            active_assists[k]=nil
            TriggerClientEvent("chat:addMessage",k,{color={255,0,0},multiline=false,args={"BWH","The admin that was helping you dropped from the server"}})
            return
        elseif k==source then
            TriggerClientEvent("fAdmin:assistDone",v)
            TriggerClientEvent("chat:addMessage",v,{color={255,0,0},multiline=false,args={"BWH","The player you were helping dropped from the server, teleporting back..."}})
            active_assists[k]=nil
            return
        end
    end
end)

function refreshNameCache()
    namecache={}
    for k,v in ipairs(MySQL.Sync.fetchAll("SELECT steam,name FROM bwh_identifiers")) do
        namecache[v.steam]=v.name
    end
end

function refreshBanCache()
    bancache={}
    for k,v in ipairs(MySQL.Sync.fetchAll("SELECT id,receiver,sender,reason,UNIX_TIMESTAMP(length) AS length,unbanned FROM bwh_bans")) do
        table.insert(bancache,{id=v.id,sender=v.sender,sender_name=namecache[v.sender]~=nil and namecache[v.sender] or "N/A",receiver=json.decode(v.receiver),reason=v.reason,length=v.length,unbanned=v.unbanned==1})
    end
end

function sendToDiscord(msg)
    if fAdmin.webhooks ~= "" then
        PerformHttpRequest(fAdmin.webhooks, function(a,b,c)end, "POST", json.encode({embeds={{title="BWH Action Log",description=msg:gsub("%^%d",""),color=65280,}}}), {["Content-Type"]="application/json"})
    end
end

function logAdmin(msg)
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            TriggerClientEvent("chat:addMessage",v,{color={255,0,0},multiline=false,args={"BWH",msg}})
            sendToDiscord(msg)
        end
    end
end

function isBanned(identifiers)
    for _,ban in ipairs(bancache) do
        if not ban.unbanned and (ban.length==nil or ban.length>os.time()) then
            for _,bid in ipairs(ban.receiver) do
                if bid:find("ip:") and Config.ip_ban then
                    for _,pid in ipairs(identifiers) do
                        if bid==pid then return true, ban end
                    end
                end
            end
        end
    end
    return false, nil
end

function isAdmin(xPlayer)
    for k,v in ipairs(Config.admin_groups) do
        if xPlayer.getGroup()==v then return true end
    end
    return false
end

function execOnAdmins(func)
    local ac = 0
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            ac = ac + 1
            func(v)
        end
    end
    return ac
end

function logUnfairUse(xPlayer)
    if not xPlayer then return end
    print(("[^1"..GetCurrentResourceName().."^7] Player %s (%s) tried to use an admin feature"):format(xPlayer.getName(),xPlayer.identifier))
    logAdmin(("Player %s (%s) tried to use an admin feature"):format(xPlayer.getName(),xPlayer.identifier))
end

function banPlayer(xPlayer,xTarget,reason,length,offline)
    local targetidentifiers,offlinename,timestring,data = {},nil,nil,nil
    if offline then
        data = MySQL.Sync.fetchAll("SELECT * FROM bwh_identifiers WHERE steam=@identifier",{["@identifier"]=xTarget})
        if #data<1 then
            return false, "~r~Identifier is not in identifiers database!"
        end
        offlinename = data[1].name
        for k,v in pairs(data[1]) do
            if k~="name" then table.insert(targetidentifiers,v) end
        end
    else
        targetidentifiers = GetPlayerIdentifiers(xTarget.source)
    end
    if length=="" then length = nil end
    MySQL.Async.execute("INSERT INTO bwh_bans(id,receiver,sender,length,reason) VALUES(NULL,@receiver,@sender,@length,@reason)",{["@receiver"]=json.encode(targetidentifiers),["@sender"]=xPlayer.identifier,["@length"]=length,["@reason"]=reason},function(_)
        local banid = MySQL.Sync.fetchScalar("SELECT MAX(id) FROM bwh_bans")
        logAdmin(("Player ^1%s^7 (%s) got banned by ^1%s^7, expiration: %s, reason: '%s'"..(offline and " (OFFLINE BAN)" or "")):format(offline and offlinename or xTarget.getName(),offline and data[1].steam or xTarget.identifier,xPlayer.getName(),length~=nil and length or "PERMANENT",reason))
        if length~=nil then
            timestring=length
            local year,month,day,hour,minute = string.match(length,"(%d+)/(%d+)/(%d+) (%d+):(%d+)")
            length = os.time({year=year,month=month,day=day,hour=hour,min=minute})
        end
        table.insert(bancache,{id=banid==nil and "1" or banid,sender=xPlayer.identifier,reason=reason,sender_name=xPlayer.getName(),receiver=targetidentifiers,length=length})
        if offline then xTarget = ESX.GetPlayerFromIdentifier(xTarget) end -- just in case the player is on the server, you never know
        if xTarget then
            TriggerClientEvent("fAdmin:gotBanned",xTarget.source, reason)
            Citizen.SetTimeout(5000, function()
                DropPlayer(xTarget.source,Config.banformat:format(reason,length~=nil and timestring or "PERMANENT",xPlayer.getName(),banid==nil and "1" or banid))
            end)
        else return false, "~r~Unknown error (MySQL?)" end
        return true, ""
    end)
end

function warnPlayer(xPlayer,xTarget,message,anon)
    MySQL.Async.execute("INSERT INTO bwh_warnings(id,receiver,sender,message) VALUES(NULL,@receiver,@sender,@message)",{["@receiver"]=xTarget.identifier,["@sender"]=xPlayer.identifier,["@message"]=message})
    TriggerClientEvent("fAdmin:receiveWarn",xTarget.source,anon and "" or xPlayer.getName(),message)
    logAdmin(("Admin ^1%s^7 warned ^1%s^7 (%s), Message: '%s'"):format(xPlayer.getName(),xTarget.getName(),xTarget.identifier,message))
end

AddEventHandler("fAdmin:ban",function(sender,target,reason,length,offline)
    if source=="" then -- if it's from server only
        banPlayer(sender,target,reason,length,offline)
    end
end)

AddEventHandler("fAdmin:warn",function(sender,target,message,anon)
    if source=="" then -- if it's from server only
        warnPlayer(sender,target,message,anon)
    end
end)

RegisterCommand("bwh", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        if args[1]=="ban" or args[1]=="warn" or args[1]=="warnlist" or args[1]=="banlist" then
            TriggerClientEvent("fAdmin:showWindow",source,args[1])
        elseif args[1]=="refresh" then
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"BWH","Refreshing ban & name cache..."}})
            refreshNameCache()
            refreshBanCache()
        elseif args[1]=="assists" then
            local openassistsmsg,activeassistsmsg = "",""
            for k,v in pairs(open_assists) do
                openassistsmsg=openassistsmsg.."^5ID "..k.." ("..GetPlayerName(k)..")^7 - "..v.."\n"
            end
            for k,v in pairs(active_assists) do
                activeassistsmsg=activeassistsmsg.."^5ID "..k.." ("..GetPlayerName(k)..")^7 - "..v.." ("..GetPlayerName(v)..")\n"
            end
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=true,args={"BWH","Pending assists:\n"..(openassistsmsg~="" and openassistsmsg or "^1No pending assists")}})
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=true,args={"BWH","Active assists:\n"..(activeassistsmsg~="" and activeassistsmsg or "^1No active assists")}})
        else
            TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","Invalid sub-command! (^4ban^7,^4warn^7,^4banlist^7,^4warnlist^7,^4refresh^7)"}})
        end
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","You don't have permissions to use this command!"}})
    end
end)

-- Wipe

RegisterNetEvent("fAdmin:WipePlayer")
AddEventHandler("fAdmin:WipePlayer", function(player)
    WipePlayer(source, player)
end)

function WipePlayer(id, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    local steam = xPlayer.getIdentifier()

    DropPlayer(target, "Vous vous êtes fait wipe !")

    MySQL.Async.execute([[ 
		DELETE FROM billing WHERE identifier = @wipeID;
		DELETE FROM billing WHERE sender = @wipeID;
		DELETE FROM open_car WHERE identifier = @wipeID;
		DELETE FROM owned_vehicles WHERE owner = @wipeID;
 		DELETE FROM users WHERE identifier = @wipeID;	]], {
		['@wipeID'] = steam,
    }, function(rowsChanged)
        print("^5Wipe effectuer ! SteamID :"..steam.."^0")
    end)
end


-- Announce

RegisterServerEvent('fAdmin:sendAnnounce')
AddEventHandler('fAdmin:sendAnnounce', function(target, text, author)
    local xPlayer = ESX.GetPlayerFromId(source)
    local NomDuStaff = xPlayer.getName()
		if (author == nil and target ~= -1) then
			author = GetPlayerName(source);
		end

		TriggerClientEvent('fAdmin:sendAnnounce', target, text, author);
        envoyerdiscord("fAdmin","__Une announce :__ "..text.." \n\n__Staff :__ "..NomDuStaff.."", 16744192, fAdmin.webhooks)
end)


-- Discord

function envoyerdiscord(name,message,color,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "fAdmin by Fellow",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(fAdmin.webhooks, function(err, text, headers) end, 'POST', json.encode({ username = "fAdmin Bot",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end