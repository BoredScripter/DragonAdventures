local RequestTask = {}

local curTask = nil
local taskIdCounter = 0
local completedTasks = {}

-- Task factory
local function CreateTask(name, priority)
    taskIdCounter += 1
    return {
        id = taskIdCounter,
        name = name,
        priority = priority,
        abandoned = false
    }
end

function RequestTask.Request(name, priority, callback)
    if not curTask or priority > curTask.priority then
        if curTask then
            curTask.abandoned = true
        end

        local newTask = CreateTask(name, priority)

        curTask = newTask

        task.spawn(function()
            -- new task is also the self task under here since curTask could have been changed in runtime while under running
            local success, err = xpcall(callback, debug.traceback)

            if success and not newTask.abandoned and curTask.id == newTask.id then
                completedTasks[#completedTasks + 1] = newTask.name
                curTask = nil
            elseif not success then
                warn("[RequestTask] Error in task '" .. newTask.name .. "': " .. err)
                if curTask and curTask.id == newTask.id then
                    curTask = nil
                end
            end
        end)
    end
end

function RequestTask.GetCompletedTasks()
    return completedTasks
end

function RequestTask.GetCurrentTask()
    return curTask
end

return RequestTask
