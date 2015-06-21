private ["_key","_shift"];

_key = _this select 1;
_shift = _this select 2;

if (not (_key isEqualTo 59 && _shift)) exitWith {false};

closeDialog 0;
if (!alive player && !(isNil "f_fnc_forceExit")) then {
 [] call f_fnc_forceExit;
};

if (isServer or ((getPlayerUID player) in ["76561197974275147","76561198006685090","76561197960707355"]) or (serverCommandAvailable "#kick")) then {
    createDialog 'adminMenuDialog';
} else {
    hint "You are not logged in as an admin.";
};
true