local ccItems = {}

local responseCode = require("tcpResponseCode")

-- internal
function ccItems.GiveItem(item)
    if item == nil then
        return responseCode.failure, "Item does not exist"
    end
    if player:HasCollectible(item) then
        return responseCode.failure, "User Already Has Item"
    end
	--player:QueueItem(Isaac.GetItemConfig():GetCollectible(item))
	--player:AnimateCollectible(item, "Pickup", "PlayerPickupSparkle")
    player:AddCollectible(item, 0, true)
	
    return responseCode.success
end

--internal
function ccItems.TakeItem(item)
    if not player:HasCollectible(item) then
        return responseCode.failure, "User Doesn't Have Item To Remove"
    end
    player:RemoveCollectible(item)
    return responseCode.success
end

function ccItems.GiveRandomItem()
    return ccItems.GiveItem(1 + rng:RandomInt(CollectibleType.NUM_COLLECTIBLES))
end

function ccItems.GiveMissingNo()
    return ccItems.GiveItem(CollectibleType.COLLECTIBLE_MISSING_NO)
end


function ccItems.GiveSoyMilk()
    return ccItems.GiveItem(CollectibleType.COLLECTIBLE_SOY_MILK)
end

function ccItems.GiveTheMind()
    return ccItems.GiveItem(CollectibleType.COLLECTIBLE_MIND)
end

function ccItems.GiveBrimstone()
    return ccItems.GiveItem(CollectibleType.COLLECTIBLE_BRIMSTONE)
end

function ccItems.GiveKnife()
    return ccItems.GiveItem(CollectibleType.COLLECTIBLE_MOMS_KNIFE)
end

function ccItems.GivePoly()
    return ccItems.GiveItem(CollectibleType.COLLECTIBLE_POLYPHEMUS)
end

function ccItems.GiveSacredHeart()
    return ccItems.GiveItem(CollectibleType.COLLECTIBLE_SACRED_HEART)
end

function ccItems.RemoveRandomItem()
	if player:GetCollectibleCount() < 1 then
		return responseCode.failure, "User has no items"
	else
		local colletibles = {}
		for i=1, CollectibleType.NUM_COLLECTIBLES do
			if player:HasCollectible(i) then
				table.insert(colletibles, i)
			end
		end
        if active_flight == true then
            colletibles[CollectibleType.COLLECTIBLE_TRANSCENDENCE] = nil
            if player:GetCollectibleCount() == 1 then
                return responseCode.failure, "User has no items to remove"
            end
        end
           
		return ccItems.TakeItem(colletibles[1 + rng:RandomInt(player:GetCollectibleCount())])
	end
    return responseCode.failure, "Failed to select item"
end

function ccItems.RemoveMissingNo()
    return ccItems.TakeItem(CollectibleType.COLLECTIBLE_MISSING_NO)
end

function ccItems.RemoveSoyMilk()
    return ccItems.TakeItem(CollectibleType.COLLECTIBLE_SOY_MILK)
end

function ccItems.RemoveTheMind()
    return ccItems.TakeItem(CollectibleType.COLLECTIBLE_MIND)
end

function ccItems.RemoveBrimstone()
    return ccItems.TakeItem(CollectibleType.COLLECTIBLE_BRIMSTONE)
end

function ccItems.RemoveKnife()
    return ccItems.TakeItem(CollectibleType.COLLECTIBLE_MOMS_KNIFE)
end

function ccItems.RemovePoly()
    return ccItems.TakeItem(CollectibleType.COLLECTIBLE_POLYPHEMUS) 
end

function ccItems.RemoveSacredHeart()
    return ccItems.TakeItem(CollectibleType.COLLECTIBLE_SACRED_HEART)
end

--New

function ccItems.GiveOneUp()
	if CollectibleType.COLLECTIBLE_1UP ~= nil then -- for afterbirth
		return ccItems.GiveItem(CollectibleType.COLLECTIBLE_1UP)
	else
		return ccItems.GiveItem(CollectibleType.COLLECTIBLE_ONE_UP)
	end
end

function ccItems.RemoveOneUp()
    if CollectibleType.COLLECTIBLE_1UP ~= nil then -- for afterbirth
		return ccItems.TakeItem(CollectibleType.COLLECTIBLE_1UP)
	else
		return ccItems.TakeItem(CollectibleType.COLLECTIBLE_ONE_UP)
	end
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
    remove_sacred_heart = ccItems.RemoveSacredHeart,
	remove_random_item = ccItems.RemoveRandomItem,
	give_random_item = ccItems.GiveRandomItem,
	give_one_up = ccItems.GiveOneUp,
	remove_one_up = ccItems.RemoveOneUp
}

return ccItems