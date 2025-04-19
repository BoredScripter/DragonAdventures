
local assetToName = {
    ["rbxassetid://6860848612"] = "RedEggBoy"
}

local RT = __require('model.utils.RequestTask')

local Client = _G.Client
local CurrentEggs = Client.SettingsFolder:WaitForChild('CurrentEggs')
local eggs = workspace.Interactions.Nodes.Eggs
local root = game.Players.LocalPlayer.Character.PrimaryPart

local function roundVector3(v)
    return Vector3.new(
        math.round(v.X),
        math.round(v.Y),
        math.round(v.Z))
end

function InvSpaceForEgg(nestValue)
    for _, model in pairs(eggs:WaitForChild("ActiveNodes"):GetChildren()) do
        if roundVector3(model.Base.CFrame.Position) == roundVector3(nestValue.Position) then
            if model:FindFirstChild("EggModel") then
                local eggName = assetToName[model.EggModel.Egg.MeshId]
                if not eggName then
                    warn("[EGG NOT MAPPED] MeshID IS NOT mapped to an egg string... CANT CHECK INV SPACE FOR THE EGG THEN | meshid:", model.EggModel.Egg.MeshId, "path:", model.EggModel.Egg:GetFullName())
                    return false

                end

                local eggValue = Client.PlayerData.Eggs:FindFirstChild(eggName)
                if eggValue.Value >= 10 then
                    return false
                end
            end
        end
    end
    return true
end

function findEgg()
	for i, EggValue in pairs(CurrentEggs:GetChildren()) do
        if EggValue.Name == "ClueEgg" then continue end

        local nestValue = eggs:FindFirstChild(tostring(EggValue.Value)).Nest.Value
	    if InvSpaceForEgg(nestValue) then
		    return nestValue, EggValue.Value
        end
	end
    return
end

return function ()
    while _G.AutoCollectEggs do
        local nestValue, eggValue = findEgg()
        if not nestValue then
            task.wait(1)
            continue
        end

        RT.Request("Collect egg", 5, function()
            -- root.CFrame = nestValue + Vector3.new(0, 5, 0)
            char:PivotTo(nestValue + Vector3.new(0, 5, 0))
            task.wait(.1)
            game.ReplicatedStorage.Remotes.SetCollectEggRemote:InvokeServer(tostring(eggValue))
            game.ReplicatedStorage.Remotes.CollectEggRemote:InvokeServer(tostring(eggValue))
        end)
        task.wait(.1)
    end
end