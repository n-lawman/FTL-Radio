		
		//Error Handling
		if ((isDedicated) || (!hasInterface)) exitWith 
		{
			_txt = (format ["[RADIO] Warning: Attempted to addConfigureRadio for %1 with no interface.",name player]);
			[_txt] remoteExec ["diag_log",0,false];		
		};



		//Add action					[title, script, arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection, memoryPoint];
		player addAction 
		[
			"Configure radio",
			{_myForm = createDialog "RscMyRadioGUI";},
			nil,
			0,
			false,
			true,
			"",
			"call rad_fnc_canShowConfigure",
			-1,
			false,
			"",
			""
		];