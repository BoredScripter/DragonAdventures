return function (self, value)
    _G.Godmode = value

    __require("model.features.Godmode")()
end