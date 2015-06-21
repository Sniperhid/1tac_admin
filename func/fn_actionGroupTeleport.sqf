disableSerialization;
_control = ((findDisplay 1888) displayCtrl 1500);
if ((lbCurSel _control) == -1) exitWith{ hint "No unit was selected";};

_value = _control lbData (lbCurSel _control);
closeDialog 1888;
_target = objNull;

{
    _group = _x;
    {
        if (isPlayer _x) then {
            if (_value isEqualTo ("" + (getPlayerUID _x))) then {
                _target = _group;
            };
        };
    } forEach (units _group);
} forEach allGroups; 


if (_target == grpNull) exitWith{ hint "Error: finding group to teleport"; };  

adminMenu_teleportTarget = _target;

titleText [format ["Click on the map to teleport %1 and their group",(name (leader _target))], "PLAIN DOWN"]; titleFadeOut 7;
closeDialog 1889; //close current dialog
createDialog "adminMenuMapDialog";



