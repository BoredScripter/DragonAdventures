local u1 = game:GetService("Players")
local u2 = game:GetService("RunService")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("Debris")
local u5 = game:GetService("CollectionService")
local v6 = game:GetService("GuiService")
local v7 = game:GetService("SoundService")
local u8 = workspace.CurrentCamera
local u9 = workspace.Terrain
local u10 = require(game.ReplicatedStorage:WaitForChild("Sonar"))
local u11 = u10("Maid")
local u12 = game.Players.LocalPlayer
local u13 = u10("PlayerWrapper")
local u14 = u10("MathUtils")
u10("RemoteUtils")
u10("Signal")
local u15 = u10("CharacterData")
local u16 = u10("BloodDrop")
local u17 = u10("OverlayTracker")
local u18 = u10("NotificationsClient")
local u19 = u10("SettingsUtils")
local v20 = u10("Octree")
local u21 = u10("SprintService")
local v22 = u10("InputTypeDetector")
local u23 = u10("Constants")
local u24 = u10("AilmentUtils")
local u25 = u10("AilmentParticle")
local u26 = u10("PartUtils")
local u27 = u10("PopupGui")
local u28 = u10("Sniff")
local u29 = u10("Ocean")
local u30 = u12:GetMouse()
local u31 = {}
u31.__index = u31
local u32 = u13:GetClient()
local u33 = v22.IsMobileInputType()
local u34 = v6:IsTenFootInterface()
local u35 = u23.JawData
local u36 = {}
local u37 = Instance.new("Folder", workspace.Interactions)
u37.Name = "FootprintFolder"
u37.ChildRemoved:Connect(function(p38) --[[Anonymous function at line 54]]
    --[[
    Upvalues:
        [1] = u36
    --]]
    u36[p38] = nil
end)
local u39 = v20.new("LocalCharacters", 4, 512)
local u40 = game.ReplicatedStorage.Storage.Assets
local u41 = u40.Scars
local u42 = game.ReplicatedStorage.Storage.SFX
local u43 = u40.Particles
local u44 = workspace:WaitForChild("Characters")
local u45 = Instance.new("Folder", game.ReplicatedStorage)
u45.Name = "CharacterRenderBin"
local u46 = {
    [Enum.Material.Grass] = true,
    [Enum.Material.Sand] = true,
    [Enum.Material.Mud] = true,
    [Enum.Material.Snow] = true,
    [Enum.Material.Salt] = true
}
local u47 = {
    [Enum.Material.Rock] = true,
    [Enum.Material.Slate] = true,
    [Enum.Material.Asphalt] = true,
    [Enum.Material.Sandstone] = true
}
local u48 = {
    { u42.T2StepSoft, u42.T2StepHard },
    { u42.T2StepSoft, u42.T2StepHard },
    { u42.T3StepSoft, u42.T3StepHard },
    { u42.T4StepSoft, u42.T4StepHard },
    { u42.T5StepSoft, u42.T5StepHard }
}
local u49 = {}
local u50 = Vector3.new(0, 0, 0)
local u51 = nil
local u52 = true
local u53 = nil
for _, v54 in u48 do
    for _, v55 in v54 do
        v55.SoundGroup = v7:WaitForChild("Footsteps")
    end
end
local function u66(p56) --[[Anonymous function at line 121]]
    local v57 = #p56.Name
    local v58 = p56.Name:lower()
    local v59 = v58:sub(0, 1) == "t"
    if v59 then
        v59 = tonumber(v58:sub(2))
    end
    if v59 then
        v59 = p56.Name:sub(v57) ~= "S"
    end
    local v60 = v59 or (p56.Name == "N1" and true or p56.Name == "N2" or (p56.Name:lower():sub(v57 - 3, v57) == "body" or ((p56.Name == p56:GetRootPart() or p56.Name == "HumanoidRootPart") and true or p56.Name == "Hitbox")))
    local v61 = true
    local v62 = p56.Name:find("S")
    local v63 = p56.Name:sub(v57) == "S"
    if v62 then
        local v64 = p56.Name
        local v65 = v62 + 1
        v62 = tonumber(v64:sub(v65, v57))
    end
    if v63 or v62 then
        v61 = false
    end
    return v60, v60 or v61
