local DragonHandler = {}

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

    soundRemote:FireServer("Breath", "Mobs", targetMob)
end

function DragonHandler.Bite(dragon, targetMob)
    local remotes = safeGet(dragon, "Remotes")
    if not remotes then return end

    local soundRemote = safeGet(remotes, "PlaySoundRemote")
    if not soundRemote then return end

    soundRemote:FireServer("Bite", {{"Mobs", targetMob}})
end

return DragonHandler
