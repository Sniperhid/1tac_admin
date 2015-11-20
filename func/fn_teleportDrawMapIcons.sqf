disableSerialization;
private["_name","_icon","_color"];
params["_fullmapWindow"];

if (isNil "f_cam_blufor_color") then {
    f_cam_blufor_color = [blufor] call bis_fnc_sideColor;
    f_cam_opfor_color = [opfor] call bis_fnc_sideColor;
    f_cam_indep_color = [independent] call bis_fnc_sideColor;
    f_cam_civ_color = [civilian] call bis_fnc_sideColor;
    f_cam_empty_color = [sideUnknown] call bis_fnc_sideColor;
};

{
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

//Map Markers - Credit AACO
{
    _markerShape = markerShape _x;
    _markerPos = getMarkerPos _x;
    _markerSize = getMarkerSize _x;
    _markerColor = (configfile >> "CfgMarkerColors" >> getMarkerColor _x >> "color") call BIS_fnc_colorConfigToRGBA;
    _markerDir = markerDir _x;
    
    switch (_markerShape) do {
        case "RECTANGLE": {
            _markerBrush = getText (configfile >> "cfgMarkerBrushes" >> markerBrush _x >> "texture"); 
            _fullmapWindow drawRectangle [_markerPos, _markerSize select 0, _markerSize select 1, _markerDir, _markerColor, _markerBrush]
        };
        case "ELLIPSE": {
            _markerBrush = getText (configfile >> "cfgMarkerBrushes" >> markerBrush _x >> "texture"); 
            _fullmapWindow drawEllipse  [_markerPos, _markerSize select 0, _markerSize select 1, _markerDir, _markerColor, _markerBrush]
        };
        case "ICON": {
            _markerType = getMarkerType _x;
            if (_markerType != "Empty") then {
                _multiplier = 20;
                _markerIcon = getText (configfile >> "CfgMarkers" >> _markerType >> "icon");
                _markerText = markerText _x;
                _fullmapWindow drawIcon [_markerIcon, _markerColor, _markerPos, (_markerSize select 0) * _multiplier, (_markerSize select 1) * _multiplier, _markerDir, _markerText, 1];
            };
        };
    };    
} forEach allMapMarkers;