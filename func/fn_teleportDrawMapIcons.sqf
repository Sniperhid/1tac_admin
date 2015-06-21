disableSerialization;
private["_pos","_y","_x1","_name","_icon","_color","_fullmapWindow"];

_fullmapWindow = _this select 0;

if (isNil "f_cam_blufor_color") then {
    f_cam_blufor_color = [blufor] call bis_fnc_sideColor;
    f_cam_opfor_color = [opfor] call bis_fnc_sideColor;
    f_cam_indep_color = [independent] call bis_fnc_sideColor;
    f_cam_civ_color = [civilian] call bis_fnc_sideColor;
    f_cam_empty_color = [sideUnknown] call bis_fnc_sideColor;
};

{
	_pos = getPos _x;
	_x1 = _pos select 0;
	_y = _pos select 1;
	if(alive _x) then {
		_name = "";
		if(isPlayer _x) then {_name = name _x};
		if(leader _x == _x && {isPlayer _x} count units _x > 0) then {_name = format["%1 - %2",toString(toArray(groupID (group _x)) - [45]),_name]};
		if(vehicle _x != _x && crew (vehicle _x) select 0 == _x || vehicle _x == _x) then
		{
			_icon = (vehicle _x getVariable ["f_cam_icon",""]);
			if(_icon == "") then {_icon = gettext (configfile >> "CfgVehicles" >> typeOf (vehicle _x) >> "icon");vehicle _x setVariable ["f_cam_icon",_icon]};
            _color = switch (side _x) do {
                case blufor: {f_cam_blufor_color};
                case opfor: {f_cam_opfor_color};
                case independent: {f_cam_indep_color};
                case civilian: {f_cam_civ_color};
                default {f_cam_empty_color};
            };
			_fullmapWindow drawIcon [_icon,_color,getPos _x,19,19,getDir (vehicle _x),_name,1];
		};
	};
} forEach allUnits;