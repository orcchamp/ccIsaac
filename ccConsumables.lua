local ccConsumables = {}
local numberOfHearts = 1
local numberOfCoins = 1
local numberOfBombs = 1
local numberofKeys = 1
function ccConsumables:AddHeartContainer()
    player:AddMaxHearts(numberOfHearts)
end

function ccConsumables:RemoveHeartContainer()
    player:AddMaxHearts(numberOfHearts)
end

function ccConsumables:HealHalfHeart()
    player:AddHearts(numberOfHearts)
end

function ccConsumables:DamageHalfHeart()
    player:TakeDamage(numberOfHearts, DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 0 )
end

function ccConsumables:AddCoin()
    player:AddCoins(numberOfCoins)
end

function ccConsumables:RemoveCoin()
    player:AddCoins(-numberOfCoins);
end

function ccConsumables:AddBomb()
    player:AddBombs(numberOfBombs)
end

function ccConsumables:RemoveBomb()
    player:AddBombs(-numberOfBombs)
end

function ccConsumables:AddGoldenBomb()
    player:AddGoldenBomb()
end

function ccConsumables:RemoveGoldenBomb()
    player:RemoveGoldenBomb()
end

function ccConsumables:AddKey()
    player:AddKeys(numberofKeys)
end

function ccConsumables:RemoveKey()
    player:AddKeys(-numberofKeys)
end

function ccConsumables:AddGoldenKey()
    player:AddGoldenKey()
end

function ccConsumables:RemoveGoldenKey()
    player:RemoveGoldenKey()
end

function ccConsumables:UseRandomCard()
    player:UseCard(math.random(Card.NUM_CARDS))
end

function ccConsumables:UseRandomPill()
    player:UsePill(math.random(PillEffect.NUM_PILL_EFFECTS),
    math.random(PillColor.NUM_PILLS))
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