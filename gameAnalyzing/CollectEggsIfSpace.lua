local assetToName = {
    ["rbxassetid://6860848612"] = "RedEggBoy"
}

setthreadidentity(2) -- 2 = LocalScript context
local v5 = require(game.ReplicatedStorage:WaitForChild('Sonar'))
local v23 = v5('PlayerWrapper').GetClient()
local v25 = v23.SettingsFolder:WaitForChild('CurrentEggs') -- why does it exist
local eggs = workspace.Interactions.Nodes.Eggs
local root = game.Players.LocalPlayer.Character.PrimaryPart

local function roundVector3(v)
    return Vector3.new(
        math.round(v.X),
        math.round(v.Y),
        math.round(v.Z)
    )
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

                local eggValue = v23.PlayerData.Eggs:FindFirstChild(eggName)
                if eggValue.Value >= 10 then
                    return false
                end
            end
        end
    end
    return true
end

function findEgg()
	for i, EggValue in pairs(v25:GetChildren()) do
        if EggValue.Name == "ClueEgg" then continue end

        local nestValue = eggs:FindFirstChild(tostring(EggValue.Value)).Nest.Value
	    if InvSpaceForEgg(nestValue) then
		    return nestValue, EggValue.Value
        end
	end
    return
end

_G.Testing = false
local maxTimes = 1
local curCount = 0
while _G.Testing do
    if curCount == maxTimes then break end

	local nestValue, eggValue = findEgg()
    if not nestValue then
        task.wait(1)
        continue
    end

    -- root.CFrame = nestValue + Vector3.new(0, 5, 0)
    char:PivotTo(nestValue + Vector3.new(0, 5, 0))
    task.wait(.1)
	game.ReplicatedStorage.Remotes.SetCollectEggRemote:InvokeServer(tostring(eggValue))
	game.ReplicatedStorage.Remotes.CollectEggRemote:InvokeServer(tostring(eggValue))
	curCount = curCount + 1
    task.wait(.1)
end

