local ccMisc = {}

local responseCode = require("tcpResponseCode")

local Curses = { LevelCurse.CURSE_OF_DARKNESS, 
LevelCurse.CURSE_OF_THE_LOST, 
LevelCurse.CURSE_OF_THE_UNKNOWN,
LevelCurse.CURSE_OF_BLIND, 
LevelCurse.CURSE_OF_MAZE
}

local AllCurses = (LevelCurse.CURSE_OF_DARKNESS + 
LevelCurse.CURSE_OF_THE_LOST + 
LevelCurse.CURSE_OF_THE_UNKNOWN +
LevelCurse.CURSE_OF_BLIND + 
LevelCurse.CURSE_OF_MAZE )

function table.clone(original)
    return {table.unpack(original)}
end

function ccMisc:GetUnusedCurse()
    local curseClone = table.clone(Curses)
    local index = math.random(#curseClone)
    local selected = curseClone[index]
    local activeCurses = Game():GetLevel():GetCurses()
    if activeCurses == AllCurses  then
        return nil
    end
    while (activeCurses&selected) == selected and #curseClone > 0 do
            table.remove(index)
            index = math.random(#curseClone)
            selected= curseClone[index]

    end
    if #curseClone == 0 then 
        return nil
    end
    return selected
end

function ccMisc:ApplyRandomCurse()
    
    local curse = ccMisc:GetUnusedCurse()
    if curse == nil then
        return responseCode.failure, "All Curses Currently Applied"
    end
    Game():GetLevel():AddCurse( curse , true)
end

function ccMisc:RandomTeleport()
    Game():MoveToRandomRoom(true, rng:Next())
end

--When adding a new function add the mapping of Crowd control code to function here
ccMisc.methods = {
    apply_random_curse = ccMisc.ApplyRandomCurse,
    random_tp = ccMisc.RandomTeleport
}

return ccMisc;