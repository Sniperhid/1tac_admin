
private _enableDebugConsole = 
// 0 - not allowed
// 1 - allowed for server host and logged in admin
// 2 - allowed always
[
	"DebugConsole", 
	getMissionConfigValue ["enableDebugConsole", 0]
]
call (missionNamespace getVariable "BIS_fnc_getParamValue");

// IN ANY MODE
if (_enableDebugConsole isEqualTo 2 || isServer) exitWith {true};

private _localID = [] call tac1_admin_local_uid;
if ((_localID in ([] call tac1_adminIDs)) or (serverCommandAvailable "#kick")) exitWith { true };

false

