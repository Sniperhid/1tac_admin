
if (isServer) then {
	diag_log format["[ADMIN MESSAGE] %1",_this];
};

if (!hasInterface) exitWith {};

private _localID = [] call tac1_admin_local_uid;

if (isServer or (_localID in ([] call tac1_adminIDs)) or (serverCommandAvailable "#kick")) then {
	systemChat _this;
};
