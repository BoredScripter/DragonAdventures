return function (self, value)
    _G.AutosellMobLoot = value

    __require("model.features.AutosellMobLoot")()
end