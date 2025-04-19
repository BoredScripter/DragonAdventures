-- Weak table acts like external storage for _ControllerKey
local controllerMap = setmetatable({}, { __mode = "k" })

local function CallController(self, value)
	local key = controllerMap[self]
	if not key then
		warn("[Controller] No controller key bound for:", self.Label)
		return
	end
	spawn(function()
		__require("controller." .. key)(self, value)
	end)
end

local function bindController(component, controllerKey)
	controllerMap[component] = controllerKey
	CallController(component, _G[controllerKey])
	return component
end

return function ()
	local InsertService = game:GetService('InsertService')

	local ReGui = loadstring(
		game:HttpGet(
			'https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'
		)
	)()
	local PrefabsId = 'rbxassetid://' .. ReGui.PrefabsId

	ReGui:Init({
		Prefabs = InsertService:LoadLocalAsset(PrefabsId),
	})

	local Window = ReGui:Window({
		Title = 'Nigga this is crazy',
		Size = UDim2.fromOffset(500, 500),
	})

	bindController(Window:Checkbox({
		Value = _G.AutomobFarm,
		Label = "Auto mob Farm",
		Callback = CallController
	}), "AutomobFarm")

	bindController(Window:Checkbox({
		Value = _G.AutoCollectEggs,
		Label = "Auto Collect Eggs",
		Callback = CallController
	}), "AutoCollectEggs")

    bindController(Window:Checkbox({
		Value = _G.LootTreasureChests,
		Label = "Loot Treasure Chests",
		Callback = CallController
	}), "LootTreasureChests")

    bindController(Window:Checkbox({
		Value = _G.AutoFarmResource,
		Label = "Auto Farm Resource Nodes",
		Callback = CallController
	}), "AutoFarmResource")

	bindController(Window:Checkbox({
		Value = _G.Godmode,
		Label = "Godmode",
		Callback = CallController
	}), "Godmode")

	bindController(Window:Checkbox({
		Value = _G.AutosellMobLoot,
		Label = "Auto Sell MobLoot",
		Callback = CallController
	}), "AutosellMobLoot")

    bindController(Window:Checkbox({
		Value = _G.AutoCollectCoins,
		Label = "Auto Collect Coins",
		Callback = CallController
	}), "AutoCollectCoins")

    Window:Label({
        Text = ""
    })

	bindController(Window:Button({
		Text = "Complete Tutorial",
		Callback = CallController
	}), "CompleteTutorial")

    Window:Label({
        Text = "This will reload the game..."
    })
end
