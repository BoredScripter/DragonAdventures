
local loaded = false;

return function ()
    -- Make sure we dont load this code again under
    if loaded then return end
    loaded = true;

    local ReplicatedStorage = game:GetService('ReplicatedStorage')
    local targetRemote = ReplicatedStorage
        :WaitForChild('Remotes')
        :WaitForChild('MobProjectileDamageRemote')

    local oldNamecall
    oldNamecall = hookmetamethod(game, '__namecall', function(self, ...)
        local method = getnamecallmethod()

        if self == targetRemote and method == 'FireServer' and _G.Godmode then
            warn('Blocked MobProjectileDamageRemote:FireServer call.')
            return -- block the call entirely
        end

        return oldNamecall(self, ...)
    end)
end