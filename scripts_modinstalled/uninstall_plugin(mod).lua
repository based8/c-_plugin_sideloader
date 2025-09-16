local sysos = dfhack.getOSType()
local fs = dfhack.filesystem

local script_mothership = debug.getinfo(1, "S")
local script_path = script_mothership.source:sub(2)  
local modui_folder_path = script_path:match("(.*/)")
local modui = dofile(modui_folder_path.."/internal/gui_messages.lua")

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
local plugins_path = DFpath.."hack/plugins"


local mod_path = base_path.."/mods/plugin_sideloader/plugins" -- change this to your mods dir

function  unload_plugins()

    if sysos == "windows" then
        extension = ".plug.dll"
    else
        extension = ".plug.so"
    end

    local files = fs.listdir(mod_path) 
    printall(files)
    for index, file in pairs(files) do -- this shit will check if the plugin is in the modfolder. if its in the mod folder it will delete the other plugin from the game
        if file:sub(-#extension) == extension then         
            dfhack.run_command("unload shmurda") -- this is specific to your plugin name which should be the file name
            if file_exists(plugins_path.."/"..file) and os.remove(plugins_path.."/"..file) then
                
                print("The following file has been uninstalled: "..file)
                plugin_found = true  -- im not lazy its 4am
            end
        end
    end
    if plugin_found then
        modui.show("uninstalled")        
    else
        modui.show("nothingto")
    end
end

unload_plugins()