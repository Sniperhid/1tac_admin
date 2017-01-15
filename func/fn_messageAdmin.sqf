
if (isServer) then {
	diag_log format["[ADMIN MESSAGE] %1",_this];
};

if (!hasInterface) exitWith {};

if (isServer or (_localID in ([] call tac1_adminIDs)) or (serverCommandAvailable "#kick")) then {
	systemChat _this;
};
