

		//Error Handling
		if ((isDedicated) || (!hasInterface)) exitWith 
		{
			_txt = (format ["[RADIO] Warning: Attempted to launch canShowConfigure for %1 with no interface.",name player]);
			[_txt] remoteExec ["diag_log",0,false];
			false			
		};

		
		
		//Return variable
		_canShow = false;
		
		
		
		//Major variables
		_hasSideRadio = false;
		_vehicleRadio = false;		
		
		
		
		//Does unit have backpack consistent with side?
		_backPack = backPack player;
		_bagData = _backPack call rad_fnc_returnRadioSide;
		_hasAnyRadio = _bagData select 0;
		_radioSide = _bagData select 1;
		
		if ((_hasAnyRadio) && (_radioSide == side player)) then {_hasSideRadio = true;};
		
		
		
		//If in vehicle
		_vehicle = vehicle player;
		if (!(_vehicle == player)) then 
		{
		
			//Battlespace of vehicle
			if (!(_vehicle isKindOf "helicopter") || (_vehicle isKindOf "helicopter")) then
			{
				//Land vehicles.
				_commanders = fullCrew [_vehicle,"commander",false];
				if (player in _crew) then {_vehicleRadio = true;};
			}
			else
			{
				//Air vehicles.
				_allSeats = fullCrew [_vehicle,"",true];
				if ((count _allSeats) <= 2) then 
				{
					//Allow gunners and turrets as commanders if gunship, scout heli etc.
					_cargo = fullCrew [_vehicle,"cargo",false];
					if (!(player in _cargo)) then {_vehicleRadio = true;};
				}
				else
				{
					//Allow only driver and commander
					_drivers = fullCrew [_vehicle,"driver",false];
					_commanders = fullCrew [_vehicle,"commander",false];
					if ((player in _drivers) || (player in _commanders)) then {_vehicleRadio = true;};
				};
			};
		};
		
		
		
		//Final assessment:
		if ((_hasSideRadio) || (_vehicleRadio)) then {_canShow = true;};
		
		
		
		//Client-side variables, defined in initRadios (hopefully)
		_hasChannels = false;
		_activeChannels = [];
		if (!(isNil "rad_hasChannels")) then {_hasChannels = rad_hasChannels;};
		if (!(isNil "rad_activeChannels")) then {_hasChannels = rad_activeChannels;};

		
		
		//Make any adjustments
		if ((_canShow) && (!_hasChannels)) then 
		{
			//Restore any channels chosen to join. (set by configure radios GUI)
			if (_activeChannels > 0) then 
			{
				{
					_x radioChannelAdd [player];
				} forEach _activeChannels;
			};
			
			
			//Set has channels
			rad_hasChannels = true;
		};
		
		if ((!_canShow) && (_hasChannels)) then 
		{
			//Find any custom channels
			_createdChannels = missionNameSpace getVariable ["rad_createdChannels",[]];
		
			//Remove any custom channels
			if (_createdChannels > 0) then 
			{
				{
					_x radioChannelAdd [player];
				} forEach _createdChannels;
			};
			
			//Set has channels:
			rad_hasChannels = false;
		};
		
		
		
		//Return (controls if "configure radio" action shown)
		_canShow
		