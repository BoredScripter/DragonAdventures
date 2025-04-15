-- Auto-generated script

local __modules = {}
local __require = function(name)
    local mod = __modules[name]
    if mod then
        local ok, result = xpcall(mod, function(err)
            return debug.traceback("Error in module '" .. name .. "':\n" .. tostring(err), 2)
        end)
        if not ok then
            error(result, 2)
        end
        return result
    else
        error("Module '" .. name .. "' not found.", 2)
    end
end

__modules["controller.AutomobFarm"] = function()
return function (self, value)
    _G.AutomobFarm = value

    __require("model.features.AutomobFarm")()
end
end

__modules["controller.AutosellMobLoot"] = function()
return function (self, value)
    _G.AutosellMobLoot = value

    __require("model.features.AutosellMobLoot")()
end
end

__modules["controller.Godmode"] = function()
return function (self, value)
    _G.Godmode = value

    __require("model.features.Godmode")()
end
end

__modules["model.features.AutomobFarm"] = function()

return function ()
    local plr = game.Players.LocalPlayer
    local char = plr.Character
    local root = char.PrimaryPart

    local DH = __require('model.utils.DragonHandler')
    local MH = __require('model.utils.MonsterHandler')

    while _G.AutomobFarm do
        local mob = MH.FindMob()
        if mob then
            root.CFrame = mob.CFrame
            for _, dragon in pairs(char.Dragons:GetChildren()) do
                DH.FireBreath(dragon, mob)
                DH.Bite(dragon, mob)
            end
        end
        task.wait()
    end 
end
end

__modules["model.features.AutosellMobLoot"] = function()
local mobLootToSell = {"Meat", "Bacon", "Ashes"}

-- Modules
local RemoteMiddleman = __require("model.utils.RemoteMiddleman")

local Sonar = require(game.ReplicatedStorage:WaitForChild('Sonar'))
local PlayerWrapper = Sonar('PlayerWrapper')
local Client = PlayerWrapper.GetClient()

local function GetAmount(item)
    return Client.PlayerData.Resources[item].Value
end

return function ()
    while _G.AutosellMobLoot do
        local remote = game:GetService("ReplicatedStorage"):WaitForChild('Remotes').SellItemRemote
        for _, lootStr in pairs(mobLootToSell) do
            
            local amount = GetAmount(lootStr)
            if amount <= 0 then continue end

            RemoteMiddleman.RequestFire(remote, true, function()
                remote:FireServer({
                    ItemName = lootStr,
                    Amount = amount,
                })
            end)
            print("Selling", lootStr, "Amount:", amount)

        end
         
        task.wait(10)
    end
end
end

__modules["model.features.Godmode"] = function()

local loaded = false;

return function ()
    -- Make sure we dont load this code again under
    if loaded then return end
    loaded = true;

    local ReplicatedStorage = game:GetService('ReplicatedStorage')
    local targetRemote = ReplicatedStorage
        :WaitForChild('Remotes')
        :WaitForChild('MobProjectileDamageRemote')

    local oldNamecall
    oldNamecall = hookmetamethod(game, '__namecall', function(self, ...)
        local method = getnamecallmethod()

        if self == targetRemote and method == 'FireServer' and _G.Godmode then
            warn('Blocked MobProjectileDamageRemote:FireServer call.')
            return -- block the call entirely
        end

        return oldNamecall(self, ...)
    end)
end
end

__modules["model.Globals"] = function()
_G.AutomobFarm = _G.AutomobFarm or _G.AutoExec or false
_G.Godmode = _G.Godmode or _G.AutoExec or false
_G.AutosellMobLoot = _G.AutosellMobLoot or false

-- make sure game is loaded maybe later add load check
if _G.AutoExec then task.wait(10) end
end

__modules["model.utils.DragonHandler"] = function()
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

end

__modules["model.utils.MonsterHandler"] = function()
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
end

__modules["model.utils.RemoteMiddleman"] = function()
local RemoteMiddleman = {}

local cooldownTime = 0
local debounce = false
local queueList = {}

-- Internal function to process the next item in the queue
local function processQueue()
    if debounce or #queueList == 0 then
        return
    end

    debounce = true
    local nextCallback = table.remove(queueList, 1)
    task.spawn(nextCallback)

    task.delay(cooldownTime, function()
        debounce = false
        processQueue() -- Automatically process the next item
    end)
end

function RemoteMiddleman.RequestFire(remote, queue, callback)
    if not debounce then

        debounce = true
        task.spawn(callback)

        task.delay(cooldownTime, function()
            debounce = false
            processQueue()
        end)

        return true
    elseif queue then
        print("Request denied but is queable so adding to queulist", remote)
        table.insert(queueList, callback)
        return true
    else
        return false
    end
end

return RemoteMiddleman

end

__modules["view.View"] = function()
local function CallController(self, value)
    spawn(function()
        __require("controller."..self.Label)(self, value)
    end)
end

return function ()
    local InsertService = game:GetService('InsertService')

    local ReGui = loadstring(
        game:HttpGet(
            'https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'
        )
    )()
    local PrefabsId = 'rbxassetid://' .. ReGui.PrefabsId

    --// Declare the Prefabs asset
    ReGui:Init({
        Prefabs = InsertService:LoadLocalAsset(PrefabsId),
    })

    local Window = ReGui:Window({
        Title = 'Nigga this is crazy',
        Size = UDim2.fromOffset(500, 500),
    })

    Window:Checkbox({
        Value = _G.AutomobFarm,
        Label = "AutomobFarm",
        Callback = CallController
    })

    Window:Checkbox({
        Value = _G.Godmode,
        Label = "Godmode",
        Callback = CallController
    })

    Window:Checkbox({
        Value = _G.AutosellMobLoot,
        Label = "AutosellMobLoot",
        Callback = CallController
    })

end


end

-- Entry Point
-- Init anti afk
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
print("Anti afk on for pc")

-- modules
local Globals = __require("model.Globals")
local View = __require("view.View")


View()
