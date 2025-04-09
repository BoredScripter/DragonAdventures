local u1 = {}
u1.__index = u1
local u2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("CollectionService")
local u5 = game:GetService("TweenService")
local isServer = u2:IsServer()
local u7 = require(v3:WaitForChild("Sonar"))
local u8 = not u6
if u8 then
    u8 = u7("DragonDamageClient")
end
local u9 = u7("ElementUtils")
local v10 = u7("EventUtils")
local u11 = not u6
if u11 then
    u11 = u7("GetAutoTargetFromPosition")
end
local u12 = not u6
if u12 then
    u12 = u7("InputTypeDetector")
end
local u13 = u7("InstanceUtils")
local u14 = u7("Maid")
local v15 = not u6
if v15 then
    v15 = u7("Mouse")
end
local u16 = u7("ParticleUtils")
local v17 = u7("PlayerWrapper")
local u18 = u7("Signal")
local u19 = u7("Constants")
local u20 = u19.FireDistance
local u21 = game.Players.LocalPlayer
local u22
if u21 then
    u22 = v17.GetClient()
else
    u22 = u21
end
local u23 = workspace.CurrentCamera
local u24 = Random.new()
local u25 = v3.Storage.Dragons.MovementSounds
local u26 = {}
local u27 = workspace:WaitForChild("BreathImpactParts")
local u28, u29
if isServer then
    u28 = nil
    u29 = nil
else
    u29 = v15.new(true)
    u29.TargetBlackList = u13.GetIndexedInstancesWithTag("FireIgnore", { u27, workspace.CurrentCamera, u21.Character })
    u28 = u7("DragonTilter")
end
local function u57(u30) -- IF SERVER
    --[[
    Upvalues:
        [1] = u16
        [2] = u4
        [3] = u25
        [4] = u27
    --]]
    local v31 = Instance.new("RemoteEvent")
    v31.Name = "BreathFireRemote"
    v31.Parent = u30.RemotesFolder
    u30.Maid:GiveTask(v31)
    u30.BreathFuelValue.Value = u30.BreathCapacity
    u30.Maid:GiveTask(v31.OnServerEvent:Connect(function(p32, p33) --[[Anonymous function at line 66]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        if p32 == u30.Player then
            if u30._destroyed then
                return
            elseif p33 then
                u30:Fire()
            else
                u30:Stop()
            end
        else
            return
        end
    end))
    u30.Maid:GiveTask(u30.ElementChangedSignal:Connect(function() --[[Anonymous function at line 80]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u16
            [3] = u4
            [4] = u25
            [5] = u27
        --]]
        u30.ElementMaid:DoCleaning()
        local v34 = u30.ElementData.Model
        local v35 = Instance.new("Model")
        v35.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
        v35.Name = u30.Player.Name .. "-" .. u30.DragonId
        local v36 = v34.End:Clone()
        v36.Name = "ImpactPart"
        v36.Transparency = 1
        for _, v37 in pairs(v36:GetDescendants()) do
            if v37:IsA("ParticleEmitter") then
                v37.Enabled = false
                v37.Size = u16.GetParticleSize(v37, u30.BreathScaleMultiplier)
                v37.Speed = u16.GetParticleSpeed(v37, u30.BreathScaleMultiplier)
            end
        end
        v36.CFrame = u30.PrimaryPart.CFrame
        local v38 = Instance.new("BodyGyro")
        v38.Name = "BG"
        v38.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
        v38.Parent = v36
        local v39 = Instance.new("BodyPosition")
        v39.Name = "BP"
        v39.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
        v39.P = v39.P * 3
        v39.Position = v36.Position
        v39.Parent = v36
        v36.Anchored = false
        v36.CanCollide = false
        v36.CanQuery = false
        v36.CanTouch = false
        local v40 = v36.End
        for v41, _ in pairs(u30.Heads) do
            local v42 = v41:FindFirstChild("Fire", true)
            for _, v43 in pairs(v34.Source:GetChildren()) do
                if v43:IsA("ParticleEmitter") then
                    local v44 = v43:Clone()
                    v44.Enabled = false
                    v44.Parent = v42
                    u4:AddTag(v44, "BreathSourceParticle")
                    u30.ElementMaid:GiveTask(v44)
                end
            end
            local v45 = v34.Source:FindFirstChild("BreathSound") or u25.Breath
            if v42 == u30.Dragon.MainFireAttachment then
                local v46 = v45:Clone()
                v46.Name = "BreathSound"
                v46.Parent = v42
                u30.ElementMaid:GiveTask(v46)
            end
            local v47 = v34.Source.BeamMain:Clone()
            local v48 = v34.Source.BeamWide:Clone()
            v47.Enabled = false
            v48.Enabled = false
            v47.Attachment0 = v42
            v48.Attachment0 = v42
            local v49 = v48.Width0
            local v50 = u30.AgeData.RealSizeMultiplier
            v48.Width0 = v49 * math.sqrt(v50)
            local v51 = v47.Width0
            local v52 = u30.AgeData.RealSizeMultiplier
            v47.Width0 = v51 * math.sqrt(v52)
            local v53 = v48.Width1
            local v54 = u30.AgeData.RealSizeMultiplier
            v48.Width1 = v53 * math.sqrt(v54)
            local v55 = v47.Width1
            local v56 = u30.AgeData.RealSizeMultiplier
            v47.Width1 = v55 * math.sqrt(v56)
            v47.Attachment1 = v40
            v48.Attachment1 = v40
            v47.Parent = v41
            v48.Parent = v41
        end
        v36.Parent = v35
        v35.Parent = u27
        u30.ElementMaid:GiveTask(v35)
        u30.BreathImpactPart = v36
        u30.ImpactModelValue.Value = v35
        v36:SetNetworkOwnershipAuto(false)
        v36:SetNetworkOwner(u30.Player)
    end))
    u30.Metadata = {}
    u30:_trackBreath()
