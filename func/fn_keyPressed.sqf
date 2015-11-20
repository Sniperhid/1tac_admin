params["","_key","_shift"];

if (not (_key isEqualTo 59 && _shift)) exitWith {false};

closeDialog 0;
if (!alive player && !(isNil "f_fnc_forceExit")) then {
	[] call f_fnc_forceExit;
};

if (isServer or ((getPlayerUID player) in tac1_adminIDs) or (serverCommandAvailable "#kick")) then {
    createDialog 'adminMenuDialog';
} else {
    hint "You are not logged in as an admin.";
};
true