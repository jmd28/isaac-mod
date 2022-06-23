local Yisz = RegisterMod("Yisz", 1)

local Game = Game()
local isDebugging = true

Yisz.Badman = Isaac.GetItemIdByName("Badman")
Yisz.Dollop = Isaac.GetItemIdByName("Dollop")

---comment
---@param player EntityPlayer
---@param flag integer
function Yisz:onCacheEval(player, flag)
    -- badman logic
    if player:HasCollectible(Yisz.Badman) then
        if flag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + 2;
        end

    end

    -- dollop logic
    if player:HasCollectible(Yisz.Dollop) then
        if flag == CacheFlag.CACHE_FLYING then
            if math.random(0,1) == 1 then
                player.CanFly = true
            else
                player:Kill()
            end
        elseif flag == CacheFlag.CACHE_DAMAGE then
            player.Damage = (player.Damage + 0.5) * 1.5;
        end
    end
end
Yisz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Yisz.onCacheEval)

function Yisz:onUpdate(player)
    if Game:GetFrameCount() == 1 and isDebugging then
        Isaac.DebugString("!  Here comes da Badman  !")
        Isaac.Spawn(
            EntityType.ENTITY_PICKUP,
            PickupVariant.PICKUP_COLLECTIBLE,
            Yisz.Badman,
            Vector(320,300),
            Vector(0,0),
            nil
        )
        Isaac.Spawn(
            EntityType.ENTITY_PICKUP,
            PickupVariant.PICKUP_COLLECTIBLE,
            Yisz.Dollop,
            Vector(370,350),
            Vector(0,0),
            nil
        )
    end
end
Yisz:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Yisz.onUpdate)