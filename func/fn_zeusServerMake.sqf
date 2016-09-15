if !(isServer) exitWith {};

params["_unit"];

if (isNull _unit) exitWith {};

//Prevent duplication.
if (!isNull (getAssignedCuratorLogic _unit)) exitWith{}; //already is a curator.

//Server for an empty curator space. (Assumes mission doesn't preallocate zeuses).
private _isValidCurator = false;
{
    _isValidCurator = false;
    if (isNull (getAssignedCuratorUnit _x)) then { 
        if (_x getVariable ["SNIP_ADMIN",false]) then {
            _isValidCurator = true;
        };
    } else {
        if (_x getVariable ["SNIP_ADMIN",false]) then {
            if (!isPlayer (getAssignedCuratorUnit _x)) then {
                _isValidCurator = true;
            };
        };
    };

    if (_isValidCurator) exitWith {
        unassignCurator _x;
        _unit assignCurator _x;

        [[_x],'tac1_admin_fnc_zeusSetupSync',_unit] spawn BIS_fnc_MP;  
    };
} forEach allCurators;

if (!_isValidCurator) then {

    if (isNil "f_var_sideCenter") then {
        f_var_sideCenter = createCenter sideLogic;
    };

    private _curator = (createGroup f_var_sideCenter) createUnit ["ModuleCurator_F",[0,0,0] , [], 0, ""];
    _curator setVariable ["owner",format["%1",_unit,true]];
    _curator setVariable ["Addons",3,true];
    _curator setVariable ["SNIP_ADMIN",true,true];
    _curator setVariable ["showNotification",false,true];
    


    // Do earlier to prevent the the notification from appearing.
    _unit assignCurator _curator;

    //Delay to prevent notification.
    //_curator spawn {
    //    sleep 6;
    private _units = allPlayers;
    {
        if (!alive _x or (side _x isEqualTo sideLogic)) then {
            _units set [_forEachIndex,0];  
        };
    } forEach allPlayers;
    _units = _units - [0];
    _curator addCuratorEditableObjects [_units,true]; 

    // };

    _curator setCuratorWaypointCost 0;
    {_curator setCuratorCoef [_x,0];} forEach ["place","edit","delete","destroy","group","synchronize"];

    [[_curator],'tac1_admin_fnc_zeusSetupSync',_unit] spawn BIS_fnc_MP;  
};