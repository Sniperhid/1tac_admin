disableSerialization;
private["_i","_control","_config","_title","_description","_subtitle"];
_control = ((findDisplay 1895) displayCtrl 1550);
_i = 0;
_config = missionconfigfile >> "CfgDebriefing";

while {_i < count _config} do {
    _title = getText (_config select _i >> "title");
    _description = getText (_config select _i >> "description");
    _subtitle = "";
    if (isClass (_config select _i >> "subtitle")) then {
        _subtitle = getText (_config select _i >> "subtitle");
    };
    
    if (_subtitle == "") then {
        if (_description == "") then {
            _control lbAdd (format ["%1",_title]);
        } else {
            _control lbAdd (format ["%1 - %2",_title,_description]);
        };
    } else {
        if (_description == "") then {
            _control lbAdd (format ["%1 - %2",_title,_subtitle]); 
        } else {
            _control lbAdd (format ["%1 - %2 - %3",_title,_subtitle,_description]); 
        };
    };
    _control lbSetData[_i,configName (_config select _i)];
    _i = _i + 1;
};

_control lbAdd "*** Arma 3 Vanilla Mission Success ***";
_control lbSetData[_i,"asdasdasdga"];

//Alive Players/Ending Data.
_control = ((findDisplay 1895) displayCtrl 1002);
_totalAI = 0; _totalPlayers = 0;
_west = 0; _east = 0; _resistance = 0; _civilian = 0; 
_westAI = 0; _eastAI = 0; _resistanceAI = 0; _civilianAI = 0;
{
    if (alive _x) then {
        if (isPlayer _x) then {
            _totalPlayers = _totalPlayers + 1;
            switch (side _x) do {
                case blufor: {_west = _west + 1;};
                case opfor: {_east = _east + 1;};
                case independent: {_resistance = _resistance + 1;};
                case civilian: {_civilian = _civilian + 1;};
            };
        } else {
            _totalAI = _totalAI + 1;
            switch (side _x) do {
                case blufor: {_westAI = _westAI + 1;};
                case opfor: {_eastAI = _eastAI + 1;};
                case independent: {_resistanceAI = _resistanceAI + 1;};
                case civilian: {_civilianAI = _civilianAI + 1;};
            };
        };
    };
} forEach allUnits;
_spectators = {isPlayer _x} count ([0,0,0] nearEntities ["VirtualCurator_F",50]);
_text = format["<t size='1.6'>Alive players: %1 Spectators: %2<br/>Total Alive AI: %3<br />",_totalPlayers,_spectators,_totalAI];
_text = _text + format ["<t color='#123ae3'>West Players: %1 Alive AI: %2</t><br />",_west,_westAI];
_text = _text + format ["<t color='#d81212'>East Players: %1 Alive AI: %2</t><br />",_east,_eastAI];
_text = _text + format ["<t color='#3cd321'>Ind. Players: %1 Alive AI: %2</t><br />",_resistance,_resistanceAI];
_text = _text + format ["<t color='#b121d3'>Civi Players: %1 Alive AI: %2</t><br /></t>",_civilian,_civilianAI];
_control ctrlSetStructuredText parseText _text;