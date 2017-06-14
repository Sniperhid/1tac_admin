
if (!isServer) exitWith {};

// Find player side
private _playerSide = west;
private _playerCount = {side _x == west && {isPlayer _x}} count (playableUnits + switchableUnits);

private _eastCount = {side _x == east && {isPlayer _x}} count (playableUnits + switchableUnits);
if (_eastCount > _playerCount) then {
    _playerSide = east;
    _playerCount = _eastCount;
};
private _indCount = {side _x == independent && {isPlayer _x}} count (playableUnits + switchableUnits);
if (_indCount > _playerCount) then {
    _playerSide = independent;
    _playerCount = _indCount;
};

// Find AI Sides.
private _aiSides = [west, east, independent] select {[_playerSide, _x] call BIS_fnc_sideIsEnemy};

private _hunters = allUnits select {(!isPlayer _x) && {(side _x) in _aiSides}};

// Setup units.
private _oldGroups = [];
{
    private _unit = _x;
    _oldGroups pushBackUnique (group _unit);
    
    [_unit] joinSilent grpNull;
    _unit setUnitPos "UP";
    _unit disableAI "SUPPRESSION";
    _unit disableAI "AUTOCOMBAT"; // Already applied at init but reapply.
    _unit setBehaviour "AWARE";
    _unit setSpeedMode "FULL";
    
    // Just in case MM went crazy.
    _unit enableAI "PATH";
    _unit enableAI "MOVE";

    _unit allowFleeing 0;
    doStop _unit;
    
    
} forEach _hunters;

// Cleanup groups no longer used.
{
    if (count (units _x) == 0) then {deleteGroup _x;};
} forEach (_oldGroups - [grpNull]);

// Spawn for performance reasons.



[_hunters, _playerSide] spawn {
    params ["_hunters", "_targetSide"];
    
    private _continue = true;
    private _targets = [];
    while {_continue} do {
        // CHEAT
        private _position = [0,0,0];
        private _targetUnits = allUnits select {side _x == _targetSide && isPlayer _x};
        {
            _position vectorAdd (getPos _x);
        } forEach _targetUnits;
        if (count _targetUnits > 0) then {
            _position vectorMultiply (1/(count _targetUnits));
        };
        
        // close Unit check
        private _isUnitClose = false;
        {
            if ((getPos _x) distance _position < 150) exitWith { _isUnitClose = true};
        } forEach _targetUnits;
        if (!_isUnitClose) then {
            if (count _targetUnits > 0) then {
                _position = getPos (_targetUnits select 0);
            };
        };
        //private _nTargets = (_position nearEntities ["CAManBase", _range]) select {side _x == _targetSide && alive _x && {!(_x getVariable ["ACE_isUnconscious", false])}};
        _targets = (_targets select {alive _x}); /* alive checks remove null */
        {
            private _unit = _x;
            private _closestTarget = _unit findNearestEnemy _unit;

            if (isNull _closestTarget) then {
                // Use another target we know about.
                private _closestFloat = 800;
                {
                    private _target = _x;
                    private _distanceToTarget = _target distance _unit;
                    if (_distanceToTarget < _closestFloat) then {
                        _closestTarget = _target;
                        _closestFloat = _distanceToTarget;
                    };
                } forEach _targets;
                
                // SEARCH: If we still don't have a target search.
                if (isNull _closestTarget) then {
                    if (_unit distance _position < 150) then {
                        private _dir = [_unit,_position] call BIS_fnc_dirTo;
                        _dir = _dir + (((round (random 1)) - 0.5) * 2) * (random 1 * random 1 * 180);
                        //private _dir = random 360;
                        _unit doMove (getPos (_unit) vectorAdd [(sin(_dir)*40), (cos(_dir)*40), 0]);
                    } else { // Outside move in.
                        _unit doMove _position;
                    };
                };
                /* CHEAT
                private _closestFloat = _range*3;
                {
                    _target = _x;
                    _distanceToTarget = _target distance _unit;
                    if (_distanceToTarget < _closestFloat) then {
                        _closestTarget = _target;
                        _closestFloat = _distanceToTarget;
                    };
                } forEach _nTargets;*/
            } else {
                if ((_targets pushBackUnique _closestTarget) != -1) then {
                    // Share this new contact with the rest of the group.
                    {
                        _x reveal [_closestTarget,1.5]; // Reveal side.
                    } forEach _hunters;
                    
                };
            };

            if (!isNull _closestTarget) then {
                _unit doMove (getPosATL _closestTarget); //doMove
            };

        } forEach _hunters;
        sleep 5;
        _hunters = _hunters select {alive _x};
        if (count _hunters == 0) exitWith {_continue = false;};
        sleep 10;
    };
};
