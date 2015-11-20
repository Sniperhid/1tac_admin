
if (isServer) then {
	diag_log format["[ADMIN MESSAGE] %1",_this];
};

if (!hasInterface) exitWith {};

if (((getPlayerUID player) in tac1_adminIDs) or (serverCommandAvailable "#kick")) then {
	systemChat _this;
};