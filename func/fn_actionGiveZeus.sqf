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
                _target = _x;
            };
        };
    } forEach (units _group);
} forEach allGroups; 


if (isNull _target) then { 
    hint "Error: finding unit to give Zeus"; 
} else {
    if (isNull (getAssignedCuratorLogic _target)) then {
        hint format["Giving zeus to %1",name _target];
        [[_target],'tac1_admin_fnc_zeusServerMake',false] spawn BIS_fnc_MP;   
    } else {
        hint format["Can not give zeus to %1 (as they already have zeus)",name _target];
    }; 
};