end
local function u62(u58) -- if NOT SERVER
    --[[
    Upvalues:
        [1] = u22
        [2] = u13
        [3] = u2
    --]]
    u58.BreathFireRemote = u58.RemotesFolder:FindFirstChild("BreathFireRemote")
    u58.PlayerControls = u22.PlayerControls
    local v59, v60 = u13.GetIndexedInstancesWithTag("FireIgnore", { u58.Dragon.DragonModel }, "AllowDamageRays")
    for _, v61 in pairs(v60) do
        u58.Maid:GiveTask(v61)
    end
    u58.RaycastIgnoreList = v59
    u58.FireAttachmentOrientations = {}
    u58.FireAttachments = u58.Dragon.FireAttachments
    u58._nextHit = 0
    u58.Maid:GiveTask(u2.Heartbeat:Connect(function() --[[Anonymous function at line 198]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u58
        --]]
        if u22.CurrentDragon == u58.Dragon then
            u58:_update()
        end
    end))
    u58.Maid:GiveTask(u58.ImpactModelValue:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 206]]
        --[[
        Upvalues:
            [1] = u58
        --]]
        u58:_getImpactModel()
    end))
    if not u58.IsLocalPlayer then
        u58.Maid:GiveTask(u58.FireValue:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 211]]
            --[[
            Upvalues:
                [1] = u58
            --]]
            if u58.FireValue.Value then
                u58:Fire()
            else
                u58:Stop()
            end
        end))
    end
