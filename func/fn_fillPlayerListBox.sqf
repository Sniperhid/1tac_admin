 // Fill list with the players
disableSerialization;

private _control = ((findDisplay 1888) displayCtrl 1500);
private _i = 0;
{
    private _group = _x;
    private _addGroup = false;
    {
        if (isPlayer _x) then {
            if (!_addGroup) then {
                _i = _control lbAdd (format["%1 - %2",groupID _group,name _x]);
                _addGroup = true;
            } else {
                _i =_control lbAdd (format["        %1",name _x]);  
            };
            _control lbSetData[_i,""+getPlayerUID _x];

            private _factionImg = getText (configfile >> "CfgFactionClasses" >> (faction _x) >> "icon");
            if (_factionImg != "") then {
                _control lbSetPicture[_i,_factionImg];
                _control lbSetPictureColor [_i, [1,1,1,0.7]];
				_control lbSetPictureColorSelected [_i,[1,1,1,1]];
            };
            private _classIcon = "";
            if (leader _group isEqualTo _x) then {
                _classIcon = "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";
            } else {
                _classIcon = getText (configFile >> "CfgVehicleIcons" >> getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "icon"));
            };
            if (_classIcon != "") then {
                _control lbSetPictureRight [_i,_classIcon];

                private _color = [1,1,1,0.7];
                switch (assignedTeam _x) do {
                  case "RED": {_color = [1,0,0,0.85]};
                  case "GREEN": {_color = [0,1,0,0.85]};
                  case "BLUE": {_color = [0,0,1,0.85]};
                  case "YELLOW": {_color = [1,1,0,0.85]};
                };

                _control lbSetPictureRightColor [_i, _color];
                _color set [3,1];
                _control lbSetPictureRightColorSelected [_i, _color];
            };
        };
    } forEach (units _group);
} forEach allGroups;