return function (self, value)
    _G.LootTreasureChests = value

    __require("model.features.LootTreasureChests")()
end