end
local function u112(u67) --[[Anonymous function at line 140]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u48
        [3] = u43
        [4] = u66
    --]]
    u67.Tails = {}
    u67.Neck = {}
    u67.Body = {}
    u67.Feet = {}
    u67.Jaw = nil
    local u68 = u67.Species == "Ura"
    local function u73(p69) --[[Anonymous function at line 150]]
        --[[
        Upvalues:
            [1] = u67
            [2] = u68
        --]]
        if p69:IsA("Motor6D") then
            local v70 = p69.Name
            local v71 = v70:lower()
            local v72 = v71:sub(0, 1) == "t"
            if v72 then
                v72 = tonumber(v71:sub(2))
            end
            if not v72 and (v70:sub(0, 2) == "LT" or v70:sub(0, 2) == "RT") then
                v72 = tonumber(v70:sub(3))
                u67.ExtraTails = true
            end
            if not v72 and (u68 and v70 == "UpperBody1") and true or v72 then
                u67.Tails[#u67.Tails + 1] = { p69, p69.Transform }
            end
        end
    end
    local function u78(p74) --[[Anonymous function at line 169]]
        --[[
        Upvalues:
            [1] = u67
        --]]
        if p74:IsA("Motor6D") then
            local v75 = p74.Name
            local v76 = v75:lower()
            local v77 = v76:sub(0, 1) == "n"
            if v77 then
                v77 = tonumber(v76:sub(2))
            end
            if not v77 and (v75:sub(0, 2) == "LN" or v75:sub(0, 2) == "RN") then
                v77 = tonumber(v75:sub(3))
                u67.ExtraNecks = true
            end
            if v77 then
                u67.Neck[#u67.Neck + 1] = { p74, p74.Transform, p74.Parent }
            end
        end
    end
    local function u80(p79) --[[Anonymous function at line 183]]
        --[[
        Upvalues:
            [1] = u67
        --]]
        if p79:IsA("Motor6D") then
            if p79.Name == "UpperBody" then
                u67.Body[#u67.Body + 1] = { p79, p79.Transform }
            end
        end
    end
    local function u90(p81) --[[Anonymous function at line 190]]
        --[[
        Upvalues:
            [1] = u67
        --]]
        if p81:IsA("Motor6D") then
            if p81.Name == "Jaw" then
                u67.Jaw = { p81, p81.C0 }
                local v82 = {
                    ["LookVector"] = p81.Part0.CFrame.LookVector,
                    ["UpVector"] = p81.Part0.CFrame.UpVector,
                    ["RightVector"] = p81.Part0.CFrame.RightVector
                }
                local v83 = -1
                local v84 = nil
                local v85 = -1
                for v86, v87 in pairs(v82) do
                    local v88 = v87.Unit:Dot(u67.Root.CFrame.RightVector)
                    local v89 = math.abs(v88)
                    if v83 < v89 then
                        v85 = v88
                        v84 = v86
                        v83 = v89
                    end
                end
                u67.RotationVector = v84
                u67.RotationSign = math.sign(v85)
            end
        end
    end
    local function u105(p91) --[[Anonymous function at line 216]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u48
            [3] = u67
            [4] = u43
        --]]
        if p91:IsA("BasePart") then
            if u5:HasTag(p91, "Footstep") then
                local v92 = table.clone(u48[u67.Tier])
                local v93 = u43.FootstepGrass:Clone()
                local v94 = u43.Footstep:Clone()
                local v95 = {
                    ["Default"] = v94,
                    [Enum.Material.Grass] = v93,
                    [Enum.Material.LeafyGrass] = v93
                }
                v93.Parent = p91
                v94.Parent = p91
                local v96 = 1
                local v97 = 1
                local v98 = u67.Data:Get("Age")
                if v98 <= 33 then
                    v96 = 0.33
                    v97 = 1.25
                elseif v98 > 33 and v98 < 66 then
                    v96 = 0.66
                    v97 = 1.15
                end
                for v99, v100 in pairs(v92) do
                    local v101 = v100:Clone()
                    v101.Parent = p91
                    v92[v99] = v101
                    v101.Volume = v101.Volume * v96
                    local v102 = Instance.new("PitchShiftSoundEffect", v101)
                    v102.Enabled = true
                    v102.Octave = v97
                end
                local v103 = u67.Feet
                local v104 = {
                    p91,
                    p91.Size,
                    v92,
                    v95
                }
                table.insert(v103, v104)
            end
        end
    end
    local function u109(p106) --[[Anonymous function at line 254]]
        --[[
        Upvalues:
            [1] = u67
            [2] = u66
        --]]
        if p106:IsA("BasePart") then
            local v107, v108
            if u67.IsLocal then
                v107 = nil
                v108 = nil
            else
                v108, v107 = u66(p106)
            end
            if u67.Data:Get("Breath") then
                p106.CanQuery = v107
            end
            p106.CanTouch = v108
            if not (v108 or (v107 or p106.CanCollide)) then
                p106.CollisionGroup = "FullyStatic"
            end
        end
    end
    u67.Model.DescendantAdded:Connect(function(p110) --[[Anonymous function at line 270]]
        --[[
        Upvalues:
            [1] = u73
            [2] = u78
            [3] = u80
            [4] = u90
            [5] = u105
            [6] = u109
        --]]
        u73(p110)
        u78(p110)
        u80(p110)
        u90(p110)
        u105(p110)
        u109(p110)
    end)
    for _, v111 in pairs(u67.Model:GetDescendants()) do
        u73(v111)
        u78(v111)
        u80(v111)
        u90(v111)
        u105(v111)
        u109(v111)
    end
end
function u31.new(u113) --[[Anonymous function at line 288]]
    --[[
    Upvalues:
        [1] = u31
        [2] = u1
        [3] = u13
        [4] = u15
        [5] = u14
        [6] = u42
        [7] = u11
        [8] = u12
        [9] = u10
        [10] = u51
        [11] = u39
        [12] = u112
        [13] = u2
        [14] = u26
        [15] = u3
        [16] = u27
        [17] = u33
        [18] = u23
        [19] = u43
        [20] = u24
        [21] = u25
        [22] = u49
    --]]
    local v114 = u31
    local u115 = setmetatable({}, v114)
    u115.Model = u113
    u115.OriginalScale = u113:GetScale()
    u115.Player = u1:FindFirstChild(u113.Name)
    u115.Wrapper = u13.getWrapperFromPlayer(u115.Player)
    u115.Species = u113:WaitForChild("Data"):GetAttribute("Species")
    u115.Root = u113:WaitForChild("HumanoidRootPart")
    u115.PrimaryPart = u115.Root
    u115.NextLookUpdate = tick() + 0.25
    u115.Data = u15.GetOrCreateCharacterData(u113, u115.Player)
    u115.CharacterData = u115.Data
    u115.IsAquatic = u115.Data:GetCached("Aquatic")
    u115.CanGoInvisible = u115.Data:Get("Invisibility")
    u115.Tier = u115.Data:Get("Tier")
    u115.FoodType = u115.Data:Get("FoodType")
    local v116 = u14.map(u115.Tier, 1, 5, 0.4, 1.5)
    u115.FoodSound = (u115.FoodType == "Carnivore" and u42.FoodCarnivore or u42.FoodHerbivore):Clone()
    local v117 = u115.FoodSound
    v117.Volume = v117.Volume * v116
    u115.FoodSound.Parent = u115.Root
    u115.DrinkSound = u42.Drink:Clone()
    local v118 = u115.DrinkSound
    v118.Volume = v118.Volume * v116
    u115.DrinkSound.Parent = u115.Root
    u115.AscendBuildUpSound = u42.AscendBuildUp:Clone()
    u115.AscendBuildUpSound.Parent = u115.Root
    u115.AscendBoomSound = u42.AscendBoom:Clone()
    u115.AscendBoomSound.Parent = u115.Root
    u115.AscendChorusSound = u42.AscendChorus:Clone()
    u115.AscendChorusSound.Parent = u115.Root
    u115.DamageTakenSound = u42.DamageTaken:Clone()
    u115.DamageTakenSound.Parent = u115.Root
    u115._lastDistance = 0
    u115.Maid = u11.new()
    u115.Maid:GiveTask(u115.Data)
    u115.IsLocal = u115.Model == u12.Character
    if u115.IsLocal then
        u51 = u115
    else
        local v119 = u10("Breath")
        if u115.Data:Get("Breath") then
            u115.Breath = v119.new(u115)
            u115.Maid:GiveTask(u115.Breath)
        end
    end
    u115.LastWalkCycleRefresh = tick() + 1
    u115.NextOctreeUpdate = tick() + 3
    u39:Add(u115, u115.Root.Position)
    u115.Motor = u115.Root:WaitForChild("MiddleBody", 1) or u115.Root:FindFirstChildOfClass("Motor6D")
    u112(u115)
    if u115.Jaw then
        u115.CallSounds = u115.Root:WaitForChild("CallSounds")
        u115.Maid:GiveTask(u115.CallSounds.ChildAdded:Connect(function(p120) --[[Anonymous function at line 357]]
            --[[
            Upvalues:
                [1] = u115
            --]]
            u115:_trackSoundForJaw(p120)
        end))
        for _, v121 in pairs(u115.CallSounds:GetChildren()) do
            u115:_trackSoundForJaw(v121)
        end
    end
    local u122 = true
    local u123 = u113 ~= u12.Character and true or nil
    u115.Maid:GiveTask(u2.Heartbeat:Connect(function(p124) --[[Anonymous function at line 370]]
        --[[
        Upvalues:
            [1] = u123
            [2] = u122
            [3] = u115
        --]]
        if u123 then
            u122 = not u122
        end
        if u122 then
            u115:Step(p124)
        end
    end))
    u115.Maid:GiveTask(u2.Stepped:Connect(function(_) --[[Anonymous function at line 377]]
        --[[
        Upvalues:
            [1] = u115
        --]]
        u115:UpdateSecondaryMotors()
    end))
    u115.RootSize = u115.Root.Size
    u115.CurrentHealth = u115.Data:Get("Health")
    u115.Maid:GiveTask(u115.Data:GetStatChangedSignal("Health"):Connect(function() --[[Anonymous function at line 383]]
        --[[
        Upvalues:
            [1] = u115
        --]]
        local v125 = u115.Data:Get("Health")
        local v126 = u115.Data:Get("MaxHealth")
        local v127 = u115.CurrentHealth - u115.Data:Get("Health")
        if v125 < u115.CurrentHealth then
            u115:DamageEffects(v127, v127 / v126 > 0.01)
        end
        local v128 = v125 / v126
        u115.LastHealthPercent = v128
        u115:_updateScars(v128)
        u115:_updatePermanentOverlays()
        u115.CurrentHealth = v125
    end))
    u115:_updatePermanentOverlays()
    u115.Maid:GiveTask(u115.Data:GetStatChangedSignal("Eating"):Connect(function() --[[Anonymous function at line 398]]
        --[[
        Upvalues:
            [1] = u115
        --]]
        local v129 = u115.Data:Get("Eating")
        u115.Eating = v129
        if v129 then
            u115.FoodSound:Play()
        else
            u115.FoodSound:Stop()
        end
    end))
    u115.Maid:GiveTask(u115.Data:GetStatChangedSignal("Drinking"):Connect(function() --[[Anonymous function at line 408]]
        --[[
        Upvalues:
            [1] = u115
        --]]
        local v130 = u115.Data:Get("Drinking")
        u115.Drinking = v130
        if v130 then
            u115.DrinkSound:Play()
        else
            u115.DrinkSound:Stop()
        end
    end))
    u115.Maid:GiveTask(u115.Data:GetStatChangedSignal("Lay"):Connect(function() --[[Anonymous function at line 418]]
        --[[
        Upvalues:
            [1] = u115
        --]]
        u115.Laying = u115.Data:Get("Lay")
    end))
    u115.Maid:GiveTask(u115.Data:GetAilmentChangedSignal("TutorialImmunity"):Connect(function() --[[Anonymous function at line 423]]
        --[[
        Upvalues:
            [1] = u115
        --]]
        u115.IsInTutorial = u115.Data:HasAilment("TutorialImmunity")
    end))
    u115.Maid:GiveTask(u115.Data:GetStatChangedSignal("VenerationTier"):Connect(function() --[[Anonymous function at line 427]]
        --[[
        Upvalues:
            [1] = u115
            [2] = u26
            [3] = u3
            [4] = u27
        --]]
        local u131 = u115.Data:Get("VenerationTier")
        if u131 > 0 then
            local u132 = {}
            for _, v133 in ipairs(u115.Model:GetDescendants()) do
                if v133:IsA("BasePart") then
                    local v134 = {
                        ["Part"] = v133,
                        ["Material"] = v133.Material,
                        ["Color"] = v133.Color
                    }
                    table.insert(u132, v134)
                end
            end
            local v135 = u115.Model:GetExtentsSize()
            local u136 = u115.Model:GetPrimaryPartCFrame().Position
            local v137 = v135.X
            local v138 = v135.Y
            local v139 = v135.Z
            local u140 = math.max(v137, v138, v139) * (1.1 + 0.1 * u131)
            local u141 = Instance.new("Part")
            u141.Shape = Enum.PartType.Ball
            u141.Size = Vector3.new(0.2, 0.2, 0.2)
            u141.Material = Enum.Material.Neon
            u141.Color = Color3.new(1, 1, 1)
            u141.Transparency = 0.5
            u141.CFrame = CFrame.new(u136)
            u26.SanitizePart(u141)
            u141.Parent = workspace
            u115.AscendBuildUpSound:Play()
            local v142 = u3:Create(u141, TweenInfo.new(2 + 0.5 * u131), {
                ["Size"] = Vector3.new(u140, u140, u140)
            })
            local v143 = 10 + u131 * 4
            local v144 = (2 + 0.5 * u131) / v143
            for v145 = 1, v143 do
                task.delay(v145 * v144, function() --[[Anonymous function at line 472]]
                    --[[
                    Upvalues:
                        [1] = u136
                        [2] = u26
                        [3] = u3
                        [4] = u140
                        [5] = u131
                    --]]
                    local u146 = Instance.new("Part")
                    u146.Size = Vector3.new(0.4, 0.1, 0.4)
                    u146.Material = Enum.Material.Neon
                    u146.Color = Color3.new(1, 1, 1)
                    u146.Transparency = 0.2
                    u146.CFrame = CFrame.new(u136) * CFrame.fromEulerAnglesXYZ(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2)
                    u146.Shape = Enum.PartType.Cylinder
                    u26.SanitizePart(u146)
                    u146.Parent = workspace
                    local v147 = u3
                    local v148 = TweenInfo.new(2)
                    local v149 = {}
                    local v150 = u140 * (2 + 0.5 * u131)
                    local v151 = u140 * (2 + 0.5 * u131)
                    v149.Size = Vector3.new(v150, 0.1, v151)
                    v149.Transparency = 1
                    local v152 = v147:Create(u146, v148, v149)
                    v152.Completed:Once(function() --[[Anonymous function at line 489]]
                        --[[
                        Upvalues:
                            [1] = u146
                        --]]
                        u146:Destroy()
                    end)
                    v152:Play()
                end)
            end
            for _, v153 in u132 do
                v153.Part.Material = Enum.Material.Neon
                local v154 = {
                    ["Color"] = v153.Part.Color:Lerp(Color3.new(1, 1, 1), 0.7)
                }
                u3:Create(v153.Part, TweenInfo.new(1.5), v154):Play()
            end
            v142.Completed:Once(function() --[[Anonymous function at line 510]]
                --[[
                Upvalues:
                    [1] = u115
                    [2] = u3
                    [3] = u141
                    [4] = u140
                    [5] = u131
                    [6] = u132
                    [7] = u27
                --]]
                u115.AscendBoomSound:Play()
                local v155 = u3
                local v156 = u141
                local v157 = TweenInfo.new(0.5)
                local v158 = {}
                local v159 = u140 * (1.5 + 0.5 * u131)
                local v160 = u140 * (1.5 + 0.5 * u131)
                local v161 = u140 * (1.5 + 0.5 * u131)
                v158.Size = Vector3.new(v159, v160, v161)
                v158.Transparency = 1
                local v162 = v155:Create(v156, v157, v158)
                v162.Completed:Once(function() --[[Anonymous function at line 519]]
                    --[[
                    Upvalues:
                        [1] = u141
                    --]]
                    u141:Destroy()
                end)
                for _, v163 in u132 do
                    v163.Part.Material = v163.Material
                    u3:Create(v163.Part, TweenInfo.new(1.2), {
                        ["Color"] = v163.Color
                    }):Play()
                end
                v162:Play()
                if u115.IsLocal then
                    task.delay(2, function() --[[Anonymous function at line 534]]
                        --[[
                        Upvalues:
                            [1] = u115
                            [2] = u131
                            [3] = u27
                        --]]
                        u115.AscendChorusSound.PlaybackSpeed = 1 + (u131 - 1) * 0.05
                        u115.AscendChorusSound:Play()
                        u27:AddNotification({
                            ["Type"] = "VenerableUp",
                            ["Duration"] = 3,
                            ["RunBefore"] = function(p164) --[[Function name: RunBefore, line 542]]
                                --[[
                                Upvalues:
                                    [1] = u131
                                --]]
                                p164.Label.AgeLabel.Text = ("VENERATION STAGE (%*/5)"):format(u131)
                            end
                        })
                    end)
                end
            end)
            v142:Play()
        end
    end))
    if u115.CanGoInvisible then
        u115:_mapInvisibleParts()
        u115.Maid:GiveTask(u115.Data:GetStatChangedSignal("IsInvisible"):Connect(function() --[[Anonymous function at line 556]]
            --[[
            Upvalues:
                [1] = u115
            --]]
            u115:_toggleInvisibility()
        end))
        u115:_toggleInvisibility()
    elseif not u33 then
        u115:_mapScarParts()
    end
    u115.CanCharge = u115.Data:Get("Charge")
    if u115.CanCharge then
        u115.ChargeData = u23.ChargeData[u115.CanCharge]
        u115._chargeParticle = u43.Charge:Clone()
        u115._chargeParticle.Enabled = false
        u115._chargeParticle.Parent = u115.Root
        u115._defaultChargeColor = u43.Charge.Color
    end
    u115:_mapEyeParts()
    u115:_updateEyes(game.Lighting:GetAttribute("BloodMoon"))
    local v165 = u115.Data:Get("Age")
    local v166 = v165 <= 33 and 0.33 or (v165 <= 66 and 0.66 or 1)
    for _, v167 in pairs(u115.Feet) do
        for _, v168 in pairs(v167[4]) do
            u14.scaleParticle(v168, u115.Tier * v166)
        end
    end
    for v169, _ in pairs(u113.Ailments:GetAttributes()) do
        if u24.GetAilmentParticle(v169) and not u25.ParticleExists(u115.Player, v169) then
            u25.new(u113, v169)
        end
    end
    u115.Maid:GiveTask(u113.Ailments.AttributeChanged:Connect(function(p170) --[[Anonymous function at line 601]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u25
            [3] = u115
            [4] = u113
        --]]
        if u24.GetAilmentParticle(p170) and not u25.ParticleExists(u115.Player, p170) then
            u25.new(u113, p170)
        end
    end))
    u115.NextLookUpdate = tick() + 2
    u49[u113] = u115
    u115.Wrapper.CharacterEffects = u115
    return u115
end
Vector3.new()
local u171 = false
local u172 = false
function u31.Step(p173, p174) --[[Anonymous function at line 634]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u172
        [3] = u13
        [4] = u50
        [5] = u44
        [6] = u33
        [7] = u19
        [8] = u32
        [9] = u45
        [10] = u23
        [11] = u14
        [12] = u171
    --]]
    if u12.Character then
        if p173.Data and p173.Data.Get then
            if p173.PrimaryPart.Anchored then
                p173.LocalVelocity = Vector3.new(0, 0, 0)
            elseif p173._isRendered then
                p173.LocalVelocity = p173.LocalVelocity or Vector3.new(0, 0, 0)
                local v175 = p173.Root.AssemblyAngularVelocity
                local v176 = v175.X
                local v177 = v175.Y
                local v178 = math.clamp(v177, -3, 3)
                local v179 = v175.Z
                local v180 = Vector3.new(v176, v178, v179)
                local v181 = p173.Root.CFrame:VectorToObjectSpace(v180)
                p173.LocalVelocity = p173.LocalVelocity:lerp(v181, 0.025)
            else
                p173.LocalVelocity = Vector3.new(0, 0, 0)
            end
            u172 = p173.IsLocal or not u172
            if p173.IsLocal then
                local v182 = u13.getCharacterFromPlayer(u12)
                if v182 and (v182.CameraPositionOverride and v182.CameraPart) then
                    u50 = v182.CameraPart.Position
                else
                    u50 = p173.Root.Position
                end
            end
            p173:_updateOctree()
            local v183 = p173.Model.Parent
            local v184 = u44
            p173._isRendered = true
            local v185 = p173.IsInTutorial
            if v185 then
                v185 = p173._lastDistance < 400
            end
            if (u33 or v185) and not p173.IsLocal and ((u19.GetSetting(u32, "CharacterReparent") and 850 or 1500) < p173._lastDistance or v185) then
                v184 = u45
                p173._isRendered = false
            end
            if (p173._lastDistance < 700 and 1.25 or 3) < tick() - (p173._lastReparent or 0) and v183 ~= v184 then
                p173._lastReparent = tick()
                p173.Model.Parent = v184
            end
            if p173.IsLocal and tick() - p173.LastWalkCycleRefresh <= 5 then
                p173.LastWalkCycleRefresh = tick()
                p173.NearbyCharacters = p173:GetCharactersNearby(u33 and 100 or 150, p173.Root.Position)
                table.sort(p173.NearbyCharacters, function(p186, p187) --[[Anonymous function at line 696]]
                    return (p186._lastDistance or 9000000000) < (p187._lastDistance or 9000000000)
                end)
                local v188 = 0
                for _, _ in p173.NearbyCharacters do
                    v188 = v188 + 1
                end
                p173.PlayersNearby = v188
                if not next(p173.NearbyCharacters) then
                    p173.NearbyCharacters = { p173 }
                end
            end
            if p173._chargeParticle then
                local v189 = (p173.Root.Velocity * Vector3.new(1, 0.5, 1)).Magnitude
                local v190 = v189 - u23.GetAdjustedSpeed(u23.GetSpeed(p173.Data:Get("Speed")))
                local v191 = math.abs(v190)
                local v192 = v189 - u23.GetAdjustedSpeed(u23.GetSpeed(p173.Data:Get("SprintSpeed"))) * 0.8
                local v193 = math.abs(v192) < v191 and not p173.Data:Get("Fly")
                if v193 then
                    if v189 > 5 then
                        v193 = p173._lastDistance <= 150
                    else
                        v193 = false
                    end
                end
                local v194 = p173.Sprinting
                p173.Sprinting = v193
                p173._chargeParticle.Enabled = p173.Sprinting
                if v193 and not v194 then
                    p173._sprintTime = 0
                elseif v193 then
                    p173._sprintTime = p173._sprintTime + p174 * 1.75
                else
                    p173._chargeParticle.Color = p173._defaultChargeColor
                end
                if v193 then
                    local v195 = p173.ChargeData.TimeToActivate
                    local v196 = u33 and 15 or 30
                    if p173._sprintTime >= p173.ChargeData.TimeToActivate * 0.7 then
                        p173._chargeParticle.Color = ColorSequence.new(Color3.new(1, 0.45, 0))
                    end
                    local v197 = p173._chargeParticle
                    local v198 = u14.map(p173._sprintTime, 0, v195, 0, v196)
                    v197.Rate = math.clamp(v198, 0, v196)
                end
            end
            if p173.IsLocal and p173.NearbyCharacters then
                debug.profilebegin("Walk Effects")
                if u171 then
                    u171 = false
                else
                    u171 = true
                    for v199, v200 in ipairs(p173.NearbyCharacters) do
                        v200._nearbyIndex = v199
                        if v200.UpdateWalkEffects then
                            v200:UpdateWalkEffects()
                        end
                    end
                end
                debug.profileend()
            end
        end
    else
        return
    end
