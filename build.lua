local module_dir = "modules"
local entry_point = "main.lua"

-- Output both in Zenith workspace and in root project folder
local output_file_workspace = "C:/Users/Oskar/AppData/Roaming/Zenith/Workspace/output.lua"
local output_file_root = "output.lua"

local lfs = require("lfs") -- LuaFileSystem (or write your own dir reader if you want it pure)

-- Collect all .lua files in modules/
local module_files = {}
local function collect_modules(dir, base)
    base = base or ""
    for file in lfs.dir(dir) do
        if file ~= "." and file ~= ".." then
            local full_path = dir .. "/" .. file
            local attr = lfs.attributes(full_path)
            if attr.mode == "directory" then
                collect_modules(full_path, base .. file .. ".")
            elseif file:match("%.lua$") then
                local name = base .. file:gsub("%.lua$", "")
                table.insert(module_files, {name = name, path = full_path})
            end
        end
    end
end

collect_modules(module_dir)

-- Read file contents
local function readfile(path)
    local f = io.open(path, "r")
    assert(f, "Failed to open " .. path)
    local content = f:read("*a")
    f:close()
    return content
end

-- Generate the full output script string once
local function generate_output()
    local buffer = {}
    table.insert(buffer, "-- Auto-generated script\n\n")

    -- Inject fake require system
    table.insert(buffer, [[
local __modules = {}
local __require = function(name)
    local mod = __modules[name]
    if mod then
        local ok, result = xpcall(mod, function(err)
            return debug.traceback("Error in module '" .. name .. "':\n" .. tostring(err), 2)
        end)
        if not ok then
            error(result, 2)
        end
        return result
    else
        error("Module '" .. name .. "' not found.", 2)
    end
end

]])

    -- Add modules
    for _, mod in ipairs(module_files) do
        table.insert(buffer, string.format("__modules[%q] = function()\n", mod.name))
        local code = readfile(mod.path)
        table.insert(buffer, code .. "\nend\n\n")
    end

    -- Entry point
    local main_code
    local f = io.open(entry_point, "r")
    if f then
        main_code = f:read("*a")
        f:close()
        if main_code:match("^%s*$") then
            print("⚠️  Warning: Entry point '" .. entry_point .. "' is empty.")
        end
    else
        print("⚠️  Warning: Entry point file '" .. entry_point .. "' not found.")
        main_code = "-- Entry point missing\n"
    end

    table.insert(buffer, "-- Entry Point\n")
    table.insert(buffer, main_code .. "\n")

    return table.concat(buffer)
end

-- Write to both destinations
local final_output = generate_output()

for _, path in ipairs({output_file_workspace, output_file_root}) do
    local out = io.open(path, "w")
    assert(out, "Failed to write to " .. path)
    out:write(final_output)
    out:close()
    print("✅ Output written to: " .. path)
end
