local ccTrinkets = {}

-- Used internally
function ccTrinkets:GiveTrinket()
    player:AddTrinket(math.random(TrinketType.NUM_TRINKETS))
end

function ccTrinkets:DropTrinket()
    player:DropTrinket(player.Position, false)
end

function ccTrinkets:ReplaceTrinket()
    ccTrinkets:DropTrinket()
    ccTrinkets:GiveTrinket()
end

--When adding a new function add the mapping of Crowd control code to function here
ccTrinkets.methods = {
    ReplaceTrinket = ccTrinkets.ReplaceTrinket,
    drop_trinket = ccTrinkets.DropTrinket
}

return ccTrinkets