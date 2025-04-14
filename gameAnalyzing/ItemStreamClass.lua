local u1 = {}
u1.__index = u1
local u2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("TweenService")
local v5 = require(v3:WaitForChild("Sonar"))
local u6 = v5("Maid")
local u7 = v5("DisplayUtils")
local u8 = v5("FormatNumber")
local u9 = v5("ViewportUtils")
v5("GameUtils")
v5("FormatString")
v5("GuiUtils")
local u10 = v5("EventUtils")
local u11 = v5("CurrencyNodeClass")
local u12 = v5(v5("StorageUtils").Get("Genetics"))
local u13 = {
    ["Max"] = 0.5,
    ["Massive"] = 0.15
}
local u14 = {
    ["Buildings"] = "Building",
    ["Dragons"] = "Dragon",
    ["Accessories"] = "Accessory",
    ["Cosmetics"] = "Cosmetic",
    ["PlotThemes"] = "Plot Theme",
    ["Flairs"] = "Flair",
    ["BuildingRecipes"] = "Crafting Recipe",
    ["Title"] = "Title"
}
local u15 = {}
local v16 = {
    ["TextLabel"] = {
        ["TextTransparency"] = 0,
        ["TextStrokeTransparency"] = 0
    },
    ["AmountLabel"] = {
        ["TextTransparency"] = 0.5,
        ["TextStrokeTransparency"] = 1
    },
    ["ViewportFrame"] = {
        ["ImageTransparency"] = 0
    },
    ["ImageLabel"] = {
        ["ImageTransparency"] = 0
    }
}
u15.In = v16
local v17 = {
    ["TextLabel"] = {
        ["TextTransparency"] = 1,
        ["TextStrokeTransparency"] = 1
    },
    ["ViewportFrame"] = {
        ["ImageTransparency"] = 1
    },
    ["ImageLabel"] = {
        ["ImageTransparency"] = 1
    }
}
u15.Out = v17
local u18 = TweenInfo.new(0.6)
local u19 = TweenInfo.new(0.4)
local u20 = TweenInfo.new(0.5)
local u21 = game:GetService("Players").LocalPlayer
local u22 = u21:WaitForChild("PlayerGui"):WaitForChild("HUDGui"):WaitForChild("ItemStreamFrame")
local u23 = v3.Assets.Audio:WaitForChild("ItemStream")
local function u31(p24) --[[Anonymous function at line 94]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    local v25 = u23:FindFirstChild(p24.UseSound or p24.Name)
    if v25 then
        return { v25 }
    end
    local v26 = u23:FindFirstChild(p24.ItemType)
    if v26 then
        return { v26 }
    end
    local v27 = {}
    if p24.Roar then
        local v28 = u23.Dragon
        v28.SoundId = p24.Roar.SoundId
        v27[#v27 + 1] = v28
    end
    local v29 = p24.Rarity
    if type(v29) == "table" then
        local v30 = p24.Rarity
        if v30 then
            v30 = u23:FindFirstChild(p24.Rarity.Name)
        end
        if v30 then
            v27[#v27 + 1] = v30
        end
    end
    return v27
end
u1.getSounds = u31
u1.SoundsFolder = u23
function u1.new(p32, p33, p34, p35, p36) --[[Anonymous function at line 125]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u6
        [3] = u12
        [4] = u22
        [5] = u9
        [6] = u10
        [7] = u21
        [8] = u4
        [9] = u15
        [10] = u23
        [11] = u7
        [12] = u14
        [13] = u8
    --]]
    local v37 = u1
    local u38 = setmetatable({}, v37)
    u38.Maid = u6.new()
    u38.TweenOutCallback = p36
    local v39
    if p34 == "Dragons" then
        local v40
        if p35 then
            v40 = p35:WaitForChild("Genetics")
        else
            v40 = p35
        end
        if p34 == "Dragons" then
            v39 = u12.CosmeticTraits[v40.Cosmetic.Value]
        else
            v39 = false
        end
    else
        v39 = nil
    end
    u38.Frame = v39 and u22.DefaultDragon:Clone() or u22.Default:Clone()
    u22.Default.Visible = false
    u38.ContainerFrame = u38.Frame.ContainerFrame
    u38.ItemData = p32
    if p32 then
        if p34 == "BuildingRecipes" then
            u38.Maid:GiveTask(u9.CreateItemImage(u38.ContainerFrame, "BuildingRecipes", true))
        elseif p34 == "Title" then
            u38.Maid:GiveTask(u9.CreateImage(u38.ContainerFrame, "rbxassetid://7122294020", true))
        elseif p34 == "Dragons" then
            u38.ContainerFrame.NameLabel.AutoLocalize = false
            u10.waitForFirstChild(p35)
            local v41 = {
                ["DragonValue"] = p35,
                ["DragonOwner"] = u21,
                ["Cosmetics"] = true
            }
            local v42 = u9.CreateDragonViewport(u38.ContainerFrame, v41)
            u38.Maid:GiveTask(v42)
            if v39 then
                u38.ContainerFrame.CosmeticContainer.CosmeticLabel.DragonCosmeticLabel.Image = v39.Image
                u38.ContainerFrame.CosmeticContainer.CosmeticLabel.Text = v39.Name
                task.delay(0.15, function() --[[Anonymous function at line 165]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u38
                        [3] = u15
                        [4] = u23
                    --]]
                    u4:Create(u38.ContainerFrame.CosmeticContainer, TweenInfo.new(0.35), {
                        ["BackgroundTransparency"] = 0.55
                    }):Play()
                    for _, v43 in pairs(u38.ContainerFrame.CosmeticContainer:GetDescendants()) do
                        if u15.In[v43.ClassName] then
                            u4:Create(v43, TweenInfo.new(0.35), u15.In[v43.ClassName]):Play()
                        end
                    end
                    task.delay(0.35, function() --[[Anonymous function at line 178]]
                        --[[
                        Upvalues:
                            [1] = u23
                        --]]
                        u23.Rare:Play()
                    end)
                end)
            end
        elseif p34 == "CustomImage" then
            u38.Maid:GiveTask(u9.CreateImage(u38.ContainerFrame, p35, true))
        else
            u38.Maid:GiveTask(u9.CreateItemImage(u38.ContainerFrame, p32.Name, true))
        end
        u38.ContainerFrame.NameLabel.Text = u7.GetDisplayName(p32.Name, p32, p32.Category == "Accessories")
        if u14[p34] then
            u38.ContainerFrame.AmountLabel.Text = u14[p34]
        else
            u38.CurrentAmount = p33
            local v44 = u38.ContainerFrame.AmountLabel
            local v45 = string.format
            local v46 = u38.CurrentAmount < 0 and "-" or ""
            local v47 = u8.splice
            local v48 = u38.CurrentAmount
            v44.Text = v45("%sx%s", v46, v47((math.abs(v48))))
            u38.ContainerFrame.GradientLabel.Visible = u38.CurrentAmount >= 0
            u38.ContainerFrame.GradientLabelNegative.Visible = u38.CurrentAmount < 0
        end
    end
    for _, v49 in pairs(u38.Frame:GetDescendants()) do
        if u15.Out[v49.ClassName] then
            for v50, v51 in pairs(u15.Out[v49.ClassName]) do
                v49[v50] = v51
            end
        end
    end
    u38.TweenOutValue = Instance.new("BoolValue")
    u38.Maid:GiveTask(u38.TweenOutValue:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 216]]
        --[[
        Upvalues:
            [1] = u38
        --]]
        u38:_tweenOut()
    end))
    u38.Frame.Visible = false
    u38.Frame.Parent = u22
    u38.Maid:GiveTask(u38.Frame)
    return u38
