local treasureF = workspace.Interactions.Nodes.Treasure

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

while _G.LootTreasureChests do
    local curChest = findTreasureChest()
    if not curChest then
        task.wait(1)
        continue
    end

    -- root.CFrame = curChest.PrimaryPart.CFrame
    char:PivotTo(curChest.PrimaryPart.CFrame)

    curChest.PrimaryPart.Dead.Value = true; -- its dead and i get loot
    task.wait()
end