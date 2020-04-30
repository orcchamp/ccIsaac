local ccTrinkets = {}

local responseCode = require("tcpResponseCode")

-- Used internally
function ccTrinkets:GiveTrinket()
    player:AddTrinket(math.random(TrinketType.NUM_TRINKETS))
end

function ccTrinkets:DropTrinket()
    local trinket = player:GetTrinket()
    if trinket ==  nil or trinket == TrinketType.TRINKET_NULL then
        return responseCode.failure, "No Trinket To Drop"
    end
    player:DropTrinket(player.Position, false)
end

function ccTrinkets:ReplaceTrinket()
    local response, message = ccTrinkets:DropTrinket()
    if response == responseCode.failure then
        return response, message
    end
    ccTrinkets:GiveTrinket()
    return responseCode.success
end

--When adding a new function add the mapping of Crowd control code to function here
ccTrinkets.methods = {
    ReplaceTrinket = ccTrinkets.ReplaceTrinket,
    drop_trinket = ccTrinkets.DropTrinket
}

return ccTrinkets