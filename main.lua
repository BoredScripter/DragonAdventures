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