#include "modules/Gui.h"
#include "modules/Screen.h"
#include "PluginManager.h"
#include "DataDefs.h"

using namespace DFHack;

DFHACK_PLUGIN("shmurda");

DFhackCExport command_result plugin_init(color_ostream& out, std::vector<PluginCommand>& commands)
{
    commands.push_back(
        PluginCommand(
            "installed_plugin(mod)",
            "Shows a announcement.",
            [](color_ostream& out, std::vector<std::string>& params) -> command_result
            {
                df::coord pos{ 0,0,0 };
                std::string text = "made by KlibbigAfgan/Maneki";
                int color = COLOR_GREEN;
                bool isBright = true;


                Gui::showZoomAnnouncement(df::enums::announcement_type::REACHED_PEAK, pos, text, color, isBright);

                out.print("made by KlibbigAfgan/Maneki\n");
                return CR_OK;
            }
        )
    );

    df::coord pos{ 0,0,0 };
    std::string text = "Shmurda plugin loaded!";
    int color = COLOR_YELLOW;
    bool isBright = true;


    Gui::showZoomAnnouncement(df::enums::announcement_type::REACHED_PEAK, pos, text, color, isBright);

    return CR_OK;
}

DFhackCExport command_result plugin_shutdown(color_ostream& out)
{
    return CR_OK;
}
