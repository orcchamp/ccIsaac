local ccMisc = {}

function ccMisc:RandomTeleport()
    Game():MoveToRandomRoom(true, rng:Next())
end

local Curses = { LevelCurse.CURSE_OF_DARKNESS, 
LevelCurse.CURSE_OF_THE_LOST, 
LevelCurse.CURSE_OF_THE_UNKNOWN,
LevelCurse.CURSE_OF_BLIND, 
LevelCurse.CURSE_OF_THE_MAZE
}

function ccMisc:ApplyRandomCurse()
    Game():GetLevel():AddCurse(Curses[math.random(#Curses)] , true)
end

--When adding a new function add the mapping of Crowd control code to function here
ccMisc.methods = {
    apply_random_curse = ccMisc.ApplyRandomCurse,
    random_tp = ccMisc.RandomTeleport
}

return ccMisc;