end
function u31._updateOctree(p201) --[[Anonymous function at line 760]]
    --[[
    Upvalues:
        [1] = u50
        [2] = u39
    --]]
    if tick() < p201.NextOctreeUpdate then
        return
    else
        p201._lastPosition = p201._isRendered and p201.Root.Position or p201.Data:Get("P")
        if p201._lastPosition then
            p201._lastDistance = (u50 - p201._lastPosition).Magnitude
            p201.NextOctreeUpdate = p201._lastDistance < 700 and tick() + 1.25 or tick() + 3
            u39:UpdateFor(p201, p201._lastPosition)
        end
    end
end
function u31._mapScarParts(u202) --[[Anonymous function at line 777]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u41
    --]]
    if not u23.IsBattleRoyale then
        local u203 = {
            [Vector3.new(0, 1, 0)] = Enum.NormalId.Top,
            [Vector3.new(0, -1, 0)] = Enum.NormalId.Bottom,
            [Vector3.new(1, 0, 0)] = Enum.NormalId.Right,
            [Vector3.new(-1, 0, 0)] = Enum.NormalId.Left,
            [Vector3.new(0, 0, 1)] = Enum.NormalId.Front,
            [Vector3.new(0, 0, -1)] = Enum.NormalId.Back
        }
        u202.Scars = {}
        local function u210(p204) --[[Anonymous function at line 798]]
            --[[
            Upvalues:
                [1] = u203
            --]]
            local v205 = (1 / 0)
            local v206 = nil
            for v207, v208 in pairs(u203) do
                local v209 = p204.Unit:Dot(v207)
                if v209 < v205 then
                    v206 = v208
                    v205 = v209
                end
            end
            return v206 or Enum.NormalId.Left
        end
        local function v224(p211) --[[Anonymous function at line 821]]
            --[[
            Upvalues:
                [1] = u210
                [2] = u202
            --]]
            local v212 = p211.CFrame.UpVector:Dot(Vector3.new(0, 1, 0)) > 0.6
            local v213 = p211.Name:lower()
            if v212 then
                if v213:find("upperbody") or v213:find("middlebody") then
                    local v214 = Enum.NormalId.Left
                    local v215 = Enum.NormalId.Right
                    if math.random() < 0.5 then
                        return v214
                    else
                        return v215
                    end
                end
                local v216 = v213:lower()
                local v217 = v216:sub(0, 1) == "t"
                if v217 then
                    v217 = tonumber(v216:sub(2))
                end
                if v217 then
                    local v218 = Enum.NormalId.Top
                    local v219 = Enum.NormalId.Bottom
                    if math.random() < 0.5 then
                        return v218
                    else
                        return v219
                    end
                end
                local v220 = v213:lower()
                local v221 = v220:sub(0, 1) == "n"
                if v221 then
                    v221 = tonumber(v220:sub(2))
                end
                if v221 then
                    local v222 = Enum.NormalId.Back
                    local v223 = Enum.NormalId.Front
                    if math.random() < 0.5 then
                        return v222
                    else
                        return v223
                    end
                end
            end
            return u210(p211.Position - u202.Root.Position)
        end
        for _, v225 in pairs(u202.Model:GetDescendants()) do
            if v225:IsA("BasePart") and v225.Transparency < 1 then
                local v226 = v225.Size
                if v226.Magnitude >= u202.RootSize.Magnitude * 0.3 then
                    local v227 = u41:GetChildren()
                    local v228 = v227[math.random(1, #v227)]:Clone()
                    v228.Texture = v228:FindFirstChild("Value").Value
                    v228.Face = v224(v225)
                    local v229 = v226.X
                    local v230 = v226.Y
                    local v231 = v226.Z
                    local v232 = math.min(v229, v230, v231)
                    v228.StudsPerTileU = v232 * math.random(75, 125) / 100
                    v228.StudsPerTileV = v232 * math.random(75, 125) / 100
                    v228.OffsetStudsU = math.random(-v232, v232)
                    v228.OffsetStudsV = math.random(-v232, v232)
                    v228.Parent = v225
                    u202.Scars[v225] = v228
                end
            end
        end
    end
end
function u31._mapInvisiblePart(p233, p234) --[[Anonymous function at line 854]]
    if p234:IsA("BasePart") then
        p233.ObjectTransparencies[p234] = p234.Transparency
        local _ = p234.Transparency
    elseif p234:IsA("ParticleEmitter") or p234:IsA("Beam") then
        p233.ObjectTransparencies[p234] = p234.Transparency
        local _ = p234.Transparency
    end
    return nil
end
function u31._mapInvisibleParts(p235) --[[Anonymous function at line 866]]
    p235.ObjectTransparencies = {}
    for _, v236 in pairs(p235.Model:GetDescendants()) do
        p235:_mapInvisiblePart(v236)
    end
end
function u31._toggleInvisibility(u237) --[[Anonymous function at line 873]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u238 = u237.Data:Get("IsInvisible")
    u237.IsInvisible = u238
    local u239 = u237.IsLocal and 0.95 or 1
    local u240 = NumberSequence.new(u239)
    local function u248(p241, p242, p243) --[[Anonymous function at line 878]]
        --[[
        Upvalues:
            [1] = u238
            [2] = u3
            [3] = u239
            [4] = u240
        --]]
        if p242 == 1 then
            return
        else
            local v244 = p243 or u238
            if p241:IsA("ParticleEmitter") or p241:IsA("Beam") then
                if v244 then
                    p242 = u240 or p242
                end
                p241.Transparency = p242
            else
                local v245 = u3
                local v246 = TweenInfo.new(0.25)
                local v247 = {}
                if v244 then
                    p242 = u239 or p242
                end
                v247.Transparency = p242
                v245:Create(p241, v246, v247):Play()
            end
        end
    end
    for v249, v250 in pairs(u237.ObjectTransparencies) do
        u248(v249, v250)
    end
    if not u237._descendantCheck then
        u237._descendantCheck = u237.Model.DescendantAdded:Connect(function(p251) --[[Anonymous function at line 894]]
            --[[
            Upvalues:
                [1] = u237
                [2] = u248
            --]]
            local v252 = u237:_mapInvisiblePart(p251)
            if v252 then
                u248(p251, v252, u237.IsInvisible)
            end
        end)
        u237.Maid:GiveTask(u237._descendantCheck)
    end
end
function u31.SetHeadTarget(_, p253) --[[Anonymous function at line 909]]
    --[[
    Upvalues:
        [1] = u53
        [2] = u13
    --]]
    if p253 then
        local v254 = u13:GetClient():GetCurrentCharacter()
        if v254 then
            u53 = v254.Root.CFrame:PointToObjectSpace(p253).Unit
        end
    else
        u53 = nil
        return
    end
end
function u31._rotateJaw(p255, p256) --[[Anonymous function at line 922]]
    --[[
    Upvalues:
        [1] = u35
        [2] = u33
        [3] = u3
    --]]
    if p255._isRendered then
        local v257 = p255.Jaw[1]
        local v258 = p255.Jaw[2]
        local v259 = v258.Position * (p255.Model:GetScale() / p255.OriginalScale)
        local v260 = CFrame.new(v259) * (v258 - v258.Position)
        local v261 = u35[p255.Species] and (u35[p255.Species].Offset or -0.7853981633974483) or -0.7853981633974483
        if p256 then
            local v262 = v257.Part0.CFrame
            local v263 = v262:Inverse()
            local v264 = v262 * v260
            local v265 = v261 * p255.RotationSign
            local v266 = v264:VectorToObjectSpace(v262[p255.RotationVector])
            v260 = v263 * (v264 * CFrame.fromAxisAngle(v266, v265))
        end
        local v267 = v260.X
        if v267 == v267 then
            local v268 = v260.Y
            if v268 == v268 then
                local v269 = v260.Z
                if v269 == v269 then
                    local v270 = p256 and Enum.EasingStyle.Elastic or Enum.EasingStyle.Sine
                    local v271 = p256 and Random.new():NextNumber(0.5, 1) or 0.25
                    local v272 = TweenInfo.new(v271, v270, Enum.EasingDirection.Out)
                    if u33 then
                        v257.C0 = v260
                    else
                        u3:Create(v257, v272, {
                            ["C0"] = v260
                        }):Play()
                    end
                end
            end
        end
    end
end
function u31._trackSoundForJaw(u273, u274) --[[Anonymous function at line 965]]
    u273.PlayingSounds = u273.PlayingSounds or {}
    local u275 = u274.SoundId
    u273.Maid:GiveTask(u274.Played:Connect(function() --[[Anonymous function at line 968]]
        --[[
        Upvalues:
            [1] = u273
            [2] = u275
        --]]
        u273.PlayingSounds[u275] = true
        u273:_rotateJaw(true)
    end))
    local function v276() --[[Anonymous function at line 972]]
        --[[
        Upvalues:
            [1] = u273
            [2] = u275
        --]]
        u273.PlayingSounds[u275] = nil
        if not next(u273.PlayingSounds) then
            u273:_rotateJaw(false)
        end
    end
    u273.Maid:GiveTask(u274.Stopped:Connect(v276))
    u273.Maid:GiveTask(u274.Ended:Connect(v276))
    u273.Maid:GiveTask(u274:GetPropertyChangedSignal("SoundId"):Connect(function() --[[Anonymous function at line 981]]
        --[[
        Upvalues:
            [1] = u274
            [2] = u273
            [3] = u275
        --]]
        if u274.SoundId == "" then
            u273.PlayingSounds[u275] = nil
            if next(u273.PlayingSounds) then
                return
            end
            u273:_rotateJaw(false)
        end
    end))
    u273.Maid:GiveTask(u274.DidLoop:Connect(v276))
end
local function u310(p277, p278) --[[Anonymous function at line 989]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u53
        [3] = u8
        [4] = u14
        [5] = u30
    --]]
    local v279 = nil
    local v280 = nil
    if p278 then
        if u23.HeadLocked and u23.CameraMode then
            v279 = p277._lastHorizontal
            v280 = p277._lastVertical
        end
        if p277.Eating or p277.Drinking then
            return
        else
            local v281 = p277.Root.CFrame
            debug.profilebegin("Update Neck")
            local v282
            if p278 then
                v282 = u53
            else
                v282 = p278
            end
            local v283 = 0.125
            if p278 then
                if p278 and not v282 then
                    v282 = v281:PointToObjectSpace((u8.CFrame * CFrame.new(0, 0, -750)).p).Unit
                end
            else
                if not (p277._replicatedHorizontal and p277._replicatedVertical) then
                    return
                end
                v283 = v283 * 0.375
                v282 = nil
            end
            local v284, v285
            if v282 then
                local v286 = v282.x
                local v287 = -v282.z
                v284 = -math.atan2(v286, v287)
                local v288 = v282.y
                v285 = math.asin(v288)
            else
                v284 = u14.map(p277._replicatedHorizontal, -127, 127, -2.2, 2.2)
                v285 = u14.map(p277._replicatedVertical, -127, 127, -1.5, 1.5)
            end
            if p278 and math.abs(v284) > 2.2 then
                local v289
                if u53 then
                    v289 = v281:PointToObjectSpace(u8.CFrame.Position).Unit
                    v285 = -v285
                else
                    local v290 = workspace.CurrentCamera.ViewportSize
                    local v291 = v290.X
                    local v292 = v290.Y
                    local v293 = u30.X - v291 / 2
                    local v294 = u30.Y - v292 / 2
                    v289 = v281:PointToObjectSpace((u8.CFrame * CFrame.new(v293 / v291 * 100, -v294 / v292 * 100, 0)).p).Unit
                    local v295 = v289.y
                    v285 = math.asin(v295)
                end
                local v296 = v289.x
                local v297 = -v289.z
                v284 = -math.atan2(v296, v297)
            end
            local v298 = #p277.Neck
            if p277.IsAquatic then
                v284 = v284 * 0.8
                v285 = v285 * 0.65
            end
            p277._lastHorizontal = p277._lastHorizontal or 0
            p277._lastVertical = p277._lastVertical or 0
            if p277.Laying then
                v283 = v283 * 0.1
                v284 = 0
                v285 = 0
            end
            if v280 and v279 then
                p277._lastHorizontal = v279
                p277._lastVertical = v280
            else
                p277._lastHorizontal = u14.lerp(p277._lastHorizontal, v284 / v298, v283)
                p277._lastVertical = u14.lerp(p277._lastVertical, v285 / v298, v283)
            end
            if p277._lastHorizontal ~= 0 or p277._lastVertical ~= 0 then
                for _, v299 in pairs(p277.Neck) do
                    local v300 = v299[3].CFrame
                    local v301 = Vector3.new(0, 1, 0)
                    local v302 = v281.UpVector
                    local v303 = v300.UpVector
                    if v303:Dot(v301) >= v302:Dot(v301) then
                        v302 = v303
                    end
                    local v304 = v299[1]
                    local v305 = v304.Transform
                    local v306 = v300:Inverse()
                    local v307 = v300 * v299[2]
                    local v308 = p277._lastHorizontal
                    local v309 = v307:VectorToObjectSpace(v302)
                    v304.Transform = v305 * (v306 * (v307 * CFrame.fromAxisAngle(v309, v308)) * CFrame.Angles(p277._lastVertical, 0, 0))
                end
                debug.profileend()
            end
        end
    else
        return
    end
end
function u31.UpdateSecondaryMotors(p311) --[[Anonymous function at line 1142]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u23
        [3] = u33
        [4] = u50
        [5] = u8
        [6] = u310
    --]]
    if u12.Character then
        if p311.LocalVelocity then
            local v312 = p311.IsLocal
            if u23.IsBattleRoyale and not v312 then
                return
            else
                if not v312 then
                    if not p311._isRendered then
                        return
                    end
                    local v313 = u33 and 50 or 150
                    local v314 = p311.Root
                    if not v314 then
                        return
                    end
                    local v315 = v314.Position
                    if v313 < (u50 - v315).Magnitude then
                        return
                    end
                    local _, v316 = u8:WorldToViewportPoint(v315)
                    if not v316 then
                        return
                    end
                end
                local v317 = p311.Model
                if v317 then
                    v317 = p311.Model:FindFirstChild("AnimationController")
                end
                if not v317 or #v317:GetPlayingAnimationTracks() ~= 0 then
                    if v312 or p311._nearbyIndex and p311._nearbyIndex < 6 then
                        u310(p311, v312)
                    end
                    local v318 = p311.LocalVelocity.X
                    local v319 = math.rad(v318)
                    local v320 = p311.LocalVelocity.Y
                    local v321 = math.rad(v320)
                    for _, v322 in pairs(p311.Tails) do
                        local v323 = -9.5
                        local v324 = 6.5
                        if p311.ExtraTails then
                            v323 = v323 * 1.5
                            v324 = v324 * 1.5
                        end
                        local v325 = v322[1]
                        v325.Transform = v325.Transform * (CFrame.new(v322[2].p) * CFrame.Angles(v319 * v323, -v321 * v324, 0))
                    end
                    for _, v326 in pairs(p311.Body) do
                        local v327 = v326[1]
                        v327.Transform = v327.Transform * CFrame.Angles(v319 * 27.5, v321 * 13.5, v321 * 7.5)
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
function u31._placeFootprint(p328, p329, p330, p331, p332) --[[Anonymous function at line 1206]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u14
        [3] = u52
        [4] = u37
        [5] = u36
        [6] = u4
        [7] = u23
    --]]
    local v333 = u40.FootprintModels[p328.FoodType]:Clone()
    local v334 = CFrame.new(p329, p329 + p330) * CFrame.Angles(1.5707963267948966, 0, 0)
    local _, v335 = p328.Root.CFrame:ToOrientation()
    local _, _, _ = v334:ToOrientation()
    local v336 = (Vector3.new(0, 1, 0)):Cross(p330)
    local v337 = (Vector3.new(0, 1, 0)):Dot(p330)
    local v338 = math.acos(v337)
    local v339 = v336.Magnitude <= 0 and Vector3.new(1, 0, 0) or v336.unit
    local v340 = CFrame.new(v334.p) * CFrame.fromAxisAngle(v339, v338)
    local _, _, _ = v340:ToOrientation()
    local _, _ = CFrame.new(v340.p, p328.Root.Position):ToOrientation()
    v333.CFrame = CFrame.new(v340.p) * u14.getRotationBetween(Vector3.new(0, 1, 0), p330, v340.UpVector) * CFrame.Angles(0, v335, 0)
    v333.Color = p331:lerp(u52 and Color3.new(0.85, 0, 0) or Color3.new(0, 0, 0), 1 - (p328.LastHealthPercent or 1))
    local v341 = p332.X * 1.18
    local v342 = p332.Z * 1.18
    local v343 = math.max(v341, v342) / 2.5
    local v344 = p332.Y
    local v345 = math.min(v343, v344)
    local v346 = math.clamp(v345, 0, 0.5)
    v333.Size = Vector3.new(v341, v346, v342)
    v333.Parent = u37
    u36[v333] = p328
    u4:AddItem(v333, u23.IsBattleRoyale and 120 or 45)