end
function u1.new(p63) --[[Anonymous function at line 221]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u14
        [3] = u18
        [4] = u6
        [5] = u20
        [6] = u57
        [7] = u62
        [8] = u26
    --]]
    local v64 = u1
    local u65 = setmetatable({}, v64)
    u65.Maid = p63.Maid
    u65.ElementMaid = u14.new()
    u65.Dragon = p63
    u65.IsLocalPlayer = p63.IsLocalPlayer
    u65.Player = p63.Player
    u65.PrimaryPart = p63.PrimaryPart
    u65.SpeciesData = p63.SpeciesData
    u65.AgeData = p63.DragonAgeData
    u65.DragonStatValues = p63.Stats
    local v66 = u65.AgeData.RealSizeMultiplier
    u65.BreathScaleMultiplier = math.sqrt(v66)
    u65.MaxBreathCapacityValue = u65.DragonStatValues.BreathCapacityValue
    u65.BreathRegenRateValue = u65.DragonStatValues.BreathRegenRateValue
    u65.Heads = p63.Heads
    u65.ElementChangedSignal = u18.new()
    u65.Maid:GiveTask(u65.ElementChangedSignal)
    u65.RemotesFolder = p63.RemotesFolder
    u65.DataFolder = p63.DataFolder
    u65.DragonValue = p63.DragonValue
    u65.DragonId = p63.DragonId
    u65.FireValue = u65.DataFolder:WaitForChild("Fire")
    u65.BreathFuelValue = u65.FireValue:WaitForChild("BreathFuel")
    u65.ImpactModelValue = u65.FireValue:WaitForChild("ImpactModel")
    u65.TemporaryFireValue = u65.DataFolder:WaitForChild("TemporaryFire")
    u65.ElementValue = u65.DragonValue:WaitForChild("Type")
    u65.Maid:GiveTask(u65.MaxBreathCapacityValue:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 258]]
        --[[
        Upvalues:
            [1] = u65
            [2] = u6
        --]]
        local v67 = u65.BreathCapacity == u65.BreathFuelValue.Value
        u65.BreathCapacity = u65.MaxBreathCapacityValue.Value * 2
        if isServer then
            if v67 then
                u65.BreathFuelValue.Value = u65.BreathCapacity
                return
            end
            local v68 = u65.BreathFuelValue
            local v69 = u65.BreathFuelValue.Value
            local v70 = u65.BreathCapacity
            v68.Value = math.clamp(v69, 0, v70)
        end
    end))
    u65.BreathCapacity = u65.MaxBreathCapacityValue.Value * 2
    u65.MaxBreathDistance = u20 * u65.BreathScaleMultiplier
    p63.AttackRangeLimit = u65.MaxBreathDistance * 2
    if isServer then
        u57(u65)
    else
        u62(u65)
    end
    for _, v71 in pairs({ u65.TemporaryFireValue, u65.ElementValue }) do
        u65.Maid:GiveTask(v71:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 281]]
            --[[
            Upvalues:
                [1] = u65
            --]]
            u65:_setElement()
        end))
    end
    u65:_setElement()
    if not isServer then
        u65:_getImpactModel()
    end
    u65.Maid:GiveTask(function() --[[Anonymous function at line 291]]
        --[[
        Upvalues:
            [1] = u65
        --]]
        if u65.Destroy then
            u65:Destroy()
        end
    end)
    u26[u65.PrimaryPart] = u65
    return u65
end
function u1.Destroy(p72) --[[Anonymous function at line 302]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    p72._destroyed = true
    p72.Maid:Destroy()
    p72.ElementMaid:Destroy()
    u26[p72.PrimaryPart] = nil
    setmetatable(p72, nil)
end
function u1._getImpactModel(p73) --[[Anonymous function at line 311]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u4
    --]]
    if p73.ImpactModelValue.Value then
        p73.BreathImpactPart = p73.ImpactModelValue.Value:WaitForChild("ImpactPart")
        local v74 = p73.RaycastIgnoreList
        local v75 = p73.BreathImpactPart
        table.insert(v74, v75)
        p73.BreathHitSound = u25.BreathHit:Clone()
        p73.Beams = {}
        p73.SourceParticles = {}
        for v76, _ in pairs(p73.Heads) do
            if v76.Name == "Head" then
                p73.BreathHitSound.Parent = v76
            end
            p73.Beams[v76] = {}
            for _, v77 in pairs(v76:GetChildren()) do
                if v77:IsA("Beam") then
                    local v78 = p73.Beams[v76]
                    table.insert(v78, v77)
                end
            end
        end
        for v79, _ in pairs(p73.FireAttachments) do
            for _, v80 in pairs(v79:GetDescendants()) do
                if v80:IsA("ParticleEmitter") and u4:HasTag(v80, "BreathSourceParticle") then
                    local v81 = p73.SourceParticles
                    table.insert(v81, v80)
                end
            end
        end
    end
