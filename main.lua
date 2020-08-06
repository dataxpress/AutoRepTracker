reps = {["Neutral"] = {
            ["Silithus"]="Cenarion Circle",
            ["Molten Core"]="Hydraxian Waterlords",
            ["Winterspring"]="Timbermaw Hold",
            ["Felwood"]="Timbermaw Hold",
            ["Zul'Gurub"]="Zandalar Tribe",
            ["Western Plaguelands"]="Argent Dawn",
            ["Eastern Plaguelands"]="Argent Dawn",
            ["Stratholme"]="Argent Dawn",
            ["Scholomance"]="Argent Dawn",    
        },
        ["Alliance"] = { 
            ["Warsong Gulch"]="Silverwing Sentinels",
            ["Arathi Basin"]="The League of Arathor",
            ["Alterac Valley"]="Stormpike Guard",
            ["Stormwind City"]="Stormwind",
            ["Ironforge"]="Ironforge",
            ["Darnassus"]="Darnassus",    
        },
        ["Horde"] = {
            ["Warsong Gulch"]="Warsong Outriders",
            ["Arathi Basin"]="The Defilers",
            ["Alterac Valley"] = "Frostwolf Clan",
            ["Orgrimmar"]="Orgrimmar",
            ["Thunder Bluff"]="Thunder Bluff",
            ["Undercity"]="Undercity",
        },
    }

local ZoneChanged_EventFrame = CreateFrame("Frame")
ZoneChanged_EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ZoneChanged_EventFrame:SetScript("OnEvent",
    function(self, event, ...)
        updateTrackedZone()
    end)

function updateTrackedZone()
    englishFaction, localizedFaction = UnitFactionGroup("player")
    zone = GetRealZoneText()
    rep = reps["Neutral"][zone]
    if rep == null then
        rep = reps[englishFaction][zone]
    end
    if rep ~= null then
        local factionIndex = 1
        local lastFactionName
        repeat
            local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
                canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)
            if name == lastFactionName then break end
            lastFactionName  = name
            if name == rep then 
                SetWatchedFactionIndex(factionIndex)
                print('AutoRepTracker: You are in ' .. zone .. ', so we are now tracking ' .. rep)
            end
            factionIndex = factionIndex + 1
        until factionIndex > 200


    end
end