end
u28:AddGlobalSniffCallback(function() --[[Anonymous function at line 1243]]
    --[[
    Upvalues:
        [1] = u36
        [2] = u28
    --]]
    TweenInfo.new(0.35)
    for v347, v348 in pairs(u36) do
        if v348.CharacterData and (v348.CharacterData.GetAilment and not v348.CharacterData:GetAilment("HideScent")) then
            v347.Material = Enum.Material.Neon
        end
    end
    task.wait(u28.SNIFF_TIME * 2)
    for v349, _ in pairs(u36) do
        v349.Material = Enum.Material.Salt
    end
end)
local u350 = RaycastParams.new()
u350.FilterType = Enum.RaycastFilterType.Include
u350.IgnoreWater = true
u350.CollisionGroup = "Default"
u350.RespectCanCollide = true
u350.FilterDescendantsInstances = { u9 }
function u31.UpdateWalkEffects(p351) --[[Anonymous function at line 1265]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u34
        [3] = u350
        [4] = u47
        [5] = u46
        [6] = u9
        [7] = u33
        [8] = u21
    --]]
    if u23.IsBattleRoyale then
        return
    elseif p351.Root.Velocity.Magnitude <= 3 then
        return
    elseif p351.Data:Get("Swim") then
        return
    elseif p351.IsAquatic then
        return
    else
        if not p351._lastGroundRayCache then
            p351._lastGroundRayCache = {}
        end
        if p351.Feet and next(p351.Feet) then
            if not p351.IsLocal then
                if tick() - (p351._lastFootstepGroup or 0) < (u34 and 0.45 or 0.125) then
                    return
                end
                p351._lastFootstepGroup = tick()
            end
            for _, v352 in pairs(p351.Feet) do
                local v353 = v352[1]
                local v354 = p351._lastGroundRayCache[v353]
                local v355 = v352[2]
                local v356 = v352[5] or 0
                local v357 = v353.CFrame
                local v358 = v353.CFrame * CFrame.new(0, -(v355.Y / 2) * 3, 0)
                local v359 = workspace:Raycast(v357.p, v358.p - v357.p, u350)
                local v360, v361, v362, v363
                if v359 then
                    v360 = v359.Instance
                    v361 = v359.Position
                    v362 = v359.Normal
                    v363 = v359.Material
                else
                    v360 = nil
                    v363 = nil
                    v361 = nil
                    v362 = nil
                end
                if v360 then
                    if not v354 then
                        local _ = tick() - v356
                        if tick() - v356 > 0.25 then
                            local v364 = u47[v363] and 2 or 1
                            local v365
                            if u46[v363] then
                                v365 = u9:GetMaterialColor(v363) or nil
                            else
                                v365 = nil
                            end
                            p351._lastGroundRayCache[v353] = true
                            local v366 = v352[3][v364]
                            v366.PlaybackSpeed = math.random(9, 11) / 10
                            v366:Play()
                            if not u33 then
                                local v367 = p351.IsLocal and u21:IsSprinting() and 4 or 1
                                local v368 = v352[4][v363] or v352[4].Default
                                if v365 then
                                    v368.Color = ColorSequence.new(v365)
                                end
                                v368:Emit(1 * v367)
                                v352[5] = tick()
                                if v365 then
                                    p351:_placeFootprint(v361, v362, v365, v355)
                                end
                            end
                        end
                    end
                elseif v354 then
                    p351._lastGroundRayCache[v353] = nil
                end
            end
        end
    end
