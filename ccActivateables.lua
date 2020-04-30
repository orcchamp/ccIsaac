local ccActivateables = {}

local response = require("tcpResponseCode")

-- Internal function
function ccActivateables:UseActiveItem(item)
    player:UseActiveItem(
        item,
        true,
        false,
        false,
        false
    )
end

function ccActivateables:RollD1()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_D1)
    return response.success
end

function ccActivateables:RollD4()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_D4)
    return response.success
end

function ccActivateables:RollD6()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_D6)
    return response.success
end

function ccActivateables:RollD7()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_D7)
    return response.success
end

function ccActivateables:RollD8()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_D8)
    return response.success
end

function ccActivateables:RollD10()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_D10)
    return response.success
end

function ccActivateables:RollD12()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_D12)
    return response.success
end

function ccActivateables:RollD20()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_D20)
    return response.success
end

function ccActivateables:RollDInf()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_DINF)
    return response.success
end

function ccActivateables:UseGuppiesHead()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_GUPPYS_HEAD)
    return response.success
end

function ccActivateables:UseGuppiesPaw()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_GUPPYS_PAW)
    return response.success
end

function ccActivateables:UseShovel()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_WE_NEED_GO_DEEPER)
    return response.success
end

function ccActivateables:UseDadsKey()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_DADS_KEY)
    return response.success
end

function ccActivateables:UseClicker()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_CLICKER)
    return response.success
end

function ccActivateables:UsePause()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_PAUSE)
    return response.success
end

function ccActivateables:UseMegaBlast()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_MEGA_SATANS_BREATH )
    return response.success
end

function ccActivateables:UseForgetMeNow()
    ccActivateables:UseActiveItem(CollectibleType.COLLECTIBLE_FORGET_ME_NOW)
    return response.success
end

--When adding a new function add the mapping of Crowd control code to function here
ccActivateables.methods = {
    use_d1 = ccActivateables.RollD1,
    use_d4 = ccActivateables.RollD4,
    use_d6 = ccActivateables.RollD6,
    use_d7 = ccActivateables.RollD7,
    use_d8 = ccActivateables.RollD8,
    use_d10 = ccActivateables.RollD10,
    use_d12 = ccActivateables.RollD12,
    use_d20 = ccActivateables.RollD20,
    use_d_inf = ccActivateables.RollDInf,

    use_guppies_head = ccActivateables.UseGuppiesHead,
    use_guppies_paw = ccActivateables.UseGuppiesPaw,

    use_shovel = ccActivateables.UseShovel,
    use_dads_key = ccActivateables.UseDadsKey,
    use_clicker = ccActivateables.UseClicker,
    use_pause = ccActivateables.UsePause,
    use_mega_blast = ccActivateables.UseMegaBlast,
    use_forget_me_now = ccActivateables.UseForgetMeNow}
return ccActivateables