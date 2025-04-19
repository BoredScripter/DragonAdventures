local DragonHandler = {}

-- Modules
local RemoteMiddleman = __require("model.utils.RemoteMiddleman")

local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

local function safeGet(child, name)
    local success, result = pcall(function()
        return child:FindFirstChild(name)
    end)
    if success and result then
        return result
    else
        return nil
    end
end

function DragonHandler.FireBreath(dragon, target, type) -- type "Mobs" or "Destructibles"
    local remotes = safeGet(dragon, "Remotes")
    if not remotes then return end

    local soundRemote = safeGet(remotes, "PlaySoundRemote")
    if not soundRemote then return end

    RemoteMiddleman.RequestFire(soundRemote, false, function()
        soundRemote:FireServer("Breath", type, target)
    end)
end

function DragonHandler.Bite(dragon, target, type)
    local remotes = safeGet(dragon, "Remotes")
    if not remotes then return end

    local soundRemote = safeGet(remotes, "PlaySoundRemote")
    if not soundRemote then return end

    RemoteMiddleman.RequestFire(soundRemote, false, function()
        soundRemote:FireServer("Bite", {{type, target}})
    end)
end

function DragonHandler.EquipDragon()
    Remotes:WaitForChild("EquipDragonRemote"):InvokeServer("1")    
end

return DragonHandler
