disableSerialization;
private _control = ((findDisplay 1895) displayCtrl 1550);
private _value = _control lbData( lbCurSel _control);

if (_value isEqualTo "HARD_MISSION_END") then {
    [["HARD_MISSION_END",false] ,"BIS_fnc_endMission",true] call BIS_fnc_MP;
} else {
    [_value ,"BIS_fnc_endMission",true] call BIS_fnc_MP;
};
