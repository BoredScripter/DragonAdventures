-- Auto-generated script

local __modules = {}
local __loaded = {} -- cache for already required modules

local __require = function(name)
    if __loaded[name] then
        return __loaded[name]
    end

    local mod = __modules[name]
    if mod then
        local ok, result = xpcall(mod, function(err)
            return debug.traceback("Error in module '" .. name .. "':\n" .. tostring(err), 2)
        end)
        if not ok then
            error(result, 2)
        end
        __loaded[name] = result
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

__modules["controller.CompleteTutorial"] = function()
return function (self)
    if _G.Client.InTutorial then
        __require("model.utils.CompleteTutorial")()
    end
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
    local DH = __require('model.utils.DragonHandler')
    local MH = __require('model.utils.MonsterHandler')
    local RT = __require('model.utils.RequestTask')
    local CU = __require('model.utils.CharUtils')

    while _G.AutomobFarm do
        local mob = MH.FindMob()
        if mob then
            CU.UseChar(function(char)
                local root = char.HumanoidRootPart

                RT.Request("TP To Mob and Damage", 1, function()
                    root.CFrame = mob.CFrame
                    for _, dragon in pairs(char.Dragons:GetChildren()) do
                        DH.FireBreath(dragon, mob)
                        DH.Bite(dragon, mob)
                    end
                end)
            end)

        end
        task.wait()
    end 
end
end

__modules["model.features.AutosellMobLoot"] = function()
local mobLootToSell = {"Meat", "Bacon", "Ashes"}

-- Modules
local RemoteMiddleman = __require("model.utils.RemoteMiddleman")
local RT = __require('model.utils.RequestTask')
local CU = __require('model.utils.CharUtils')


local Client = _G.Client

local sellPart = workspace:WaitForChild("Interactions").GeneralStore.BillboardPart

local function GetAmount(item)
    return Client.PlayerData.Resources[item].Value
end

local function shouldSell()
    local sell = false
    for _, lootStr in pairs(mobLootToSell) do
        if GetAmount(lootStr) >= 10000 then
            return true
        end
    end

    return sell
end

return function ()
    while _G.AutosellMobLoot do
        if shouldSell() then
            CU.UseChar(function(char)
                local root = char.HumanoidRootPart

                RT.Request("Sell mob loot", 10, function()
                    -- Tp char to CFrame.new(1,1,1)
                    root.CFrame = sellPart.CFrame
                    task.wait(0.5)

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
                    task.wait(1)
                end)
            end)
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
_G.AutosellMobLoot = _G.AutosellMobLoot or _G.AutoExec or false

-- make sure game is loaded maybe later add load check
if _G.AutoExec then 
    task.wait(10) 
end

-- setup stuff
local old = getthreadidentity()
setthreadidentity(2) -- 2 = LocalScript context
local Sonar = require(game.ReplicatedStorage:WaitForChild('Sonar'))
local PlayerWrapper = Sonar('PlayerWrapper')
_G.Client = PlayerWrapper.GetClient()
setthreadidentity(old)

-- if auto exec on and havnt completed tutorial then complete it
if _G.AutoExec and _G.Client.InTutorial then
    __require("model.utils.CompleteTutorial")()
end
end

__modules["model.utils.CharUtils"] = function()
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

end

__modules["model.utils.CompleteTutorial"] = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local function fire(stage) Remotes.PostTutorialStageRemote:FireServer(stage) end
local function set(stage) Remotes.SetTutorialStageRemote:InvokeServer(stage) end

return function()
    -- Tutorial progression
    fire("DragonControls")
    set("FindingEggs")
    fire("InteractWithEgg")
    set("HatchingEggs")
    fire("MakeDragonFly")
    fire("NavigatedToPlot")
    fire("PlacedTutorialEgg")
    fire("HatchedTutorialEgg")
    fire("EquippedBabyDragon")
    fire("TouchedTutorialExit")
    fire("LeftPlot")
    set("Complete")
    print("[Tutorial] Done on server")

    -- Reload game
    game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
end


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

__modules["model.utils.RequestTask"] = function()
local RequestTask = {}

local curTask = nil
local taskIdCounter = 0
local completedTasks = {}

-- Task factory
local function CreateTask(name, priority)
    taskIdCounter += 1
    return {
        id = taskIdCounter,
        name = name,
        priority = priority,
        abandoned = false
    }
end

function RequestTask.Request(name, priority, callback)
    if not curTask or priority > curTask.priority then
        if curTask then
            curTask.abandoned = true
        end

        local newTask = CreateTask(name, priority)

        curTask = newTask

        task.spawn(function()
            -- new task is also the self task under here since curTask could have been changed in runtime while under running
            local success, err = xpcall(callback, debug.traceback)

            if success and not newTask.abandoned and curTask.id == newTask.id then
                completedTasks[#completedTasks + 1] = newTask.name
                curTask = nil
            elseif not success then
                warn("[RequestTask] Error in task '" .. newTask.name .. "': " .. err)
                if curTask and curTask.id == newTask.id then
                    curTask = nil
                end
            end
        end)
    end
end

function RequestTask.GetCompletedTasks()
    return completedTasks
end

function RequestTask.GetCurrentTask()
    return curTask
end

return RequestTask

end

__modules["view.View"] = function()
-- Weak table acts like external storage for _ControllerKey
local controllerMap = setmetatable({}, { __mode = "k" })

local function bindController(component, controllerKey)
	controllerMap[component] = controllerKey
	return component
end

local function CallController(self, value)
	local key = controllerMap[self]
	if not key then
		warn("[Controller] No controller key bound for:", self.Name)
		return
	end
	spawn(function()
		__require("controller." .. key)(self, value)
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

	ReGui:Init({
		Prefabs = InsertService:LoadLocalAsset(PrefabsId),
	})

	local Window = ReGui:Window({
		Title = 'Nigga his is crazy',
		Size = UDim2.fromOffset(500, 500),
	})

	bindController(Window:Checkbox({
		Value = _G.AutomobFarm,
		Label = "Automob Farm",
		Callback = CallController
	}), "AutomobFarm")

	bindController(Window:Checkbox({
		Value = _G.Godmode,
		Label = "Godmode",
		Callback = CallController
	}), "Godmode")

	bindController(Window:Checkbox({
		Value = _G.AutosellMobLoot,
		Label = "Autosell MobLoot",
		Callback = CallController
	}), "AutosellMobLoot")

    Window:Label({
        Text = ""
    })

	bindController(Window:Button({
		Text = "Complete Tutorial",
		Callback = CallController
	}), "CompleteTutorial")

    Window:Label({
        Text = "This will reload the game..."
    })
end

end

-- Entry Point
local Players = game:GetService("Players")
while not Players.LocalPlayer do
    task.wait()
end

-- Init anti afk
local vu = game:GetService("VirtualUser")
Players.LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
print("Anti afk on for pc")

-- modules
local Globals = __require("model.Globals")
local View = __require("view.View")

View()