end
function u1._setElement(p82) --[[Anonymous function at line 351]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v83 = u9.GetElementFromName(p82.TemporaryFireValue.Value) or u9.GetElementFromName(p82.ElementValue.Value)
    if p82.ElementData ~= v83 then
        p82.ElementData = v83
        p82.ElementChangedSignal:Fire()
    end
end
function u1._toggleBeams(u84, p85) --[[Anonymous function at line 363]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
        [3] = u2
    --]]
    if not isServer then
        for _, v86 in pairs(u84.Beams) do
            for _, v87 in pairs(v86) do
                v87.Enabled = p85
            end
        end
        if u84.FireAttachmentTweens then
            for _, v88 in ipairs(u84.FireAttachmentTweens) do
                v88:Cancel()
            end
        end
        u84.FireAttachmentTweens = {}
        if u84.UpdateSourceAttachmentsConnection then
            u84.UpdateSourceAttachmentsConnection:Disconnect()
            u84.UpdateSourceAttachmentsConnection = nil
            for v89, _ in pairs(u84.FireAttachments) do
                if v89 and v89.Parent then
                    local v90 = u5:Create(v89, TweenInfo.new(1), {
                        ["Orientation"] = u84.FireAttachmentOrientations[v89] or v89.Orientation
                    })
                    local v91 = u84.FireAttachmentTweens
                    table.insert(v91, v90)
                    v90:Play()
                end
            end
        end
        if p85 then
            u84.UpdateSourceAttachmentsConnection = u2.Heartbeat:Connect(function() --[[Anonymous function at line 399]]
                --[[
                Upvalues:
                    [1] = u84
                --]]
                local v92 = u84.BreathImpactPart
                if v92 then
                    v92 = u84.BreathImpactPart:FindFirstChild("End")
                end
                if v92 then
                    v92 = v92.WorldPosition
                end
                if v92 then
                    for v93, _ in pairs(u84.FireAttachments) do
                        if v93 and v93.Parent then
                            if not u84.FireAttachmentOrientations[v93] then
                                u84.FireAttachmentOrientations[v93] = v93.Orientation
                            end
                            local v94 = (v92 - v93.WorldPosition).Unit
                            local v95 = -v94.X
                            local v96 = -v94.Z
                            local v97 = math.atan2(v95, v96)
                            local v98 = v94.Y
                            local v99 = math.asin(v98)
                            local v100 = math.deg(v97)
                            local v101 = math.deg(v99)
                            v93.WorldOrientation = Vector3.new(v101, v100, 0)
                        end
                    end
                end
            end)
        end
    end
end
function u1._toggleFX(p102, p103) --[[Anonymous function at line 431]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
    --]]
    if not isServer then
        for v104, _ in pairs(p102.Beams) do
            local v105 = v104:FindFirstChild("BreathSound", true)
            if v105 then
                if p103 then
                    u5:Create(v105, TweenInfo.new(v105:GetAttribute("TweenOn"), Enum.EasingStyle.Linear), {
                        ["Volume"] = v105:GetAttribute("MaxVolume")
                    }):Play()
                else
                    u5:Create(v105, TweenInfo.new(v105:GetAttribute("TweenOff"), Enum.EasingStyle.Linear), {
                        ["Volume"] = 0
                    }):Play()
                end
            end
        end
        for _, v106 in pairs(p102.SourceParticles) do
            v106.Enabled = p103
        end
        if p103 then
            for _, v107 in pairs(p102.BreathImpactPart:GetChildren()) do
                if v107:IsA("ParticleEmitter") and v107.Name:find("Smoke") then
                    v107.Enabled = true
                end
            end
        else
            for _, v108 in pairs(p102.BreathImpactPart:GetDescendants()) do
                if v108:IsA("ParticleEmitter") then
                    v108.Enabled = false
                end
            end
        end
        if not p103 then
            p102.LastBreathHit = nil
            u5:Create(p102.BreathHitSound, TweenInfo.new(p102.BreathHitSound:GetAttribute("TweenOff"), Enum.EasingStyle.Linear), {
                ["Volume"] = 0
            }):Play()
        end
    end
