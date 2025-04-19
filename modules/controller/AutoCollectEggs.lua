return function (self, value)
    _G.AutoCollectEggs = value

    __require("model.features.AutoCollectEggs")()
end