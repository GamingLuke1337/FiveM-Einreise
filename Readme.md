# Pinguinz Einreise – Willkommen auf der Reise! ✈️🛬

**Pinguinz Einreise** ist das perfekte Tool, um deine Spieler zur Einreise-Position zu teleportieren. Und das Beste daran: Du musst dich nicht mal anstellen – mit einem einfachen Befehl **/einreise [ID]** teleportierst du Spieler direkt an die Zielposition. Ganz ohne nervige Passkontrolle oder Wartezeiten. 😎

### Features, die du lieben wirst! 🎯

- **/einreise [ID]**: Einfach eine Spieler-ID eingeben und zack! Der Spieler wird zu den coolen Einreise-Koordinaten teleportiert.
- **Automatische Einreise für neue Spieler**: Wenn ein neuer Spieler da ist, wird er direkt zur Einreise-Position teleportiert. Willkommen im Club, mein Freund! 🛸
- **Framework-Unterstützung für alle**: ESX, QB-Core, QBox und mehr werden stetig hinzugefügt – Egal was du brauchst, wir haben es! Das Skript erkennt automatisch, welches Framework du nutzt und passt sich an. 🦎
- **Super einfach**: Kein unnötiger Schnickschnack, nur eine straight-up coole Lösung für dein Servermanagement.

---

### Installation 🛠️

1. **Lade das Skript runter** und schmeiß es in deinen **resources**-Ordner.
2. **Konfiguriere das Skript** in der **`config.lua`**. Hier kannst du die Einreise-Positionen und andere  Einstellungen anpassen – fühl dich frei, kreativ zu werden! 🎨
   
```lua
Config.Locale = 'de'  -- Sprache (de/en)
Config.VersionChecker = true -- Version-Check einschalten (oder abschalten, wenn du nicht gerne updatest)
Config.Debug = false -- Debug aktivieren, wenn du ein Spielzeug in die Hand nehmen willst!

Config.Einreise = { 
    {x = -1042.46, y = -2745.62, z = 21.36}  -- Deine coolen Einreise-Koordinaten
}

Config.MarkerCoords = {  -- Marker Positionen (ja, du kannst mehrere davon setzen, weil wir großzügig sind)
    {x = -1065.74, y = -2798.57, z = 26.71}
}

Config.EnableMarker = true  -- Marker on? (Klar!)
Config.EnableAdmin = false  -- Admin-Magie an/aus
Config.EnableCommand = false -- Kommando an/aus (muss an sein, wenn du die Zauberkräfte willst)
```

3. **Starte das Skript** durch Hinzufügen der Zeile zu deiner **server.cfg**:

```
start Pinguinz-Einreise
```

---


### Befehl: **/einreise** 🎩

So funktioniert der Befehl: **/einreise [ID]**

1. Gib den Befehl **/einreise 1** ein, um Spieler mit der ID **1** zur Einreise-Position zu teleportieren.
2. Fertig! Du bist jetzt der Einreise-Boss! 💼

---

### Changelog 📜

**Version 4.0**  
- Support für **QB**, **ESX Legacy** und **QBox** ! 🎉
- Automatische Framework-Erkennung eingeführt 🔥
- Einführung des Befehls **/einreise [ID]** – teleportiere Spieler zu Einreise-Positionen. 🛸
- Verbesserte Teleportation und Framework-Unterstützung.
- Fehlerbehebungen! 🚀

**ältere Versionen**
- Verwaltet von [bennimedia](https://github.com/bennimedia)

---

### Lizenz 📑

GNU General Public License v3.0
