// round up local mods

if (!isMultiplayer) exitWith {};

// Mod | Version
private ["_mods","_version"];
_mods = [];
_mods resize (count activatedAddons);

{
    _version = parseNumber (getText (configFile >> "CfgPatches" >> (_x) >> "version"));
    _mods set [_forEachIndex,[_x,_version]];
} forEach activatedAddons;


if (isServer) then {
	tac1_serverAddons = _mods;
    publicVariable "tac1_serverAddons";
} else {
	tac1_clientAddons = _mods;
	
	[] spawn {
		waitUntil{uiSleep 1; !isNil "tac1_serverAddons"};
		private ["_overlap","_extraAddons","_clientEntry","_missingAddons","_message"];
		
                
        _overlap = (tac1_clientAddons arrayIntersect tac1_serverAddons);
        _extraAddons = tac1_clientAddons - _overlap;
        _missingAddons = tac1_serverAddons - _overlap;
				
		uiSleep 2;
		if (count _missingAddons > 0) then {
            if (count _missingAddons > 20) then { _missingAddons deleteRange [20,(count _missingAddons - 1)]; };
			_message = format["[MOD MISMATCH][CLIENT IS MISSING] Player: %1 : %2",profileName,str _missingAddons];
			[_message,'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;
			//systemChat _message;
		};
		
		if (count _extraAddons > 0) then {
            if (count _extraAddons > 20) then { _extraAddons deleteRange [20,(count _extraAddons - 1)]; };
			_message = format["[MOD MISMATCH][CLIENT HAS EXTRA] Player: %1 : %2",profileName,str _extraAddons];
			[_message,'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;
			//systemChat _message;
		};
        
		[format['[MODS] %1 : checks complete',profileName],'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;
	};
};
