disableSerialization;
private["_i","_control","_config","_title","_description","_subtitle"];
 _control = ((findDisplay 1895) displayCtrl 1550);
 _i = 0;
_config = missionconfigfile >> "CfgDebriefing";

while {_i < count _config} do {
    _title = getText (_config select _i >> "title");
    _description = getText (_config select _i >> "description");
    _subtitle = "";
    if (isClass (_config select _i >> "subtitle")) then {
        _subtitle = getText (_config select _i >> "subtitle");
    };
    
    if (_subtitle == "") then {
        _control lbAdd (format ["%1 - %2",_title,_description]); 
    } else {
        _control lbAdd (format ["%1 - %2 - %3",_title,_subtitle,_description]); 
    };
    _control lbSetData[_i,configName (_config select _i)];
    _i = _i + 1;
};

_control lbAdd "*** Arma 3 Vanilla Mission Success ***";
_control lbSetData[_i,"asdasdasdga"];