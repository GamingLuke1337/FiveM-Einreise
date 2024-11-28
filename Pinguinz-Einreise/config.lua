Config = {}


Config.Locale = 'de'
Config.VersionChecker = true
Config.Debug = true


-- Positions and Markers
Config.Einreise = {
    {x = -1042.46, y = -2745.62, z = 21.36}
}
Config.Position = {
    vector3(-1082.14, -2826.92, 27.71)
}
Config.Position2 = {
    vector3(-1042.46, -2745.62, 21.36)
}
Config.MarkerCoords = { -- Marker position (there can be more than one)
    {x = -1065.74, y = -2798.57, z = 26.71}
}
Config.Draw3DText = true


-- Options for markers and Admin-commands
Config.EnableMarker = true -- Enable/disable markers
Config.EnableAdmin = true -- Admin control (must be disabled if commands are used)
Config.EnableCommand = false -- Command control (must be disabled if admin control is used)
Config.SetMarker = 'seteinreise' -- Command to set a marker
Config.DelMarker = 'deleinreise' -- Command to delete a marker
