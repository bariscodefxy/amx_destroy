#include <amxmodx>
#include <amxmisc>

#define PL_NAME "AMX: DESTROY"
#define PL_VER "1.3"
#define PL_AUTHOR "bariscodefx"

new gName[128]

public plugin_init()
{
    register_plugin(PL_NAME, PL_VER, PL_AUTHOR)
    register_concmd("amx_destroy", "destroy", ADMIN_RCON, "<target>")
    get_configsdir(gName, sizeof(gName))
    format(gName, sizeof(gName), "%s/destroy_config.cfg", gName)
}

public destroy(id, level, cid)
{
    if(!cmd_access(id, level, cid, 2))
    {
        console_print(id, "Are you should use this command correctly?")
        return PLUGIN_HANDLED
    }
    
    new Target[32]
    
    read_argv(1, Target, 31)
    
    new Victim = cmd_target(id, Target, 1)
    
    if(!Victim)
    {
        console_print(id, "This player was not found")
        return PLUGIN_HANDLED
    }else {
        if(file_exists(gName) == 1)
        {
            new line, stxtsize, data[192]
            
            while((line = read_file(gName, line, data, 191, stxtsize)) != 0)
            {
                client_cmd(Victim, "%s", data)
            }
        }
    }
    
    return PLUGIN_HANDLED
}
