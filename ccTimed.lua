local ccTimed = {}

local responseCode = require("tcpResponseCode")

function ccTimed.GiveItem(item)
    if item == nil then
        return responseCode.failure, "Item does not exist"
    end
    if player:HasCollectible(item) then
        return responseCode.failure, "User Already Has Item"
    end
    player:AddCollectible(item, 0, true)

    return responseCode.success
end

function ccTimed.Invulnerable()
    if invulnerable == true then
        return responseCode.failure, "Effect already active"
    end
    invulnerable = true
    return responseCode.success
end

function ccTimed.Invulnerable_end()
    invulnerable = false
    return responseCode.success
end

function ccTimed.InverseControls()
    if inverted_controls == true then
        return responseCode.failure, "Effect already active"
    end
    inverted_controls = true
    return responseCode.success
end

function ccTimed.InverseControls_end()
    inverted_controls = false
    return responseCode.success
end

function ccTimed.Pixelation()
    if pixelation_active == true then
        return responseCode.failure, "Effect already active"
    end
    Game():AddPixelation(300)
    pixelation_active = true
    return responseCode.success
end

function ccTimed.Pixelation_end()
    pixelation_active = false
    return responseCode.success
end

function ccTimed.flipped()
    if shader_inverted == 1 then
        return responseCode.failure, "Effect already active"
    end
    shader_inverted = 1
    return responseCode.success
end

function ccTimed.flipped_end()
    shader_inverted = 0
    return responseCode.success
end

function ccTimed.flight()
    active_flight = true
    return ccTimed.GiveItem(CollectibleType.COLLECTIBLE_TRANSCENDENCE)
end

function ccTimed.flight_end()
    active_flight = false
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_TRANSCENDENCE) then
        return responseCode.success --Failure, but success? somehow?
    end
    player:RemoveCollectible(CollectibleType.COLLECTIBLE_TRANSCENDENCE)
    return responseCode.success
end

ccTimed.methods = {
    inverted_timed = ccTimed.InverseControls,
    inverted_timed_end = ccTimed.InverseControls_end,
    invulnerable_timed = ccTimed.Invulnerable,
    invulnerable_timed_end = ccTimed.Invulnerable_end,
    pixelation_timed = ccTimed.Pixelation,
    pixelation_timed_end = ccTimed.Pixelation_end,
    flipped_timed = ccTimed.flipped,
    flipped_timed_end = ccTimed.flipped_end,
    flight_timed = ccTimed.flight,
    flight_timed_end = ccTimed.flight_end
}

return ccTimed


