local ESX, QBCore = nil, nil

if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
end

if GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
end

-- Hilfsfunktion zum Abrufen des Spieler-Objekts (ESX/QBCore)
local function GetPlayer(source)
    if ESX then
        return ESX.GetPlayerFromId(source)
    elseif QBCore then
        return QBCore.Functions.GetPlayer(source)
    end
    return nil
end

RegisterNetEvent('playerLoaded')
AddEventHandler('playerLoaded', function(source)
    local xPlayer = GetPlayer(source)
    if not xPlayer then return end

    local steamname = GetPlayerName(source)

    exports.oxmysql:execute('SELECT neu FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
        if result[1] then
            local resultfrommysql2 = result[1].neu

            if resultfrommysql2 == "1" then
                for _, playerId in ipairs(GetPlayers()) do
                    local player = GetPlayer(playerId)
                    if player then
                        local group = player.getGroup and player.getGroup() or "user"
                        if group == "mod" or group == "admin" or group == "superadmin" then
                            TriggerClientEvent('notifications', playerId, "#40fdfe", _U('notification_header'), "Neuer Spieler in der Einreise: " .. steamname .. " | ID: " .. source)
                        end
                    end
                end
                TriggerClientEvent("isneu", source, true)
            else
                TriggerClientEvent("isneu", source, false)
            end
        end
    end)
end)

RegisterCommand("einreise", function(source, args)
    local einreiseID = tonumber(args[1])
    local xPlayer = GetPlayer(source)
    local zPlayer = GetPlayer(einreiseID)

    if not xPlayer or not zPlayer then return end

    local group = xPlayer.getGroup and xPlayer.getGroup() or "user"
    if group == "mod" or group == "admin" or group == "superadmin" then
        TriggerClientEvent('notifications', einreiseID, "#40fdfe", _U('notification_header'), _U('welcome'))
        TriggerClientEvent('notifications', source, "#40fdfe", _U('notification_header'), _U('admin_success'))
        TriggerClientEvent('flughafentp', zPlayer.source)
        TriggerClientEvent("isneu", einreiseID, false)
        exports.oxmysql:executeSync("UPDATE users SET neu = 0 WHERE identifier = ?", {zPlayer.identifier})
    else
        TriggerClientEvent('notifications', source, "#40fdfe", _U('notification_header'), _U('no_rights'))
    end
end)

-- Restliche Befehle (rein, raus, markertp) folgen demselben Muster
-- ...

-- Marker Aktivierung/Deaktivierung
RegisterCommand(Config.SetMarker, function(source)
    TriggerClientEvent('einreise:MarkerOn')
    if Config.Debug then
        print('Einreise: Marker enabled')
    end
end)

RegisterCommand(Config.DelMarker, function(source)
    TriggerClientEvent('einreise:MarkerOff')
    if Config.Debug then
        print('Einreise: Marker disabled')
    end
end)

-- Updater
function GetCurrentVersion()
    return GetResourceMetadata(GetCurrentResourceName(), "version")
end

if Config.VersionChecker then
    PerformHttpRequest('https://raw.githubusercontent.com/GamingLuke1337/FiveM-Einreise/refs/heads/main/VERSION', function(_, NewestVersion)
        local CurrentVersion = GetCurrentVersion()
        
        -- Entfernen von führenden und nachfolgenden Leerzeichen
        CurrentVersion = CurrentVersion:match("^%s*(.-)%s*$")
        NewestVersion = NewestVersion:match("^%s*(.-)%s*$")

        -- Vergleiche die Versionen
        if CurrentVersion ~= NewestVersion then
            print("^1Update Available: ^5Newest Version: ^2" .. NewestVersion)
        end
    end)
end
