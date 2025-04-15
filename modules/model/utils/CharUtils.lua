local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local CharUtil = {}

function CharUtil.UseChar(callback)
    if not LocalPlayer then
        warn("[CharUtil] LocalPlayer not available.")
        return
    end

    local character = LocalPlayer.Character
    if not character then
        warn("[CharUtil] Character not loaded.")
        return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        warn("[CharUtil] Character is dead or missing Humanoid.")
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then
        warn("[CharUtil] Missing HumanoidRootPart.")
        return
    end

    callback(character)
end

return CharUtil
