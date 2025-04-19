local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local CharUtil = {}

function CharUtil.UseChar(usedForTP, callback)
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

    if usedForTP then
        root.Anchored = true
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end

    callback(character)

    if usedForTP then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.Anchored = false

    end
end

return CharUtil
