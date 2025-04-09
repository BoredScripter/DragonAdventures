local MonsterHandler = {}

function MonsterHandler.FindMob()
    for i,v in pairs(workspace:WaitForChild("MobFolder"):GetChildren()) do
        local child = v:FindFirstChildWhichIsA("BasePart")
        if child and not child.Dead.Value then
            return child
        end 
    end

    return nil
end

return MonsterHandler