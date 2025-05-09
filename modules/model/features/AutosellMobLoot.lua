local mobLootToSell = {"Meat", "Bacon", "Ashes"}

-- Modules
local RemoteMiddleman = __require("model.utils.RemoteMiddleman")
local RT = __require('model.utils.RequestTask')
local CU = __require('model.utils.CharUtils')


local Client = _G.Client

local sellPart = workspace:WaitForChild("Interactions").GeneralStore:WaitForChild("BillboardPart")

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
            RT.Request("Sell mob loot", 10, function()
                -- Tp char to CFrame.new(1,1,1)
                CU.UseChar(true, function(char)
                    local root = char.HumanoidRootPart
                    -- root.CFrame = sellPart.CFrame
                    char:PivotTo(sellPart.CFrame)
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