if !(isServer) exitWith {};

private ["_curator"];
_curator = getAssignedCuratorLogic (_this select 0);

{ if (side _x != sideLogic) then { _curator addCuratorEditableObjects [[_x],true]; }; } forEach allMissionObjects ""; 