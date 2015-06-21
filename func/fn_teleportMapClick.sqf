private["_x","_y","_type","_fullmapWindow","_pos","_target"];
_fullmapWindow = _this select 0;
_type = _this select 1;
_x = _this select 2;
_y = _this select 3;

if (_type == 0) then { // left click
	// teleport the unit.
	
	_target = adminMenu_teleportTarget;
	_pos =  _fullmapWindow posScreenToWorld [_x,_y];  // 0 is the height on which you tele too 


	if ((typeName _target) isEqualTo "GROUP") then {
		_group = _target;
		{
			_pos set [1,(_pos select 1)+1.2];
			_x setPos _pos;  
		} forEach (units _group);
		 hint format ["%1 and their group was teleported.",name (leader _group)];
	} else { // is Unit
		_target setPos _pos;
		hint format ["%1 was teleported.",(name _target)];
	};
	
    closeDialog 1949;
};