end
local u369 = true
function u31._bleed(u370, u371) --[[Anonymous function at line 1349]]
    --[[
    Upvalues:
        [1] = u32
        [2] = u369
        [3] = u29
        [4] = u16
    --]]
    local u372 = u370.RootSize
    local u373 = u32:GetCurrentCharacter()
    if u373 then
        u369 = not u369
        if not u369 then
            task.spawn(function() --[[Anonymous function at line 1375]]
                --[[
                Upvalues:
                    [1] = u371
                    [2] = u370
                    [3] = u29
                    [4] = u373
                    [5] = u372
                    [6] = u16
                --]]
                local v374 = u371 / u370.Data:Get("MaxHealth") * 10 * 0.2
                local v375 = u370.Root.Position.Y - u370.Root.Size.Y / 2 < u29:GetPosition(u370.Root.Position).Y
                if not v375 or u373.Swimming then
                    if v375 then
                        v374 = v374 * 0.5
                    end
                    for _ = 1, math.ceil(v374) do
                        if u370.Data and u370.Data.GetCached then
                            local v376 = (u370.Root.CFrame * CFrame.new(math.random(-u372.X / 2, u372.X / 2), 0, math.random(-u372.Z / 2, u372.Z / 2))).p
                            u16.new(v376, u370.Data:GetCached("Tier") / 2, u370.Data:GetCached("BloodColor"), u370.Data:GetCached("BloodMaterial"), v375)
                            task.wait(math.random())
                        end
                    end
                end
            end)
        end
    else
        return
    end
