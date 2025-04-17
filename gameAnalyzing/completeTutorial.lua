local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local function setStage(stage)
	print("[Tutorial] Set stage:", stage)
	Remotes:WaitForChild("SetTutorialStageRemote"):InvokeServer(stage)
    task.wait(.5)
end

local function postStage(stage)
	print("[Tutorial] Post stage:", stage)
	Remotes:WaitForChild("PostTutorialStageRemote"):FireServer(stage)
    task.wait(.5)
end

-- Progression steps (clean order)
postStage("DragonControls")
setStage("FindingEggs")
postStage("InteractWithEgg")
setStage("HatchingEggs")
postStage("MakeDragonFly")
postStage("NavigatedToPlot")
postStage("PlacedTutorialEgg")
postStage("HatchedTutorialEgg")
postStage("EquippedBabyDragon")
postStage("TouchedTutorialExit")
postStage("LeftPlot")
setStage("Complete")

print("[Tutorial] Tutorial automation done.")

print("Completeing tutorial locally")
setthreadidentity(2)
local tutorialModule = game:GetService("ReplicatedStorage"):WaitForChild("_replicationFolder"):FindFirstChild("TutorialClient")
local TutorialClient = require(tutorialModule)
setthreadidentity(8)
TutorialClient.EndPrimaryTutorial()
TutorialClient.HasCompletedContextual()
TutorialClient.TweenOutDialogue()
