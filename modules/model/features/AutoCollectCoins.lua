
local RT = __require("model.utils.RequestTask")
local CU = __require("model.utils.CharUtils")

local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local CurrencyNodes = workspace:WaitForChild("Interactions"):WaitForChild("Nodes"):WaitForChild("CurrencyNodes")

local function isClose(posA, posB, threshold)
    return (posA - posB).Magnitude <= threshold
end

local function findTheServerCoin(coin)
    for _, serverCoin in pairs(CurrencyNodes:GetChildren()) do
        if not serverCoin:IsA("Folder") and serverCoin.Name == coin.Name then
            if isClose(serverCoin.Position, coin.Position, 10) then
                return serverCoin
            end
        end
    end
end

local function findCoin()
    for _, coin in pairs(CurrencyNodes.Spawned:GetChildren()) do
        if coin.Name == "MegaCoins" then
            return findTheServerCoin(coin)
        end
    end
end

return function ()
    while _G.AutoCollectCoins do
        local coin = findCoin()
        if not coin then
            task.wait(1)
            continue
        end

        RT.Request("Loot Coin", 5, function()
            CU.UseChar(true, function(char)
                char:PivotTo(coin.CFrame)
                task.wait(.1)
                
                Remotes.GetCurrencyNodeRemote:FireServer(coin)
                task.wait(.5)
            end)
        end)
        task.wait()
    end
end