end
function u1.Fire(p109) --[[Anonymous function at line 488]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if p109.Firing then
        return
    elseif p109.BreathFuelValue.Value > 0 then
        p109.Firing = true
        if isServer or p109.IsLocalPlayer then
            p109.FireValue.Value = true
            if isServer and not p109.BreathImpactPart:GetNetworkOwner() then
                p109.BreathImpactPart:SetNetworkOwnershipAuto(false)
                p109.BreathImpactPart:SetNetworkOwner(p109.Player)
            end
        end
        if not isServer and p109.IsLocalPlayer then
            p109.BreathFireRemote:FireServer(true)
        end
        p109.CanFire = true
        if not isServer then
            p109:_updateMousePosition(true)
            local _ = p109.IsLocalPlayer
        end
        p109:_toggleBeams(true)
        p109:_toggleFX(true)
    end
end
function u1.Stop(p110, p111) --[[Anonymous function at line 534]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u22
        [3] = u28
    --]]
    p110.Firing = false
    p110.KeepFiring = p111
    p110.CanFire = false
    p110.AutoTarget = nil
    p110.LastMousePosition = nil
    p110.FireValue.Value = false
    if isServer or not p110.IsLocalPlayer then
        if isServer then
            p110:_resetBreathMetadata()
        end
    else
        p110.BreathFireRemote:FireServer(false)
        p110:_disableMotor()
        local v112 = u22.CurrentDragon
        if v112 then
            u28.getTilterForDragon(v112.DragonModel):SetHeadTarget(nil)
        end
    end
    p110:_toggleBeams(false)
    p110:_toggleFX(false)
end
function u1._trackBreath(p113) --[[Anonymous function at line 564]]
    p113.Metadata.LastUse = tick()
    p113.Metadata.LastStop = 9000000000
end
function u1._resetBreathMetadata(p114) --[[Anonymous function at line 569]]
    if p114.BreathFuelValue.Value > 0 then
        p114.Metadata.LastStop = tick()
    end
end
function u1._updateRegenAndCapacity(p115) --[[Anonymous function at line 575]]
    local v116 = p115.BreathFuelValue.Value
    local v117 = p115.BreathCapacity
    if p115.Firing and v116 > 0 then
        local v118 = v116 + -1
        p115.BreathFuelValue.Value = math.clamp(v118, 0, v117)
        p115.SetNextBreath = false
        if p115.BreathFuelValue.Value then
            p115.Metadata.LastStop = tick()
            if p115.BreathFuelValue.Value <= 0 then
                p115.SetNextBreath = true
                p115.DataFolder:SetAttribute("NextBreath", workspace:GetServerTimeNow() + p115.BreathRegenRateValue.Value)
            else
                p115.DataFolder:SetAttribute("NextBreath", -1)
            end
        end
    elseif v116 ~= v117 then
        if not (p115.Firing or p115.SetNextBreath) then
            p115.SetNextBreath = true
            p115.DataFolder:SetAttribute("NextBreath", workspace:GetServerTimeNow() + p115.BreathRegenRateValue.Value)
        end
        if tick() - p115.Metadata.LastStop >= p115.BreathRegenRateValue.Value then
            p115.BreathFuelValue.Value = p115.BreathCapacity
            p115.SetNextBreath = false
        end
    end
end
function u1._update(p119) --[[Anonymous function at line 610]]
    if p119._destroyed then
        return
    elseif p119.Firing then
        if p119.CanFire then
            if p119.BreathFuelValue.Value <= 0 then
                p119:Stop()
                return
            elseif p119.FireValue.Value then
                p119:_castRays()
                if p119.IsLocalPlayer then
                    p119:_updateMousePosition()
                    p119:_updateOverlay()
                end
            else
                p119:Stop()
            end
        else
            return
        end
    else
        if p119.IsLocalPlayer and (p119:_updateMousePosition() and p119.KeepFiring) then
            p119:Fire()
        end
        return
    end
end
function u1._clampPosition(p120, p121) --[[Anonymous function at line 648]]
    local v122 = (p121 - p120.PrimaryPart.Position).Unit
    local v123 = p120.PrimaryPart.Position
    local v124 = (p121 - p120.PrimaryPart.Position).Magnitude
    local v125 = p120.BaseMaxBreathDistance
    return v123 + v122 * math.min(v124, v125)
