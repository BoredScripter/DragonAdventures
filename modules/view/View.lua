local function CallController(self, value)
    spawn(function()
        __require("controller."..self.Label)(self, value)
    end)
end

return function ()
    local InsertService = game:GetService('InsertService')

    local ReGui = loadstring(
        game:HttpGet(
            'https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'
        )
    )()
    local PrefabsId = 'rbxassetid://' .. ReGui.PrefabsId

    --// Declare the Prefabs asset
    ReGui:Init({
        Prefabs = InsertService:LoadLocalAsset(PrefabsId),
    })

    local Window = ReGui:Window({
        Title = 'Nigga this is crazy',
        Size = UDim2.fromOffset(500, 500),
    })

    Window:Checkbox({
        Value = _G.AutomobFarm,
        Label = "AutomobFarm",
        Callback = CallController
    })

    Window:Checkbox({
        Value = _G.Godmode,
        Label = "Godmode",
        Callback = CallController
    })

    Window:Checkbox({
        Value = _G.AutosellMobLoot,
        Label = "AutosellMobLoot",
        Callback = CallController
    })

end

