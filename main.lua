local Yisz = RegisterMod("Yisz", 1)
local Game = Game()
local isDebugging = true

Yisz.Badman = Isaac.GetItemIdByName("Badman")

function Yisz:onCacheEval(player, flag)
    if player:HasCollectible(Yisz.Badman) then
        if flag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + 2;
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
    end
end
Yisz:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Yisz.onUpdate)