return function (self, value)
    _G.AutomobFarm = value

    __require("model.features.AutomobFarm")()
end