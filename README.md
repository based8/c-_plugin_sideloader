# c-_plugin_sideloader
## Sideloader for C++ plugins for DFhack

In the scripts_modinstalled folder you will find the interface for the plugin loader. Thats the dfhack script from where you load your plugins ------
In the plugins folder you will find a simple plugin (plug.dll for windows and plug.so) The linux version is a empty file cause i didnt bother cross-compiling :)

## Source code and compilation 

In the src folder you will find the source code for the shmurda plugin in the plugins folder.
To compile the plugin yourself i reccomend getting the DFhack source code to compile the dfhack libraries and link them in your plugin. What i did is i added the plugin where the other plugins were and just added it to the cmake file and rebuilt the whole thing

i might make a tutourial for how to compile and create dfhack plugins like this on my YouTube or a guide here
