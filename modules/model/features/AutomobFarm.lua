
return function ()
    local plr = game.Players.LocalPlayer
    local char = plr.Character
    local root = char.PrimaryPart

    local DH = __require('model.utils.DragonHandler')
    local MH = __require('model.utils.MonsterHandler')

    while _G.AutomobFarm do
        local mob = MH.FindMob()
        if mob then
            root.CFrame = mob.CFrame
            for _, dragon in pairs(char.Dragons:GetChildren()) do
                DH.FireBreath(dragon, mob)
                DH.Bite(dragon, mob)
            end
        end
        task.wait()
    end 
end