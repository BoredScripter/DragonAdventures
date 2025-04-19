return function (self, value)
    _G.AutoCollectCoins = value

    __require("model.features.AutoCollectCoins")()
end