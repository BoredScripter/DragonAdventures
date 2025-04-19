local DH = __require('model.utils.DragonHandler')
local RT = __require("model.utils.RequestTask")
local CU = __require("model.utils.CharUtils")

local resources = workspace:WaitForChild("Interactions"):WaitForChild("Nodes"):WaitForChild("Resources")
local plr = game.Players.LocalPlayer

local function findResourceNode()
	for i,v in pairs(resources:GetChildren()) do
		if v.Name == "LargeResourceNode" and v.BillboardPart.Health.Value > 0 then
			return v.BillboardPart
		end
	end
end

return function()
	local toucherConnection
	if _G.AutoFarmResource then
		-- setup auto item pickup
		toucherConnection = workspace.CurrentCamera.ChildAdded:Connect(function(child)
			if string.match(child.Name, "Resource") == "Resource" then
				print(child.Name, "VALIDs! ~~~!")
                while child and child.PrimaryPart do
                    pcall(function()
                        firetouchinterest(child.PrimaryPart, plr.Character.Head, 0)
                        task.wait(.1)
                        firetouchinterest(child.PrimaryPart, plr.Character.Head, 1)
                    end)
                end
			end
		end)

	end

	while _G.AutoFarmResource do
        local target = findResourceNode()
		if not target then
			task.wait(1)
			continue
		end

		RT.Request("TP To Resource and Damage", 2, function()
			CU.UseChar(true, function(char)
				char:PivotTo(target.CFrame)
				for _, dragon in pairs(char.Dragons:GetChildren()) do
					DH.FireBreath(dragon, target, "Destructibles")
					DH.Bite(dragon, target, "Destructibles")
				end
			end)
		end)
        
        task.wait()
    end

	-- disconnect item toucher
	if toucherConnection then
		toucherConnection:Disconnect()
	end
end

