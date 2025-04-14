local DragonHandler = {}

-- Modules
local RemoteMiddleman = __require("model.utils.RemoteMiddleman")

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

function DragonHandler.FireBreath(dragon, targetMob)
    local remotes = safeGet(dragon, "Remotes")
    if not remotes then return end

    local soundRemote = safeGet(remotes, "PlaySoundRemote")
    if not soundRemote then return end

    RemoteMiddleman.RequestFire(soundRemote, false, function()
        soundRemote:FireServer("Breath", "Mobs", targetMob)
    end)
end

function DragonHandler.Bite(dragon, targetMob)
    local remotes = safeGet(dragon, "Remotes")
    if not remotes then return end

    local soundRemote = safeGet(remotes, "PlaySoundRemote")
    if not soundRemote then return end

    RemoteMiddleman.RequestFire(soundRemote, false, function()
        soundRemote:FireServer("Bite", {{"Mobs", targetMob}})
    end)
end

return DragonHandler
