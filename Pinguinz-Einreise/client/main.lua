local Framework = nil
local isneu = false

-- Framework-Erkennung
Citizen.CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        TriggerEvent('esx:getSharedObject', function(obj) Framework = obj end)
        while Framework == nil do Citizen.Wait(10) end
    elseif GetResourceState('qb-core') == 'started' then
        Framework = exports['qb-core']:GetCoreObject()
    end
end)

-- Server gibt den Status (neu / nicht neu) zurück
RegisterNetEvent("isneu") 
AddEventHandler("isneu", function(neu)
    isneu = neu
end)

-- Spieler teleportieren
RegisterNetEvent("flughafentp") 
AddEventHandler("flughafentp", function()
    local playerPed = PlayerPedId()
    for _, v in pairs(Config.Einreise) do
        SetEntityCoords(playerPed, v.x, v.y, v.z, false, false, false, true)
    end
end)

-- Spieler wird im Bereich gehalten, wenn er "neu" ist
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isneu then
            local playerPed = PlayerPedId()
            for _, v in pairs(Config.Einreise) do
                if #(GetEntityCoords(playerPed) - vector3(v.x, v.y, v.z)) > 250 then
                    SetEntityCoords(playerPed, v.x, v.y, v.z, false, false, false, true)
                end
            end
        end
    end
end)

-- Spieler teleportieren (von Server ausgelöst)
RegisterNetEvent("rein:teleport")
AddEventHandler("rein:teleport", function(coords)
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, true)
end)

-- Marker-Funktionalität
RegisterNetEvent("flughafenmarkertp") 
AddEventHandler("flughafenmarkertp", function()
    local playerPed = PlayerPedId()
    for _, v in pairs(Config.Einreise) do
        SetEntityCoords(playerPed, v.x, v.y, v.z, false, false, false, true)
    end
end)

-- Marker und 3D-Text aktivieren
if Config.EnableMarker then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local plyCoords = GetEntityCoords(playerPed)

            for _, v in pairs(Config.MarkerCoords) do
                local distance = #(plyCoords - vector3(v.x, v.y, v.z))

                if distance <= 30 then
                    DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 0.2, 0, 0, 255, 200, false, false, 2, false, nil, nil, false)
                end

                if distance <= 10 then
                    DrawText3D(v.x, v.y, v.z + 1.0, _U('einreisen'))
                end

                if distance <= 1.5 and IsControlJustPressed(1, 38) then -- "E"
                    TriggerServerEvent('einreise:markertp')
                end
            end
        end
    end)
end

-- Admin-spezifische Markierungen
RegisterNetEvent("einreise:MarkerOn") 
AddEventHandler("einreise:MarkerOn", function()
    if Config.EnableAdmin then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local playerPed = PlayerPedId()
                local plyCoords = GetEntityCoords(playerPed)
                local distance = #(plyCoords - vector3(-1082.56, -2827.46, 27.71))

                if distance <= 10 then
                    DrawText3D(-1082.56, -2827.46, 27.71, _U('3dtext_admin'))
                end
            end
        end)
    end
end)

RegisterNetEvent("einreise:MarkerOff") 
AddEventHandler("einreise:MarkerOff", function()
    -- Funktionalität deaktivieren (keine zusätzliche Logik benötigt)
end)

-- Helper-Funktion: 3D-Text zeichnen
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.025 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Befehl einfügen: /einreise [ID]
RegisterCommand('einreise', function(source, args, rawCommand)
    -- Überprüfen, ob eine ID eingegeben wurde
    if #args < 1 then
        print('Bitte gib eine Spieler-ID ein.')
        return
    end

    local playerID = tonumber(args[1]) -- Spieler-ID aus dem Befehl
    local playerPed = PlayerPedId()
    
    -- Überprüfen, ob die ID eine gültige Zahl ist
    if playerID == nil then
        print('Ungültige Spieler-ID!')
        return
    end
    
    -- Teleportiere den Spieler zu der definierten Einreiseposition
    local targetPed = GetPlayerPed(playerID)
    if targetPed ~= nil then
        local coords = GetEntityCoords(targetPed)
        
        -- Teleportiere den Spieler zu den Einreise-Koordinaten
        for _, v in pairs(Config.Einreise) do
            SetEntityCoords(playerPed, v.x, v.y, v.z, false, false, false, true)
            print("Du wurdest zu den Einreise-Koordinaten teleportiert.")
        end
    else
        print('Spieler mit der angegebenen ID nicht gefunden.')
    end
end, false)