end
function u31._damageOverlay(u377, p378) --[[Anonymous function at line 1403]]
    --[[
    Upvalues:
        [1] = u17
    --]]
    if u377.IsLocal then
        u377.UniqueDamageTick = os.clock()
        local u379 = u377.UniqueDamageTick
        local v380 = u377.Data:Get("MaxHealth")
        local v381 = u17.setOverlay
        local v382 = 1 - p378 / v380
        v381("Damage", (math.clamp(v382, 0, 0.5)))
        task.delay(0.25, function() --[[Anonymous function at line 1414]]
            --[[
            Upvalues:
                [1] = u377
                [2] = u379
                [3] = u17
            --]]
            if u377.UniqueDamageTick == u379 then
                u17.setOverlay("Damage", 1)
            end
        end)
    end
end
function u31._updatePermanentOverlays(p383) --[[Anonymous function at line 1421]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u18
    --]]
    if p383.IsLocal then
        local v384 = p383.Data:Get("Health")
        local v385 = p383.Data:Get("MaxHealth")
        local v386 = v384 / (v385 * 0.2)
        local v387 = v384 / (v385 * 0.4)
        local v388 = v384 / (v385 * 0.6)
        local v389 = v384 / (v385 * 0.8)
        u17.setOverlay("Damage20", v386)
        u17.setOverlay("Damage40", v387)
        u17.setOverlay("Damage60", v388)
        u17.setOverlay("Damage80", v389)
        if v384 <= v385 * 0.15 and not p383._ranNotification then
            u18.Notify({
                ["Preset"] = "Red",
                ["Message"] = "You\'re badly hurt!"
            })
            p383._ranNotification = true
        else
            p383._ranNotification = false
        end
    else
        return
    end
