return function (self, value)
    _G.AutoFarmResource = value

    __require("model.features.AutoFarmResource")()
end