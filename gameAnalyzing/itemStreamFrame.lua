local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v4 = require(v2:WaitForChild("Sonar"))
local u5 = v4("GuiManager")
local u6 = v4("GameUtils")
local u7 = v4("ItemStreamClass")
local u8 = v4("TitlesService")
local v9 = v4("StorageUtils")
local v10 = v4("PlayerWrapper")
local u11 = v4("Constants")
local u12 = v4(v9.Get("Currency"))
local u13 = v3.LocalPlayer
local u14 = v10.GetClient()
local v15 = u13:WaitForChild("PlayerGui"):WaitForChild("HUDGui")
local u16 = {}
local u17 = false
local u18 = {}
local function u19() --[[Anonymous function at line 40]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u5
        [3] = u16
    --]]
    if u17 then
        return
    end
    u17 = true
    u5.YieldForCanShowNotification()
    while true do
        if u16[3] then
            u16[3]:_tweenIn(true, #u16 <= 3)
        end
        u16[1]:_delayTweenOut(#u16 > 10 and "Massive" or (#u16 > 3 and "Max" or false))
        u16[1]:_waitForTweenOut()
        table.remove(u16, 1)
        if #u16 == 0 then
            u17 = false
            return
        end
    end
end
local function u23(p20) --[[Anonymous function at line 64]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u19
    --]]
    u16[#u16 + 1] = p20
    local v21 = table.find(u16, p20)
    if v21 <= 3 then
        local v22 = v21 ~= 1 and u16[v21 - 1]
        if v22 then
            v22 = u16[v21 - 1].TweenedIn
        end
        p20:_tweenIn(v22, true)
    end
    if v21 == 4 and u16[1].TweenedIn then
        u16[1].TweenOutValue.Value = true
    end
    task.spawn(u19)
end
local function u32(u24, u25, u26) --[[Anonymous function at line 87]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u18
        [3] = u7
        [4] = u23
    --]]
    if not u25.NoItemStream then
        local u27 = u24.Value
        return u24:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 93]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u27
                [3] = u11
                [4] = u25
                [5] = u18
                [6] = u7
                [7] = u26
                [8] = u23
            --]]
            local v28 = u24.Value - u27
            u27 = u24.Value
            if v28 <= 0 then
                return
            elseif not u11.DisableAutoItemStream then
                local u29 = u25.ItemType .. "_" .. u25.Name
                local v30 = u18[u29]
                if v30 then
                    v30 = u18[u29]:_adjust(v28)
                end
                if not v30 then
                    local v31 = u7.new(u25, v28, u26, nil, function() --[[Anonymous function at line 109]]
                        --[[
                        Upvalues:
                            [1] = u18
                            [2] = u29
                        --]]
                        u18[u29] = nil
                    end)
                    u18[u29] = v31
                    u23(v31)
                end
            end
        end)
    end
end
local function u43(p33) --[[Anonymous function at line 120]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u11
        [3] = u18
        [4] = u7
        [5] = u23
    --]]
    for _, v34 in p33 do
        for _, u35 in v34:GetChildren() do
            local u36 = u6.GetObjectFromName(u35.Name)
            if u36 and u6.VerifyItem(u36) then
                local u37 = v34.Name
                if not u36.NoItemStream then
                    local u38 = u35.Value
                    u35:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 93]]
                        --[[
                        Upvalues:
                            [1] = u35
                            [2] = u38
                            [3] = u11
                            [4] = u36
                            [5] = u18
                            [6] = u7
                            [7] = u37
                            [8] = u23
                        --]]
                        local v39 = u35.Value - u38
                        u38 = u35.Value
                        if v39 <= 0 then
                            return
                        elseif not u11.DisableAutoItemStream then
                            local u40 = u36.ItemType .. "_" .. u36.Name
                            local v41 = u18[u40]
                            if v41 then
                                v41 = u18[u40]:_adjust(v39)
                            end
                            if not v41 then
                                local v42 = u7.new(u36, v39, u37, nil, function() --[[Anonymous function at line 109]]
                                    --[[
                                    Upvalues:
                                        [1] = u18
                                        [2] = u40
                                    --]]
                                    u18[u40] = nil
                                end)
                                u18[u40] = v42
                                u23(v42)
                            end
                        end
                    end)
                end
            end
        end
    end
end
local function u55(p44) --[[Anonymous function at line 138]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u11
        [3] = u18
        [4] = u7
        [5] = u23
    --]]
    for u47, u48 in pairs(p44) do
        if type(u48) == "table" then
            local u47 = u48.Name or u47
        end
        if type(u48) == "table" then
            local u48 = u48.Value or u48
        end
        local u49 = u6.GetObjectFromName(u47)
        if u49 and u6.VerifyItem(u49) then
            if not u49.NoItemStream then
                local u50 = u48.Value
                u48:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 93]]
                    --[[
                    Upvalues:
                        [1] = u48
                        [2] = u50
                        [3] = u11
                        [4] = u49
                        [5] = u18
                        [6] = u7
                        [7] = u47
                        [8] = u23
                    --]]
                    local v51 = u48.Value - u50
                    u50 = u48.Value
                    if v51 <= 0 then
                        return
                    elseif not u11.DisableAutoItemStream then
                        local u52 = u49.ItemType .. "_" .. u49.Name
                        local v53 = u18[u52]
                        if v53 then
                            v53 = u18[u52]:_adjust(v51)
                        end
                        if not v53 then
                            local v54 = u7.new(u49, v51, u47, nil, function() --[[Anonymous function at line 109]]
                                --[[
                                Upvalues:
                                    [1] = u18
                                    [2] = u52
                                --]]
                                u18[u52] = nil
                            end)
                            u18[u52] = v54
                            u23(v54)
                        end
                    end
                end)
            end
        end
    end
