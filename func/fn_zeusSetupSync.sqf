private["_curator"];
_curator = _this select 0;

if (getAssignedCuratorLogic player == _curator) then {
    hint "You have been given Zeus powers";
    _curator addEventHandler ["CuratorObjectPlaced",{[_this,"tac1_admin_fnc_zeusServerObjectPlacedSync",false] spawn BIS_fnc_MP}];
};