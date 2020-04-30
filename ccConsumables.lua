local ccConsumables = {}
local numberOfHearts = 1
local numberOfContainers = 2
local numberOfCoins = 1
local numberOfBombs = 1
local numberofKeys = 1

local responseCode = require("tcpResponseCode")

function ccConsumables:AddHeartContainer()
    local hearts = player:GetMaxHearts()
    if hearts == 24 then
        return responseCode.failure, "Already At Max Hearts"
    end
    player:AddMaxHearts(numberOfContainers)
    return responseCode.success
end

function ccConsumables:RemoveHeartContainer()
    local hearts = player:GetMaxHearts()
    if hearts == 0 then
        return responseCode.failure, "Already At Min Hearts"
    end
    player:AddMaxHearts(-numberOfContainers)
    return responseCode.success
end

function ccConsumables:HealHalfHeart()
    local maxHearts = player:GetMaxHearts()
    local currentHealth = player:GetHearts()
    if currentHealth >= maxHearts then
        return responseCode.failure, "Already At Full Health"
    end
    player:AddHearts(numberOfHearts)
    return responseCode.success
end

function ccConsumables:DamageHalfHeart()
    player:TakeDamage(numberOfHearts, DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 0 )
    return responseCode.success
end

function ccConsumables:AddCoin()
    if player:GetNumCoins() >= 99 then
        return responseCode.failure, "Already At Full Coins"
    end
    player:AddCoins(numberOfCoins)
    return responseCode.success
end

function ccConsumables:RemoveCoin()
    if player:GetNumCoins() <= 0 then
        return responseCode.failure, "Already At Min Coins"
    end
    player:AddCoins(-numberOfCoins);
    return responseCode.success
end

function ccConsumables:AddBomb()
    if player:GetNumBombs() >= 99 then
        return responseCode.failure, "Already At Full Bombs"
    end
    player:AddBombs(numberOfBombs)
    return responseCode.success
end

function ccConsumables:RemoveBomb()
    if player:GetNumBombs() <= 0 then
        return responseCode.failure, "Already At Min Bombs"
    end
    player:AddBombs(-numberOfBombs)
    return responseCode.success
end

function ccConsumables:AddGoldenBomb()
    if player:HasGoldenBomb() then
        return responseCode.failure, "Already Has A Golden Bomb"
    end
    player:AddGoldenBomb()
    return responseCode.success
end

function ccConsumables:RemoveGoldenBomb()
    if not player:HasGoldenBomb() then
        return responseCode.failure, "Doesn't Have A Golden Bomb"
    end
    player:RemoveGoldenBomb()
    return responseCode.success
end

function ccConsumables:AddKey()
    if player:GetNumKeys() >= 99 then
        return responseCode.failure, "Already At Full Keys"
    end
    player:AddKeys(numberofKeys)
    return responseCode.success
end

function ccConsumables:RemoveKey()
    if player:GetNumKeys() <= 0 then
        return responseCode.failure, "Already At Min Keys"
    end
    player:AddKeys(-numberofKeys)
    return responseCode.success
end

function ccConsumables:AddGoldenKey()
    if player:HasGoldenKey() then
        return responseCode.failure, "Already Has A Golden Key"
    end
    player:AddGoldenKey()
    return responseCode.success
end

function ccConsumables:RemoveGoldenKey()
    if not player:HasGoldenKey() then
        return responseCode.failure, "Doesn't Have A Golden Key"
    end
    player:RemoveGoldenKey()
    return responseCode.success
end

function ccConsumables:UseRandomCard()
    player:UseCard(math.random(Card.NUM_CARDS))
    return responseCode.success
end

function ccConsumables:UseRandomPill()
    player:UsePill(math.random(PillEffect.NUM_PILL_EFFECTS),
    math.random(PillColor.NUM_PILLS))
    return responseCode.success
end

--When adding a new function add the mapping of Crowd control code to function here
ccConsumables.methods = {
    add_heart_container = ccConsumables.AddHeartContainer,
    remove_heart_container = ccConsumables.RemoveHeartContainer,
    damage_half_heart = ccConsumables.DamageHalfHeart,
    heal_half_heart = ccConsumables.HealHalfHeart,
    add_coin = ccConsumables.AddCoin,
    remove_coin = ccConsumables.RemoveCoin,
    add_bomb = ccConsumables.AddBomb,
    remove_bomb = ccConsumables.RemoveBomb,
    add_key = ccConsumables.AddKey,
    remove_key = ccConsumables.RemoveKey,
    add_golden_bomb = ccConsumables.AddGoldenBomb,
    remove_golden_bomb = ccConsumables.RemoveGoldenBomb,
    add_golden_key = ccConsumables.AddGoldenKey,
    remove_golden_key = ccConsumables.RemoveGoldenKey,

    use_random_card = ccConsumables.UseRandomCard,
    use_random_pill = ccConsumables.UseRandomPill,
}

return ccConsumables