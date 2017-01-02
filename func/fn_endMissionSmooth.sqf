disableSerialization;
private _control = ((findDisplay 1895) displayCtrl 1550);
private _value = _control lbData( lbCurSel _control);

private _endMissionFunc = "BIS_fnc_endMission";

if (!isNil "tmf_common_fnc_endMission") then { _endMissionFunc = "tmf_common_fnc_endMission"; };

if (_value isEqualTo "HARD_MISSION_END") then {
    [["HARD_MISSION_END",false],_endMissionFunc,true] call BIS_fnc_MP;
} else {
    [_value,_endMissionFunc,true] call BIS_fnc_MP;
};
