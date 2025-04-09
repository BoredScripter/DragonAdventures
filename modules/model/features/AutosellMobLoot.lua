local mobLootToSell = {"Meat", "Bacon", "Ashes"}

return function ()
    while _G.AutosellMobLoot do
        for _, lootStr in pairs(mobLootToSell) do
            game:GetService("ReplicatedStorage"):WaitForChild('Remotes').SellItemRemote:FireServer({
                ItemName = lootStr,
                Amount = 100000,
            })
        end
         
        task.wait(10)
    end
end