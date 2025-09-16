local gui = require('gui')
local widgets = require('gui.widgets')

local Success = defclass(Success, widgets.Window)
Success.ATTRS{
    frame={w=60,h=11}, 
    frame_title='Success', 
    autoarrange_subviews=true, 
    autoarrange_gap=1, 
}

function Success:init()
    self:addviews{
        widgets.Label{text={{text="Plugin installed successfully!", pen=COLOR_WHITE}}},
        widgets.Label{text={{text="Please restart your game", pen=COLOR_LIGHTGREEN}}},
    }
end

local Failure = defclass(Failure, widgets.Window)
Failure.ATTRS{
    frame={w=60,h=11},  
    frame_title='Failure', 
    autoarrange_subviews=true, 
    autoarrange_gap=1, 
}

function Failure:init()
    self:addviews{
        widgets.Label{text={{text="Plugin failed to install or nonexistent!", pen=COLOR_LIGHTRED}}},
        widgets.Label{text={{text="Check the README.md or modpage.", pen=COLOR_YELLOW}}},
    }
end

local NotFound = defclass(NotFound, widgets.Window)
NotFound.ATTRS{
    frame={w=60,h=11},  
    frame_title='Not Found', 
    autoarrange_subviews=true, 
    autoarrange_gap=1, 
}

function NotFound:init()
    self:addviews{
        widgets.Label{text={{text="No matching files found!", pen=COLOR_LIGHTRED}}},
        widgets.Label{text={{text="Nothing was installed.", pen=COLOR_YELLOW}}},
    }
end

local Installed = defclass(Installed, widgets.Window)
Installed.ATTRS{
    frame={w=60,h=11},  
    frame_title='Already Installed', 
    autoarrange_subviews=true, 
    autoarrange_gap=1, 
}

function Installed:init()
    self:addviews{
        widgets.Label{text={{text="Plugin is already installed!", pen=COLOR_LIGHTGREEN}}},
        widgets.Label{text={{text="No action required.", pen=COLOR_WHITE}}},
    }
end

local NothingTo = defclass(NothingTo, widgets.Window)
NothingTo.ATTRS{
    frame={w=60,h=11},  
    frame_title='No mathces found', 
    autoarrange_subviews=true, 
    autoarrange_gap=1, 
}

function NothingTo:init()
    self:addviews{
        widgets.Label{text={{text="Nothing to uninstall!", pen=COLOR_YELLOW}}},
        widgets.Label{text={{text="No action performed.", pen=COLOR_WHITE}}},
    }
end

local Uninstalled = defclass(Uninstalled, widgets.Window)
Uninstalled.ATTRS{
    frame={w=60,h=11},  
    frame_title='Success', 
    autoarrange_subviews=true, 
    autoarrange_gap=1, 
}

function Uninstalled:init()
    self:addviews{
        widgets.Label{text={{text="Plugin successfully uninstalled!", pen=COLOR_RED}}},
        widgets.Label{text={{text="Please restart your game.", pen=COLOR_LIGHTGREEN}}},
    }
end

local Screen = defclass(Screen, gui.ZScreen)
Screen.ATTRS{ focus_path='plugin-hidden', mode='success' }

function Screen:init()
    local handlers = {
        success = function() self:addviews{Success{}} end,
        failure = function() self:addviews{Failure{}} end,
        notfound = function() self:addviews{NotFound{}} end,
        nothingto = function() self:addviews{NothingTo{}} end,
        installed = function() self:addviews{Installed{}} end,
        uninstalled = function() self:addviews{Uninstalled{}} end,
    }

    local handler = handlers[self.mode]
    if handler then
        handler()
    else
        qerror("Unknown mode: "..tostring(self.mode))
    end
end

function Screen:onDismiss() view = nil end

local function show(mode)
    view = view and view:raise() or Screen{mode=mode or 'success'}:show()
end

return { show = show }
