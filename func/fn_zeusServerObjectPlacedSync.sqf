private["_curator","_placed"];
_curator = _this select 0;
_placed = _this select 1;
{   
    if (_x getVariable ["SNIP_ADMIN",false]) then {
        _x addCuratorEditableObjects [[_placed],true];
    };
} forEach (allCurators);
nil   