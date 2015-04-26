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
            if (_value == ("" + (getPlayerUID _x))) then {
                _target = _x;
            };
        };
    } forEach (units _group);
} forEach allGroups; 


if (_target == objNull) exitWith{ hint "Error: finding unit to teleport"; };  


titleText [format ["Click On The Map To Teleport %1",(name _target)], "PLAIN DOWN"]; titleFadeOut 7;
am_plMapClickEvent=
{
    //onMapSingleClick hint format ["Teleported To @\n%1" ,_pos];

    _pos1 =  [(_pos select 0), (_pos select 1), 0];  // 0 is the height on which you tele too 
    (_this select 0) setPos _pos1;				
    hint format ["%1 was teleported.",name (_this select 0)];

    onMapSingleClick "";
    openMap [false, false];
    createDialog 'playerListDialog';
};

openMap [true, false];
adminplayerlist_teleport_target = _target;
onMapSingleClick "[adminplayerlist_teleport_target] call am_plMapClickEvent";