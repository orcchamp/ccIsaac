local ccTimed = {}

local responseCode = require("tcpResponseCode")

function ccTimed.ActivateSeedEffect(effect)
    if Game():GetSeeds():HasSeedEffect(effect) == true then
        return responseCode.failure, "Effect already active"
    end
    Game():GetSeeds():AddSeedEffect(effect)
    return responseCode.success
end

function ccTimed.EndSeedEffect(effect)
    if Game():GetSeeds():HasSeedEffect(effect) then
        Game():GetSeeds():RemoveSeedEffect(effect)
    end
    return responseCode.success
end

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
    return ccTimed.ActivateSeedEffect(SeedEffect.SEED_INVISIBLE_ISAAC)
end

function ccTimed.Invulnerable_end()
    return ccTimed.EndSeedEffect(SeedEffect.SEED_INVISIBLE_ISAAC)
end

function ccTimed.InverseControls()
    return ccTimed.ActivateSeedEffect(SeedEffect.SEED_CONTROLS_REVERSED)
end

function ccTimed.InverseControls_end()
    return ccTimed.EndSeedEffect(SeedEffect.SEED_CONTROLS_REVERSED)
end

function ccTimed.Pixelation()
    if SeedEffect.SEED_RETRO_VISION ~= nil then
        pixelation_active = true
        return ccTimed.ActivateSeedEffect(SeedEffect.SEED_RETRO_VISION)
    else
        pixelation_active = true
        Game():AddPixelation(300)
    end
    return responseCode.success
end

function ccTimed.Pixelation_end()
    pixelation_active = false
    if SeedEffect.SEED_RETRO_VISION ~= nil then
        return ccTimed.EndSeedEffect(SeedEffect.SEED_RETRO_VISION)
    end
    return responseCode.success
end

function ccTimed.flipped()
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

function ccTimed.SUPERHOT()
    if SeedEffect.SEED_SUPER_HOT ~= nil then
        return ccTimed.ActivateSeedEffect(SeedEffect.SEED_SUPER_HOT)
    else
        return responseCode.failure, "Can only be used with Repentance"
    end

    return responseCode.success
end

function ccTimed.SUPERHOT_end()
    return ccTimed.EndSeedEffect(SeedEffect.SEED_SUPER_HOT)
end

function ccTimed.NoHUD()
    return ccTimed.ActivateSeedEffect(SeedEffect.SEED_NO_HUD)
end

function ccTimed.NoHUD_end()
    return ccTimed.EndSeedEffect(SeedEffect.SEED_NO_HUD)
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
    flight_timed_end = ccTimed.flight_end,
    super_hot_timed = ccTimed.SUPERHOT,
    super_hot_timed_end = ccTimed.SUPERHOT_end,
    no_hud_timed = ccTimed.NoHUD,
    no_hud_timed_end = ccTimed.NoHUD_end
}

return ccTimed


