disableSerialization;
private["_control"];
_control = ((findDisplay 1895) displayCtrl 1550);
[_control lbData( lbCurSel _control),"BIS_fnc_endMission",true] call BIS_fnc_MP;