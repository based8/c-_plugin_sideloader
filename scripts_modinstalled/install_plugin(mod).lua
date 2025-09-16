local sysos = dfhack.getOSType()
local fs = dfhack.filesystem

local script_mothership = debug.getinfo(1, "S")
local script_path = script_mothership.source:sub(2)  
local modui_folder_path = script_path:match("(.*/)")
local modui = dofile(modui_folder_path.."/internal/gui_messages.lua")

function copy_files(source, target)
    local infile = io.open(source, "rb")
    if not infile then
        error("cannot open source file: " .. source)
        modui.show("failure")
    end

    local data = infile:read("*a")

    local outfile = io.open(target, "wb")
    if not outfile then 
        error("Cannot open target file: " .. target)
        modui.show("failure")
    end

    outfile:write(data)
    outfile:close()
end

local function file_exists(path)
    local file = io.open(path, "rb")
    if file then
        file:close()
        return true 
    else
        return false
    end
end

local DFpath = fs.getInstallDir()
local base_path = fs.getBaseDir()
local plugins_path = DFpath.."/hack/plugins"


local mod_path = base_path.."/mods/plugin_sideloader/plugins" -- change this to your mods dir


function  load_plugins()

    if sysos == "windows" then
        extension = ".plug.dll"
    else
        extension = ".plug.so"
    end

    local files = fs.listdir(mod_path)
    for index, file in pairs(files) do
        if file:sub(-#extension) == extension then 
            if not file_exists(plugins_path.."/"..file) then
                print("The following file will be installed: "..file)
                copy_files(mod_path.."/"..file, plugins_path.."/"..file)
                plugin_found = true
            else
                modui.show("installed")
            end
        end
    end
    if not plugin_found then
        modui.show("notfound")
    else
        modui.show("success")
    end
end



load_plugins()








