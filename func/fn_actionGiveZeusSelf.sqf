if (isNull (getAssignedCuratorLogic player)) then {
    [[player],'tac1_admin_fnc_zeusServerMake',false] spawn BIS_fnc_MP;
} else {
    hint "You already have Zeus powers, therefore we can not give you Zeus powers again";
};