end
function u31._updateScars(p390, p391) --[[Anonymous function at line 1450]]
    --[[
    Upvalues:
        [1] = u33
        [2] = u14
        [3] = u52
    --]]
    if u33 then
        return
    elseif p390.Scars then
        local v392 = u14.map(p391, 0, 1, 0, 1.25)
        local v393 = u52 and u14.round(v392, 0.1) or 1
        for _, v394 in pairs(p390.Scars) do
            v394.Transparency = v393
        end
    end
end
function u31._mapEyeParts(u395) --[[Anonymous function at line 1464]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u5
    --]]
    if not u23.IsBattleRoyale then
        u395.Eyes = {}
        local function v397(p396) --[[Anonymous function at line 1470]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u395
            --]]
            if p396:IsA("BasePart") and u5:HasTag(p396, "Eye") then
                u395.Eyes[p396] = { p396.Color, p396.Material }
            end
        end
        u395.Model.ChildAdded:Connect(v397)
        for _, v398 in pairs(u395.Model:GetChildren()) do
            v397(v398)
        end
    end
end
function u31._updateEyes(p399, p400) --[[Anonymous function at line 1481]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    if u23.IsBattleRoyale then
        return
    elseif p399.Eyes then
        if p400 then
            for v401, _ in pairs(p399.Eyes) do
                v401.Material = Enum.Material.Neon
                v401.Color = Color3.new(1, 0, 0)
            end
        else
            for v402, v403 in pairs(p399.Eyes) do
                v402.Color = v403[1]
                v402.Material = v403[2]
            end
        end
    else
        return
    end
end
function u31.DamageEffects(p404, p405, p406) --[[Anonymous function at line 1502]]
    if not p404._destroyed then
        if p406 then
            p404.DamageTakenSound:Play()
        end
        p404:_bleed(p405)
        p404:_damageOverlay(p405)
    end
end
function u31.Destroy(p407) --[[Anonymous function at line 1515]]
    --[[
    Upvalues:
        [1] = u49
        [2] = u39
    --]]
    p407._destroyed = true
    u49[p407.Model] = nil
    u39:Remove(p407)
    p407.ObjectTransparencies = nil
    p407.Maid:Destroy()
    p407.Wrapper.CharacterEffects = nil
    p407.Model = nil
    p407.Data = nil
    p407.Root = nil
    p407.Player = nil
    setmetatable(p407, nil)
end
function u31.GetCharactersNearby(_, p408, p409) --[[Anonymous function at line 1530]]
    --[[
    Upvalues:
        [1] = u39
    --]]
    return u39:RadiusSearch(p409, p408 or 100)
end
function u31.getCharacterEffectsFromModel(p410) --[[Anonymous function at line 1534]]
    --[[
    Upvalues:
        [1] = u49
    --]]
    return u49[p410]
end
local function v424() --[[Anonymous function at line 1538]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u32
        [3] = u52
        [4] = u17
    --]]
    local v411 = u19.GetSetting(u32, "BloodEffects")
    u52 = v411
    local v412
    if v411 then
        v412 = nil
    else
        v412 = Color3.new(0, 0, 0)
    end
    local v413 = u17.setOverlayColor
    local v414 = "Damage20"
    local v415
    if v411 then
        v415 = u17.getBaseOverlayColor("Damage20") or v412
    else
        v415 = v412
    end
    v413(v414, v415)
    local v416 = u17.setOverlayColor
    local v417 = "Damage40"
    local v418
    if v411 then
        v418 = u17.getBaseOverlayColor("Damage40") or v412
    else
        v418 = v412
    end
    v416(v417, v418)
    local v419 = u17.setOverlayColor
    local v420 = "Damage60"
    local v421
    if v411 then
        v421 = u17.getBaseOverlayColor("Damage60") or v412
    else
        v421 = v412
    end
    v419(v420, v421)
    local v422 = u17.setOverlayColor
    local v423 = "Damage80"
    if v411 then
        v412 = u17.getBaseOverlayColor("Damage80") or v412
    end
    v422(v423, v412)
end
local v425 = u19.GetSettingChangedSignal(u32, "BloodEffects")
if v425 then
    v425:Connect(v424)
    v424()
end
game.Lighting:GetAttributeChangedSignal("BloodMoon"):Connect(function() --[[Anonymous function at line 1557]]
    --[[
    Upvalues:
        [1] = u49
    --]]
    for _, v426 in pairs(u49) do
        v426:_updateEyes(game.Lighting:GetAttribute("BloodMoon"))
    end
end)
u10("Binder").new("Character", u31):Init()
return u31