end
function u1.Destroy(p52) --[[Anonymous function at line 227]]
    p52.Maid:Destroy()
    setmetatable(p52, nil)
end
function u1._delayTweenOut(u53, p54) --[[Anonymous function at line 232]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    task.delay(p54 and u13[p54] or 2, function() --[[Anonymous function at line 233]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        if u53._tweenOut then
            if u53.RecentlyAdjusted then
                while u53.RecentlyAdjusted and u53._tweenOut do
                    task.wait(0.05)
                end
                if not u53._tweenOut then
                    return
                end
            end
            u53:_tweenOut()
        end
    end)
end
function u1._waitForTweenOut(p55) --[[Anonymous function at line 255]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    p55:_waitForTweenedIn()
    if not p55.TweeningOut then
        repeat
            u2.Heartbeat:Wait()
        until p55.TweeningOut
    end
end
function u1._waitForTweenedIn(p56) --[[Anonymous function at line 265]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if not p56.TweenedIn then
        repeat
            u2.Heartbeat:Wait()
        until p56.TweenedIn
    end
end
function u1._tweenIn(u57, p58, p59) --[[Anonymous function at line 273]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u18
        [3] = u31
        [4] = u11
        [5] = u15
    --]]
    if not u57.TweeningIn then
        u57.TweeningIn = true
        u57.Frame.Visible = true
        if p58 then
            u57.Frame.Size = UDim2.new(u57.Frame.Size.X.Scale, 0, 0.37, 0)
            u4:Create(u57.Frame, u18, {
                ["Size"] = UDim2.new(u57.Frame.Size.X.Scale, 0, 0.35, 0)
            }):Play()
        else
            u57.Frame.Size = UDim2.new(u57.Frame.Size.X.Scale, 0, 0.35, 0)
        end
        if p59 then
            local v60 = u31(u57.ItemData)
            if v60 and next(v60) then
                for _, v61 in pairs(v60) do
                    if v61.Name ~= "Coins" or tick() - u11.LastCoinPickUp >= 1 then
                        v61:Play()
                    end
                end
            end
        end
        for _, v62 in pairs(u57.Frame:GetDescendants()) do
            if not (u57.ContainerFrame:FindFirstChild("CosmeticContainer") and v62:IsDescendantOf(u57.ContainerFrame.CosmeticContainer)) and (u15.In[v62.ClassName] or u15.In[v62.Name]) then
                u4:Create(v62, u18, u15.In[v62.Name] or u15.In[v62.ClassName]):Play()
            end
        end
        task.delay(u18.Time, function() --[[Anonymous function at line 321]]
            --[[
            Upvalues:
                [1] = u57
            --]]
            u57.TweenedIn = true
        end)
    end
end
function u1._adjust(u63, p64) --[[Anonymous function at line 326]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    if u63.CurrentAmount then
        u63.CurrentAmount = u63.CurrentAmount + p64
        local v65 = u63.ContainerFrame.AmountLabel
        local v66 = string.format
        local v67 = u63.CurrentAmount < 0 and "-" or ""
        local v68 = u8.splice
        local v69 = u63.CurrentAmount
        v65.Text = v66("%sx%s", v67, v68((math.abs(v69))))
        u63.ContainerFrame.GradientLabel.Visible = u63.CurrentAmount >= 0
        u63.ContainerFrame.GradientLabelNegative.Visible = u63.CurrentAmount < 0
        local u70 = os.clock()
        u63.LastAdjustTime = u70
        u63.RecentlyAdjusted = true
        task.delay(2, function() --[[Anonymous function at line 338]]
            --[[
            Upvalues:
                [1] = u63
                [2] = u70
            --]]
            if u63.LastAdjustTime == u70 then
                if u63._tweenOut then
                    u63.RecentlyAdjusted = nil
                end
            else
                return
            end
        end)
        return true
    end
end
function u1._tweenOut(u71) --[[Anonymous function at line 350]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u20
        [3] = u15
        [4] = u19
    --]]
    if not u71.TweeningOut then
        u71.TweeningOut = true
        if u71.TweenOutCallback then
            u71.TweenOutCallback()
        end
        u71.ContainerFrame.UIAspectRatioConstraint:Destroy()
        u4:Create(u71.Frame, u20, {
            ["Size"] = UDim2.new(u71.Frame.Size.X.Scale, 0, 0, 0)
        }):Play()
        for _, v72 in pairs(u71.Frame:GetDescendants()) do
            if u15.Out[v72.ClassName] then
                u4:Create(v72, u19, u15.Out[v72.ClassName]):Play()
            end
        end
        task.delay(u19.Time, function() --[[Anonymous function at line 372]]
            --[[
            Upvalues:
                [1] = u71
            --]]
            u71:Destroy()
        end)
    end
end
return u1
