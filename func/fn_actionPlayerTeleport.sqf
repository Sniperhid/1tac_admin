disableSerialization;
private["_control","_value","_target"];
_control = ((findDisplay 1888) displayCtrl 1500);
if ((lbCurSel _control) == -1) exitWith{ hint "No unit was selected";};

_value = _control lbData (lbCurSel _control);
closeDialog 1888;
_target = objNull;

{
    _group = _x;
    {
        if (isPlayer _x) then {
            if (_value isEqualTo ("" + (getPlayerUID _x))) exitWith {
                _target = _x;
            };
        };
    } forEach (units _group);
} forEach allGroups; 


if (_target == objNull) exitWith{ hint "Error: finding unit to teleport"; };  


adminMenu_teleportTarget = _target;
titleText [format ["Click On The Map To Teleport %1",(name _target)], "PLAIN DOWN"]; titleFadeOut 7;
closeDialog 1889; //close current dialog
createDialog "adminMenuMapDialog";