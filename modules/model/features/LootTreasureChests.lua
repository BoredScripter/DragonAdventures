local treasureF = workspace.Interactions.Nodes.Treasure

local RT = __require("model.utils.RequestTask")
local CU = __require("model.utils.CharUtils")

function findTreasureChest()
    for i,v in pairs(treasureF:GetChildren()) do
        local model = v:FindFirstChildWhichIsA("Model")
        if model and not model.PrimaryPart.Dead.Value then
            return model
        end
    end
end 

-- test
local root = game.Players.LocalPlayer.Character.PrimaryPart

return function()
    while _G.LootTreasureChests do
        local curChest = findTreasureChest()
        if not curChest then
            task.wait(1)
            continue
        end

        RT.Request("Loot treasure Chest", 5, function()
            CU.UseChar(true, function(char)
                -- root.CFrame = curChest.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                char:PivotTo(curChest.PrimaryPart.CFrame + Vector3.new(0, 5, 0))
                task.wait(.1)
                curChest.PrimaryPart.Dead.Value = true; -- its dead and i get loot
                task.wait(1)
            end)
        end)

        task.wait()
    end
end