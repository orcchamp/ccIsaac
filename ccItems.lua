local ccItems = {}

-- internal
function ccItems:GiveItem(item)
    player:AddCollectible( item,0, false)
end

--internal
function ccItems:TakeItem(item)
    player:RemoveCollectible(item)
end

function ccItems:GiveMissingNo()
    ccItems:GiveItem(CollectibleType.COLLECTIBLE_MISSING_NO)
end

function ccItems:GiveSoyMilk()
    ccItems:GiveItem(CollectibleType.COLLECTIBLE_SOY_MILK)
end

function ccItems:GiveTheMind()
    ccItems:GiveItem(CollectibleType.COLLECTIBLE_MIND)
end

function ccItems:GiveBrimstone()
    ccItems:GiveItem(CollectibleType.COLLECTIBLE_BRIMSTONE)
end

function ccItems:GiveKnife()
    ccItems:GiveItem(CollectibleType.COLLECTIBLE_MOMS_KNIFE)
end

function ccItems:GivePoly()
    ccItems:GiveItem(CollectibleType.COLLECTIBLE_POLYPHEMUS)
end

function ccItems:GiveSacredHeart()
    ccItems:GiveItem(CollectibleType_SACRED_HEART)
end

function ccItems:RemoveMissingNo()
    ccItems:TakeItem(CollectibleType.COLLECTIBLE_MISSING_NO)
end

function ccItems:RemoveSoyMilk()
    ccItems:TakeItem(CollectibleType.COLLECTIBLE_SOY_MILK)
end

function ccItems:RemoveTheMind()
    ccItems:TakeItem(CollectibleType.COLLECTIBLE_MIND)
end

function ccItems:RemoveBrimstone()
    ccItems:TakeItem(CollectibleType.COLLECTIBLE_BRIMSTONE)
end

function ccItems:RemoveKnife()
    ccItems:TakeItem(CollectibleType.COLLECTIBLE_MOMS_KNIFE)
end

function ccItems:RemovePoly()
    ccItems:TakeItem(CollectibleType.COLLECTIBLE_POLYPHEMUS)
end

function ccItems:RemoveSacredHeart()
    ccItems:TakeItem(CollectibleType_SACRED_HEART)
end

--When adding a new function add the mapping of Crowd control code to function here
ccItems.methods = {
    give_missing_no = ccItems.GiveMissingNo,
    give_soy_milk = ccItems.GiveSoyMilk,
    give_the_mind = ccItems.GiveTheMind,
    give_brimstone = ccItems.GiveBrimstone,
    give_knife = ccItems.GiveKnife,
    give_poly = ccItems.GivePoly,
    give_sacred_heart = ccItems.GiveSacredHeart,
    remove_missing_no = ccItems.RemoveMissingNo,
    remove_soy_milk = ccItems.RemoveSoyMilk,
    remove_the_mind = ccItems.RemoveTheMind,
    remove_brimstone = ccItems.RemoveBrimstone,
    remove_knife = ccItems.RemoveKnife,
    remove_poly = ccItems.RemovePoly,
    remove_sacred_heart = ccItems.RemoveSacredHeart
}

return ccItems