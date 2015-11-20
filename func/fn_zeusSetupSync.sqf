params["_curator"];

fn_tac1_admin_zeus_placed = {
	params["","_placed"];

    [_this,"tac1_admin_fnc_zeusServerObjectPlacedSync",false] spawn BIS_fnc_MP;
    
    if (local _placed) then {
        if({!isNil _x} count ["f_param_AISkill_BLUFOR","f_param_AISkill_INDP","f_param_AISkill_OPFOR"] > 0) then {
            {
                [_x] call f_fnc_setAISkill;
            } forEach crew (_placed);
        };
    };
};


if (getAssignedCuratorLogic player == _curator) then {
    hint "You have been given Zeus powers";
    _curator addEventHandler ["CuratorObjectPlaced",{_this call fn_tac1_admin_zeus_placed}];
};