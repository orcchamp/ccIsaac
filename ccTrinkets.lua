local ccTrinkets = {}

local responseCode = require("tcpResponseCode")

-- Used internally
function ccTrinkets:GiveTrinket()
	local trinket = 1 + rng:RandomInt(TrinketType.NUM_TRINKETS)
	--player:AnimateTrinket (trinket, "Pickup", "PlayerPickupSparkle")
	player:AddTrinket(trinket)
end

function ccTrinkets:DropTrinket()
    local trinket = player:GetTrinket(0)

    if trinket ==  nil or trinket == TrinketType.TRINKET_NULL then
        return responseCode.failure, "No Trinket To Drop"
    end

    player:DropTrinket(player.Position, false)
end

function ccTrinkets:ReplaceTrinket()
    local response, message = ccTrinkets:DropTrinket()

    ccTrinkets:GiveTrinket()
    return responseCode.success
end

--When adding a new function add the mapping of Crowd control code to function here
ccTrinkets.methods = {
    replace_trinket = ccTrinkets.ReplaceTrinket,
    drop_trinket = ccTrinkets.DropTrinket
}

return ccTrinkets