
return function ()
    local DH = __require('model.utils.DragonHandler')
    local MH = __require('model.utils.MonsterHandler')
    local RT = __require('model.utils.RequestTask')
    local CU = __require('model.utils.CharUtils')

    while _G.AutomobFarm do
        local mob = MH.FindMob()
        if mob then
            CU.UseChar(function(char)
                local root = char.HumanoidRootPart

                RT.Request("TP To Mob and Damage", 1, function()
                    root.CFrame = mob.CFrame
                    for _, dragon in pairs(char.Dragons:GetChildren()) do
                        DH.FireBreath(dragon, mob)
                        DH.Bite(dragon, mob)
                    end
                end)
            end)

        end
        task.wait()
    end 
end