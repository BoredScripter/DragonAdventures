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