
		//Function to convert user programmed array values to lower (allow case-insensitive use of in function)
		params
		[
			["_source","",[""]]
		];
		
		
		
		//Error handling:
		if (_source == "") exitWith 
		{
			_txt = (format ["[RADIO] Warning: %1 attempted to register array with no source file.",name player]);
			[_txt] remoteExec ["diag_log",0,false];		
		};
		
		
		
		//Gather source array:
		_rawArray = execVM _source;
		_return = [];
		
		
		//Pushback toLower values
		{
			if ((typeName _x) == "STRING") then 
			{
				_return pushBackUnique (toLower _x)
			}
			else
			{
				_txt = (format ["[RADIO] Warning: attempted to register array with non-string value.",name player]);
				[_txt] remoteExec ["diag_log",0,false];				
			};
			
		}forEach _rawArray;
		
		
		//Return value
		_return
		