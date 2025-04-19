
return function ()
    local DH = __require('model.utils.DragonHandler')
    local MH = __require('model.utils.MonsterHandler')
    local RT = __require('model.utils.RequestTask')
    local CU = __require('model.utils.CharUtils')

    while _G.AutomobFarm do
        local mob = MH.FindMob()
        if not mob then
            task.wait(1)
            continue;
        end


        RT.Request("TP To Mob and Damage", 1, function()
            CU.UseChar(true, function(char)
                char:PivotTo(mob.CFrame)
                for _, dragon in pairs(char.Dragons:GetChildren()) do
                    DH.FireBreath(dragon, mob, "Mobs")
                    DH.Bite(dragon, mob, "Mobs")
                end
            end)
        end)
        
        task.wait()
    end 
end