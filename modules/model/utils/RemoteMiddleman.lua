local RemoteMiddleman = {}

local cooldownTime = 0
local debounce = false
local queueList = {}

-- Internal function to process the next item in the queue
local function processQueue()
    if debounce or #queueList == 0 then
        return
    end

    debounce = true
    local nextCallback = table.remove(queueList, 1)
    task.spawn(nextCallback)

    task.delay(cooldownTime, function()
        debounce = false
        processQueue() -- Automatically process the next item
    end)
end

function RemoteMiddleman.RequestFire(remote, queue, callback)
    if not debounce then

        debounce = true
        task.spawn(callback)

        task.delay(cooldownTime, function()
            debounce = false
            processQueue()
        end)

        return true
    elseif queue then
        print("Request denied but is queable so adding to queulist", remote)
        table.insert(queueList, callback)
        return true
    else
        return false
    end
end

return RemoteMiddleman
