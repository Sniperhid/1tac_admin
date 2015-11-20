
//Set the admin IDs
tac1_adminIDs = ["76561197974275147",
				 "76561198006685090",
				 "76561197960707355"];


if (hasInterface) then {
    [] spawn {
        waitUntil {sleep 0.5; !isNull (findDisplay 46)};
        (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call tac1_admin_fnc_keyPressed"];
    };
};


// Check's what addons clients are running. If your community doesn't use battle-eye can be useful for doing a quick check.

// [] call tac1_admin_fnc_checkMods;
