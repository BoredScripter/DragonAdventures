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