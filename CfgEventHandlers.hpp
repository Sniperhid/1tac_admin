
class Extended_PreInit_EventHandlers {
    class tac1_admin_menu {
        init = " call compile preprocessFileLineNumbers '\1tac_admin\XEH_preInit.sqf';";
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayMission {
        tac1_admin_menu_keyHandler = "(_this select 0) displayAddEventHandler ['KeyDown', '_this call tac1_admin_fnc_keyPressed'];";  
    };
};