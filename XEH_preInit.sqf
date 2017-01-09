
tac1_admin_local_uid = {""};

[{!isNull player}, {
    tac1_admin_local_uid = compileFinal ("{'" + (getPlayerUID player) + "'}");
}, []] call CBA_fnc_waitUntilAndExecute;


//Set the admin IDs
tac1_adminIDs = compileFinal '[
	"76561197974275147",
	 "76561198006685090",
	 "76561197960707355",
	 "76561198008241201",
	 "76561198031183429",
	 "76561198010479904"
]';

// --- GetPlayerUID ---
// Snippers
// Delta
// Ferit
// Luk
// Nick
// Sam

// 102 
/*tac1_adminIDs = ["76561197999982850",
	"76561198085630904",
	"76561198052753514",
	"76561198085797657"];*/

if (hasInterface) then {
	if (!isNil "TMF_event_fnc_addEventHandler") then {
		["tmf_spectator_keyDown",{_this call tac1_admin_fnc_keyPressed}] call TMF_event_fnc_addEventHandler;
	};
    [] spawn {
        waitUntil {uiSleep 0.5; !isNull (findDisplay 46)};
        (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call tac1_admin_fnc_keyPressed"];
    };
};


// Check's what addons clients are running. If your community doesn't use battle-eye can be useful for doing a quick check.

// [] call tac1_admin_fnc_checkMods;