end
function u1._canKeepAutoTarget(p126) --[[Anonymous function at line 657]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    if p126.Firing then
        if u19.DragonBreathAttackPart then
            return true
        elseif p126.AutoTarget then
            if p126.AutoTarget.Destroy then
                if not (p126.AutoTarget.DeadValue and p126.AutoTarget.DeadValue.Value) then
                    if not p126.AutoTarget.PrimaryPart or p126.AutoTarget.PrimaryPart.Parent then
                        return true
                    end
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
function u1._getAutoTargetPosition(p127, p128) --[[Anonymous function at line 681]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u11
    --]]
    if u12.IsMobileInputType() then
        if not p127.AutoTarget then
            local v129 = p127.Firing and u11(p128)
            if v129 then
                p127.AutoTarget = v129
            end
        end
    else
        return
    end
end
function u1._getTargetPosition(p130) --[[Anonymous function at line 704]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    if p130:_canKeepAutoTarget() then
        if u19.DragonBreathAttackPart then
            return u19.DragonBreathAttackPart.Position
        elseif p130.AutoTarget._getTargetPosition then
            return p130.AutoTarget:_getTargetPosition()
        else
            return p130.AutoTarget.PrimaryPart.Position
        end
    else
        p130.AutoTarget = nil
        return p130.LastMousePosition
    end
end
function u1._interactingWithTouchPad(p131) --[[Anonymous function at line 722]]
    if p131.PlayerControls.activeController.moveTouchObject then
        return not p131.PlayerControls.activeController.moveTouchLockedIn or p131.PlayerControls.activeController.moveTouchStartPosition
    end
end
function u1._canAimAtPosition(p132, _) --[[Anonymous function at line 731]]
    local v133 = p132.Dragon.MoverClass:GetLookVector()
    local v134 = p132.Dragon.MoverClass:GetUpVector()
    local v135 = (p132.Position - p132.PrimaryPart.Position).Unit
    local v136 = v133:Dot(v135) >= -0.65
    local v137
    if v133:Dot(v135) >= -0.85 then
        local v138 = v134:Dot(v135)
        v137 = math.abs(v138) < 0.5
    else
        v137 = false
    end
    return v136 or v137
end
function u1._updateMousePosition(u139, p140) --[[Anonymous function at line 743]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u29
        [3] = u23
        [4] = u12
        [5] = u22
        [6] = u28
    --]]
    if u139.IsLocalPlayer then
        u139.BaseMaxBreathDistance = u139.MaxBreathDistance + (u139.Dragon.Flying and (u139.MaxBreathDistance * u19.FireBreathDistanceWhileFlyingMultiplier or 0) or 0)
        local v141 = u29
        local v142 = u139.BaseMaxBreathDistance
        local v143 = (u23.CFrame.p - u139.PrimaryPart.Position).Magnitude
        v141.MaxDistance = v142 + math.abs(v143)
        if u12.IsMobileInputType() then
            u29.OverridePosition = u23:WorldToViewportPoint((u23.CFrame * CFrame.new(0, 0, -u29.MaxDistance)).p)
        end
        u139.LastMousePosition = u29.Hit.p
        local v144 = u139:_clampPosition((u139:_getTargetPosition(u139.LastMousePosition)))
        u139.Position = v144
        if u139:_canAimAtPosition(u139.Position) then
            if u139.Firing then
                local v145 = u22.CurrentDragon
                u28.getTilterForDragon(v145.DragonModel):SetHeadTarget(u139.Position)
            end
            u139.BreathImpactPart.BP.Position = v144
            u139.BreathImpactPart.BG.CFrame = CFrame.new(Vector3.new(0, 0, 0), v144 - u29.UnitRay.Origin)
            if p140 then
                u139.BreathImpactPart.Position = v144
            end
            u139:_getAutoTargetPosition(u139.Position)
            return true
        end
        task.defer(function() --[[Anonymous function at line 769]]
            --[[
            Upvalues:
                [1] = u139
            --]]
            if u139.Firing then
                u139:Stop(u139.Firing)
            end
        end)
    end
end
function u1._setNewTarget(p146) --[[Anonymous function at line 795]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u21
    --]]
    local v147 = u11(u21:GetMouse().Hit.p)
    if v147 then
        p146.AutoTarget = v147
        p146:_updateMousePosition()
    end
end
function u1._updateOverlay(p148) --[[Anonymous function at line 804]]
    if not p148.Firing then
    end
