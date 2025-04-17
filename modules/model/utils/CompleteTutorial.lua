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

