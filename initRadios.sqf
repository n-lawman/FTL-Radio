
	/*=====================================================================================================================================
	For all, including server:
	=====================================================================================================================================*/

		//Global functions (global to scope, NOT for every client etc. Still needs each machine to register the function)
		rad_fnc_returnRadioSide = compileFinal preprocessFileLineNumbers "radios\fnc\returnRadioSide.sqf";
		rad_fnc_registerArray = compileFinal preprocessFileLineNumbers "radios\fnc\registerArray.sqf";
		
		
		//Register data arrays
		rad_radiosBlufor = "radios\data\radiosBlufor.sqf" call rad_fnc_registerArray;
		rad_radiosOpfor = "radios\data\radiosOpfor.sqf" call rad_fnc_registerArray;
		rad_radiosIndfor = "radios\data\radiosIndfor.sqf" call rad_fnc_registerArray;
		rad_radiosCiv = "radios\data\radiosCiv.sqf" call rad_fnc_registerArray;


	



	/*=====================================================================================================================================
	For server only, regardless of dedicated or not
	=====================================================================================================================================*/
	if (isServer) then 
	{
		//Create custom radio channels, broadcasting array of createdIDs to clients
		execVM "radios\fnc\initChannels.sqf";
	};	






	/*=====================================================================================================================================
	For players with interface
	=====================================================================================================================================*/
	
	if ((!isDedicated) && (hasInterface)) then
	{
		//Set Variables
		rad_hasChannels = false;		//Parameter to determine if unit has channels added. Saves action conditions needlessly trying to add/remove channels if already has them.
		rad_activeChannels = [];		//Array of channels user has chosen to join	by channel ID (not name)
	
		//Initialise action for configure radio settings (also handles removal of channels in absense of pack)
		execVM "radios\actions\addConfigureRadio"
	
		//Initialise player for vanilla radio framework
		execVM "radios\actions\addHandset.sqf";
	};

	