end
function u1._iterateOverOrigins(p149, p150) --[[Anonymous function at line 822]]
    for v151, _ in pairs(p149.Heads) do
        p150(v151)
    end
end
function u1._castDamageRays(u152) --[[Anonymous function at line 828]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u19
        [3] = u8
    --]]
    if u152.IsLocalPlayer then
        if u152._nextHit <= tick() then
            local u153 = {}
            u152:_iterateOverOrigins(function(p154) --[[Anonymous function at line 839]]
                --[[
                Upvalues:
                    [1] = u152
                    [2] = u24
                    [3] = u153
                --]]
                for _ = 1, 10 do
                    local v155 = p154.Position
                    local v156 = u152.BreathImpactPart.Position
                    local v157 = u24:NextInteger(-5, 5)
                    local v158 = u24:NextInteger(-5, 5)
                    local v159 = u24
                    local v160 = v156 + Vector3.new(v157, v158, v159:NextInteger(-5, 5)) - v155
                    local v161 = Ray.new(v155, v160)
                    local v162 = workspace:FindPartOnRayWithIgnoreList(v161, u152.RaycastIgnoreList)
                    if v162 then
                        local v163 = u153
                        table.insert(v163, v162)
                    end
                end
            end)
            if u19.DragonBreathHitCallback then
                task.spawn(u19.DragonBreathHitCallback, u153)
            end
            local v164 = u8.GetEntitiesFromHits(u153, false)
            if #v164 > 0 then
                u152._nextHit = tick() + 0.5
                u8.RegisterHits("Breath", u152.Dragon, v164)
            end
        end
    else
        return
    end
end
function u1._enableMotor(p165, p166) --[[Anonymous function at line 875]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p165.ActiveVibrationMotor then
        u7("GamepadClient").SetVibration(p165.ActiveVibrationMotor, p166)
    else
        p165.ActiveVibrationMotor = u7("GamepadClient").StartVibration(Enum.VibrationMotor.RightTrigger, p166)
    end
end
function u1._disableMotor(p167) --[[Anonymous function at line 882]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p167.ActiveVibrationMotor then
        u7("GamepadClient").StopVibration(p167.ActiveVibrationMotor)
        p167.ActiveVibrationMotor = nil
    end
end
function u1._castVisualRays(u168) --[[Anonymous function at line 889]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    u168:_iterateOverOrigins(function(p169) --[[Anonymous function at line 891]]
        --[[
        Upvalues:
            [1] = u168
            [2] = u5
        --]]
        local v170 = p169.Position
        local v171 = (u168.BreathImpactPart.Position - v170) * 1.1
        local v172 = Ray.new(v170, v171)
        local v173, _, _ = workspace:FindPartOnRayWithIgnoreList(v172, u168.RaycastIgnoreList)
        if v173 then
            u168:_enableMotor(0.2)
            if not u168.LastBreathHit then
                u168.LastBreathHit = tick()
                u5:Create(u168.BreathHitSound, TweenInfo.new(u168.BreathHitSound:GetAttribute("TweenOn"), Enum.EasingStyle.Linear), {
                    ["Volume"] = u168.BreathHitSound:GetAttribute("MaxVolume")
                }):Play()
            end
        else
            u168:_enableMotor(0.025)
            if u168.LastBreathHit then
                u168.LastBreathHit = nil
                u5:Create(u168.BreathHitSound, TweenInfo.new(u168.BreathHitSound:GetAttribute("TweenOff"), Enum.EasingStyle.Linear), {
                    ["Volume"] = 0
                }):Play()
            end
        end
        for _, v174 in pairs(u168.BreathImpactPart.End:GetDescendants()) do
            if v174:IsA("ParticleEmitter") and v174.Name:find("HitObject") then
                v174.Enabled = v173 and true
            end
        end
    end)
end
function u1._castRays(p175) --[[Anonymous function at line 931]]
    p175:_castDamageRays()
    p175:_castVisualRays()
end
function u1.GetBreathFromPlayer(p176) --[[Anonymous function at line 936]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    return u26[p176]
end
if isServer then
    v10.spawnLoop(function() --[[Anonymous function at line 941]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        for _, v177 in pairs(u26) do
            v177:_updateRegenAndCapacity()
        end
    end, 0.5)
end
return u1