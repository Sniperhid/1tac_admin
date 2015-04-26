if (hasInterface) then {
    [] spawn {
        waitUntil {sleep 0.5; !isNull (findDisplay 46)};
        (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call tac1_admin_fnc_keyPressed"];
    };
};