end
local function u62(p56) --[[Anonymous function at line 157]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u6
        [3] = u8
        [4] = u23
        [5] = u7
    --]]
    for u57, v58 in p56 do
        v58.ChildAdded:Connect(function(p59) --[[Anonymous function at line 159]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u6
                [3] = u8
                [4] = u23
                [5] = u7
                [6] = u57
            --]]
            if u11.DisableAutoItemStream then
                return
            else
                local v60 = p59:IsA("BoolValue") and p59.Name or p59.Value
                local v61 = u6.GetObjectFromName(v60) or u8.GetTitleFromName(v60)
                if v61 then
                    if u6.VerifyItem(v61) then
                        u23(u7.new(v61, 1, u57, p59))
                    end
                else
                    return
                end
            end
        end)
    end
end
local function u73(p63) --[[Anonymous function at line 180]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u6
        [3] = u23
        [4] = u7
        [5] = u32
    --]]
    local function v71(u64, p65) --[[Anonymous function at line 181]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u6
            [3] = u23
            [4] = u7
            [5] = u32
        --]]
        if u11.DisableAutoItemStream then
            return
        else
            local v66 = u64.Name
            local v67 = u6.GetItemFromCategory(v66, "Tools")
            if v67 then
                if u6.VerifyItem(v67) then
                    if not p65 then
                        u23(u7.new(v67, u64.Value, "Tools", u64))
                    end
                    local u68 = { u32(u64, v67, "Tools") }
                    local v69 = u64:GetPropertyChangedSignal("Parent")
                    table.insert(u68, v69:Connect(function() --[[Anonymous function at line 203]]
                        --[[
                        Upvalues:
                            [1] = u64
                            [2] = u68
                        --]]
                        if not u64.Parent then
                            for _, v70 in u68 do
                                v70:Disconnect()
                            end
                        end
                    end))
                end
            else
                return
            end
        end
    end
    for _, v72 in p63:GetChildren() do
        v71(v72, true)
    end
    p63.ChildAdded:Connect(v71)
end
function v1.Stream(p74, p75, p76, p77) --[[Anonymous function at line 223]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u7
        [3] = u23
    --]]
    local u78 = (p74.ItemType or "") .. "_" .. p74.Name
    local v79 = u18[u78]
    if v79 then
        v79 = u18[u78]:_adjust(p75)
    end
    if not v79 then
        local v80 = u7.new(p74, p75, p76, p77, function() --[[Anonymous function at line 229]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u78
            --]]
            u18[u78] = nil
        end)
        u18[u78] = v80
        u23(v80)
    end
end
task.spawn(function() --[[Anonymous function at line 238]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u5
        [3] = u55
        [4] = u14
        [5] = u12
        [6] = u43
        [7] = u62
        [8] = u73
    --]]
    if not u13:GetAttribute("LoadedWrappers") then
        repeat
            task.wait()
        until u13:GetAttribute("LoadedWrappers")
    end
    u5.YieldForCanShowNotification(true)
    u55({
        ["Coins"] = u14.CoinsValue,
        ["AlchemyElixir"] = u14.PlayerData.Alchemy.Elixir,
        ["AlchemyBottles"] = u14.PlayerData.Alchemy.Bottles,
        ["CommonToken"] = u14.PlayerData.Currency.CommonToken,
        ["SeasonPoints"] = u14.PlayerData.Missions.Challenge.Points,
        ["GuildCoins"] = u14.PlayerData.Currency.GuildCoins,
        ["GuildPoints"] = u14.PlayerData.Guild.PointsEarned,
        ["PVPToken"] = u14.PlayerData.Currency.PVPToken,
        ["UGCStamps"] = u14.PlayerData.Currency.UGCStamps,
        ["FoodSacrificePoints"] = u14.PlayerData.FoodSacrificer.SacrificePoints,
        ["CloverCoins"] = u14.CurrencyValues.CloverCoins or nil,
        ["HoneyPots"] = u14.CurrencyValues.HoneyPots or nil
    })
    local v81 = {}
    for v82, v83 in u12 do
        if v83.ItemType == "Tokens" then
            v81[v82] = u14:_getCurrencyValue(v82)
        end
    end
    u55(v81)
    u43({ u14.PlayerData.Resources, u14.PlayerData.Eggs })
    u62({
        ["Dragons"] = u14.PlayerData.Dragons,
        ["Accessories"] = u14.PlayerData.Accessories,
        ["Cosmetics"] = u14.PlayerData.Cosmetics,
        ["Buildings"] = u14.PlayerData.Buildings,
        ["PlotThemes"] = u14.PlayerData.PlotThemes,
        ["Flairs"] = u14.PlayerData.Flairs,
        ["BuildingRecipes"] = u14.PlayerData.BuildingRecipes,
        ["Title"] = u14.PlayerData.Titles
    })
    u73(u14.ToolsData)
end)
u5.AddFrame(v15.ItemStreamFrame, {
    ["Overlay"] = true,
    ["TweenAnimation"] = false,
    ["KeepPosition"] = true,
    ["CheckVisibility"] = function() --[[Function name: CheckVisibility, line 306]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u14
        --]]
        local v84 = u11.HadIntro
        if v84 then
            v84 = #u14.DragonsData:GetChildren() > 0
        end
        return v84
    end
})
return v1
