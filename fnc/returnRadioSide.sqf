
	params
	[
		["_cfgStart","",[""]]
	];
	
	
	//Convert incoming to lower. (Allow case insensitive comparison)
	_cfg = toLower _cfgStart;
	
	
	
	//Array of config names
	_radiosBlufor = rad_radiosBlufor;
	_radiosOpfor = rad_radiosOpfor;
	_radiosIndfor = rad_radiosIndfor;
	_radiosCiv = rad_radiosCiv;
	
	
	
	//Default to open radio network
	_radioSide = civilian;
	_hasRadio = false;
	_matchCount = 0;
	
	
	
	//Find sides
	{
		_thisArray = _x select 0;
		_thisSide = _x select 1;
		
		if (_cfg in _thisArray) then 
		{
			_hasRadio = true;
			_radioSide = _thisSide;
			_matchCount = _matchCount + 1;
		};
	} 
	forEach 
	[
		[_radiosBlufor,west],
		[_radiosOpfor,east],
		[_radiosIndfor,independent],
		[_radiosCiv,civilian]
	];
	
	
	
	//Reset if in multiple sides
	if (_matchCount > 1) then {_radioSide = civilian;};
	
	
	
	//Return value:
	_return = [_hasRadio,_radioSide];