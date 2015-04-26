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
            if (_value == ("" + (getPlayerUID _x))) then {
                _target = _x;
            };
        };
    } forEach (units _group);
} forEach allGroups; 


if (_target == objNull) exitWith{ hint "Error: finding unit to teleport"; };  



titleText [format ["Click On The Map To Teleport %1 and their group",(name _target)], "PLAIN DOWN"]; titleFadeOut 7;
am_grp_plMapClickEvent=

    {
        //onMapSingleClick hint format ["Teleported To @\n%1" ,_pos];

        _pos1 =  [(_pos select 0), (_pos select 1), 0];  // 0 is the height on which you tele too 
        (_this select 0) setPos _pos1;				
        hint format ["%1 and their group was teleported.",name (_this select 0)];

        _group = group (_this select 0);
        {
            if (_x != (_this select 0)) then {
              _pos1 set [1,(_pos1 select 1)+1.2];
              _x setPos _pos1;  
            };
        } forEach (units _group);

        onMapSingleClick "";
        openMap [false, false];
        createDialog 'playerListDialog';
    };

openMap [true, false];
adminplayerlist_teleport_target = _target;
onMapSingleClick "[adminplayerlist_teleport_target] call am_grp_plMapClickEvent";