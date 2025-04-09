local v5 = require(game.ReplicatedStorage:WaitForChild('Sonar'))
local v23 = v5('PlayerWrapper').GetClient()
local v25 = v23.SettingsFolder:WaitForChild('CurrentEggs') -- why does it exist
local eggs = workspace.Interactions.Nodes.Eggs
local root = game.Players.LocalPlayer.Character.PrimaryPart

function findEgg()
	for i, EggObject in pairs(v25:GetChildren()) do
		return EggObject
	end
end

_G.Testing = true
while _G.Testing do
	local EggObject = findEgg()
	root.CFrame = eggs:FindFirstChild(tostring(EggObject.Value)).Nest.Value
	game.ReplicatedStorage.Remotes.CollectEggRemote:InvokeServer(
		tostring(EggObject.Value)
	)
	task.wait()
end
