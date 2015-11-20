disableSerialization;
_mapCtrl = ((findDisplay 1949) displayCtrl 26902);//_this select 0;//
_target = missionNamespace getVariable ["adminMenu_teleportTarget",objNull];

//start with 0
_pos = [0,0,0];

//Figure out my pos
if (alive player && !(player isKindOf "VirtualCurator_F")) then {
  _pos = getPos player;  
} else {
    if (count playableUnits > 0) then {
        _pos = getPos (playableUnits select 0);
    } else {
        if (count allUnits > 0) then {
            _pos = getPos (allUnits select 0);
        };
    };                          
};

//Overide with selections.
if ((typeName _target) isEqualTo "GROUP") then {
    if ((count units _target) > 0) then {
        _pos = getPos ((units _target) select 0);
    };
} else { // is Unit
    if (!isNull _target) then {
        _pos = getPos _target;  
    };
};

_mapCtrl ctrlMapAnimAdd [0, 0.1, _pos]; 
ctrlMapAnimCommit _mapCtrl;