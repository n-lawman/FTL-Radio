
		//Only run on server.
		if (!isServer) exitWith {};
		
		//Setup
		_channelData = execVM "radios\data\customChannels.sqf";
		_createdChannels = [[],[],[],[]];		//In order: blueFor, Opfor, Indfor, Civ. 		Format: 	[channelName,ID] per channel, per side
		
		
		//End if no custom channels
		if ((count _channelData) == 0) exitWith {};
		
		
		//Main process
		{
			_sideChannels = _x;
			_sideIndex = _forEachIndex;
			
			if ((count _sideChannels) > 0) then 
			{
				{
					//Create channel
					_channelId = radioChannelCreate _x;
					_channelName = _x select 1;
				
					_createdChannelsSide = _createdChannels select _sideIndex;
					_createdChannelsSide pushBackUnique [_channelName,_channelId];
					_createdChannels set [_sideIndex,_createdChannelsSide];

				} forEach _sideChannels;
			};
		} forEach _channelData;
		
		
		//Set missionNameSpace variable
		missionNameSpace setVariable ["rad_createdChannels",_createdChannels,true];		//Does this need to be set on all with JIP? Assuming yes.